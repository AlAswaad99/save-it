import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/core/models/core_models.dart';
import 'package:save_it/core/models/json_converters.dart';
import 'package:save_it/features/location/data/areas_repository.dart';
import 'package:save_it/features/location/data/device_location.dart';
import 'package:save_it/features/location/data/origin_store.dart';
import 'package:save_it/features/location/domain/search_origin.dart';
import 'package:save_it/features/onboarding/data/walkthrough_store.dart';
import 'package:save_it/features/onboarding/presentation/splash_screen.dart';
import 'package:save_it/main.dart';

void main() {
  const corniche = Area(
    id: 20,
    name: 'Corniche',
    location: GeoPoint(latitude: 24.47419, longitude: 54.34019),
    sort: 20,
  );

  Future<void> openApp(
    WidgetTester tester, {
    OriginStore? origin,
    DeviceLocation? device,
    AreasRepository? areas,
    Now? clock,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        key: UniqueKey(),
        overrides: [
          walkthroughStoreProvider.overrideWithValue(
            MemoryWalkthroughStore(seen: true),
          ),
          if (origin != null) originStoreProvider.overrideWithValue(origin),
          if (device != null) deviceLocationProvider.overrideWithValue(device),
          if (areas != null) areasRepositoryProvider.overrideWithValue(areas),
          if (clock != null) clockProvider.overrideWithValue(clock),
        ],
        child: const SaveItApp(),
      ),
    );
    await tester.pump();
    await tester.pump(SplashScreen.hold);
    await tester.pumpAndSettle();
  }

  testWidgets('denying location opens the area picker', (tester) async {
    await openApp(
      tester,
      origin: MemoryOriginStore(),
      device: FakeDeviceLocation(granted: false),
      areas: _FixedAreas([corniche]),
    );

    await tester.tap(find.text('Allow location'));
    await tester.pumpAndSettle();

    expect(find.text('Choose your area'), findsOneWidget);
    expect(find.text('Corniche'), findsOneWidget);
  });

  testWidgets('a position that does not arrive opens the area picker', (
    tester,
  ) async {
    await openApp(
      tester,
      origin: MemoryOriginStore(),
      device: FakeDeviceLocation(),
    );

    await tester.tap(find.text('Allow location'));
    await tester.pumpAndSettle();

    expect(find.text('Choose your area'), findsOneWidget);
  });

  testWidgets('an allowed position is kept and shown after a restart', (
    tester,
  ) async {
    final store = MemoryOriginStore();
    final device = FakeDeviceLocation(
      point: const GeoPoint(latitude: 24.5, longitude: 54.5),
    );
    await openApp(
      tester,
      origin: store,
      device: device,
      clock: () => DateTime.utc(2026, 11, 23, 12),
    );

    await tester.tap(find.text('Allow location'));
    await tester.pumpAndSettle();

    expect(find.text('Current location'), findsOneWidget);
    expect(find.byKey(const Key('origin-24.5-54.5')), findsOneWidget);
    expect(store.origin?.isGps, isTrue);

    await openApp(tester, origin: store, device: device);

    expect(find.text('See food venues near you.'), findsNothing);
    expect(find.text('Current location'), findsOneWidget);
  });

  testWidgets('choosing an area is kept after a restart', (tester) async {
    final store = MemoryOriginStore();
    await openApp(
      tester,
      origin: store,
      areas: _FixedAreas([corniche]),
    );

    await tester.tap(find.text('Choose area instead'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Corniche'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Show restaurants'));
    await tester.pumpAndSettle();

    expect(find.text('Corniche'), findsWidgets);
    expect(store.origin?.areaName, 'Corniche');
    expect(store.origin?.isGps, isFalse);

    await openApp(tester, origin: store);

    expect(find.text('See food venues near you.'), findsNothing);
    expect(find.text('Corniche'), findsWidgets);
  });

  testWidgets('a GPS origin older than 10 minutes refreshes on resume', (
    tester,
  ) async {
    final now = DateTime.utc(2026, 11, 23, 12);
    final device = FakeDeviceLocation(
      point: const GeoPoint(latitude: 24.6, longitude: 54.6),
    );
    final store = MemoryOriginStore()
      ..origin = SearchOrigin(
        latitude: 24.5,
        longitude: 54.5,
        isGps: true,
        fixedAt: now.subtract(const Duration(minutes: 11)),
      );

    await openApp(
      tester,
      origin: store,
      device: device,
      clock: () => now,
    );

    expect(device.requests, 0);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    expect(device.requests, 1);
    expect(find.byKey(const Key('origin-24.6-54.6')), findsOneWidget);
  });
}

class _FixedAreas implements AreasRepository {
  _FixedAreas(this.areas);

  final List<Area> areas;

  @override
  Future<List<Area>> list() async => areas;
}
