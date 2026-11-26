import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/core/session/app_session.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/features/auth/data/auth_events.dart';
import 'package:save_it/features/basket/data/basket_store.dart';
import 'package:save_it/features/basket/domain/basket.dart';
import 'package:save_it/features/location/data/origin_store.dart';
import 'package:save_it/features/location/domain/search_origin.dart';
import 'package:save_it/features/onboarding/data/walkthrough_store.dart';
import 'package:save_it/features/onboarding/presentation/splash_screen.dart';
import 'package:save_it/main.dart';

void main() {
  const line = BasketLine(
    listingId: 'listing-1',
    qty: 2,
    name: 'Chicken bowl',
    price: '18.00',
  );

  test('the basket is kept after logout and a new scope', () async {
    final store = MemoryBasketStore();
    final auth = ScriptedAuthEvents();
    final first = ProviderContainer(
      overrides: [
        basketStoreProvider.overrideWithValue(store),
        authEventsProvider.overrideWithValue(auth),
      ],
    );
    addTearDown(first.dispose);
    await first.read(basketProvider.future);
    await first
        .read(basketProvider.notifier)
        .save(const Basket(restaurantId: 'restaurant-1', lines: [line]));
    first
        .read(appSessionProvider.notifier)
        .signedInCustomer(profileComplete: true);
    await first.read(appSessionProvider.notifier).signOut();

    expect(first.read(appSessionProvider).role, AppRole.guest);
    expect(auth.signOuts, 1);
    expect(first.read(basketProvider).requireValue.lines.single.qty, 2);

    final second = ProviderContainer(
      overrides: [
        basketStoreProvider.overrideWithValue(store),
        authEventsProvider.overrideWithValue(auth),
      ],
    );
    addTearDown(second.dispose);
    final restored = await second.read(basketProvider.future);
    expect(restored.lines.single.listingId, 'listing-1');
    expect(restored.restaurantId, 'restaurant-1');
  });

  test('an expired session returns to guest and keeps the basket', () async {
    final store = MemoryBasketStore();
    final auth = ScriptedAuthEvents();
    final container = ProviderContainer(
      overrides: [
        basketStoreProvider.overrideWithValue(store),
        authEventsProvider.overrideWithValue(auth),
      ],
    );
    addTearDown(container.dispose);
    await container.read(basketProvider.future);
    await container
        .read(basketProvider.notifier)
        .save(const Basket(restaurantId: 'restaurant-1', lines: [line]));
    container
        .read(appSessionProvider.notifier)
        .signedInCustomer(profileComplete: true);

    auth.emit(const AppSession.guest());
    await pumpEventQueue();

    expect(container.read(appSessionProvider).role, AppRole.guest);
    expect(container.read(basketProvider).requireValue.lines, hasLength(1));
  });

  testWidgets('logout from Profile returns to Explore as a guest', (
    tester,
  ) async {
    final auth = ScriptedAuthEvents();
    final basket = MemoryBasketStore();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          walkthroughStoreProvider.overrideWithValue(
            MemoryWalkthroughStore(seen: true),
          ),
          originStoreProvider.overrideWithValue(_origin),
          authEventsProvider.overrideWithValue(auth),
          basketStoreProvider.overrideWithValue(basket),
        ],
        child: const SaveItApp(),
      ),
    );
    await tester.pump();
    await tester.pump(SplashScreen.hold);
    await tester.pumpAndSettle();

    final context = tester.element(find.text('Explore').first);
    final container = ProviderScope.containerOf(context);
    container
        .read(appSessionProvider.notifier)
        .signedInCustomer(profileComplete: true);
    await container
        .read(basketProvider.notifier)
        .save(const Basket(restaurantId: 'restaurant-1', lines: [line]));
    await tester.pump();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('log-out')));
    await tester.pumpAndSettle();

    expect(find.text('Nearby surplus will show up here.'), findsOneWidget);
    expect(auth.signOuts, 1);
    expect(container.read(appSessionProvider).role, AppRole.guest);
    expect(container.read(basketProvider).requireValue.lines.single.name, 'Chicken bowl');
  });

  testWidgets('a stored customer session is restored after the splash', (
    tester,
  ) async {
    final auth = ScriptedAuthEvents(
      restored: const AppSession.customer(profileComplete: true),
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          walkthroughStoreProvider.overrideWithValue(
            MemoryWalkthroughStore(seen: true),
          ),
          originStoreProvider.overrideWithValue(_origin),
          authEventsProvider.overrideWithValue(auth),
        ],
        child: const SaveItApp(),
      ),
    );
    await tester.pump();
    await tester.pump(SplashScreen.hold);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Log out'), findsOneWidget);
    expect(find.text("You're browsing as a guest."), findsNothing);
  });
}

final _origin = MemoryOriginStore()
  ..origin = SearchOrigin(
    latitude: 24.47419,
    longitude: 54.34019,
    isGps: false,
    fixedAt: DateTime.utc(2026, 11, 23),
    areaName: 'Corniche',
  );

class ScriptedAuthEvents implements AuthEvents {
  ScriptedAuthEvents({this.restored});

  final AppSession? restored;
  final _changes = StreamController<AppSession>.broadcast();
  var signOuts = 0;

  void emit(AppSession session) => _changes.add(session);

  @override
  Stream<AppSession> changes() => _changes.stream;

  @override
  Future<AppSession?> restore() async => restored;

  @override
  Future<void> signOut() async {
    signOuts += 1;
  }
}
