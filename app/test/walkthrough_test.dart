import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/features/location/data/origin_store.dart';
import 'package:save_it/features/onboarding/data/walkthrough_store.dart';
import 'package:save_it/features/onboarding/presentation/splash_screen.dart';
import 'package:save_it/features/onboarding/presentation/welcome_screen.dart';
import 'package:save_it/main.dart';

void main() {
  const slide1 =
      'Join many others in reducing food waste as food venues around Abu Dhabi share their surplus food every evening at a discounted rate! Why let good food go to waste?';
  const slide2 =
      'Select what you want and get a unique pick up code, in just a few taps!';
  const slide3 =
      'Simply go to your selected food venue, show your unique code between the pick up time & collect your order!';

  testWidgets('first launch shows the three slides once', (tester) async {
    final store = MemoryWalkthroughStore();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          walkthroughStoreProvider.overrideWithValue(store),
          originStoreProvider.overrideWithValue(MemoryOriginStore()),
        ],
        child: const SaveItApp(),
      ),
    );
    await tester.pump();
    await tester.pump(SplashScreen.hold);
    await tester.pumpAndSettle();

    expect(find.byKey(WelcomeScreen.screenKey), findsOneWidget);
    expect(find.text('Save food, Save money!'), findsOneWidget);
    expect(find.text(slide1), findsOneWidget);
    expect(
      find.image(const AssetImage('assets/onboarding/Cycle.png')),
      findsOneWidget,
    );

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Make your reservation'), findsOneWidget);
    expect(find.text(slide2), findsOneWidget);
    expect(
      find.image(const AssetImage('assets/onboarding/La point.png')),
      findsOneWidget,
    );

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    expect(find.text('Collect and pay at location'), findsOneWidget);
    expect(find.text(slide3), findsOneWidget);
    expect(
      find.image(const AssetImage('assets/onboarding/La pay.png')),
      findsOneWidget,
    );

    await tester.tap(find.text('Get started'));
    await tester.pumpAndSettle();

    expect(find.text('See food venues near you.'), findsWidgets);
    expect(
      find.text(
        'Allow location to see all the food venues with discounts available today!',
      ),
      findsOneWidget,
    );
    expect(
      find.image(const AssetImage('assets/onboarding/image_7e411891.jpg')),
      findsOneWidget,
    );
    expect(store.seen, isTrue);
  });

  testWidgets('a later launch skips the walkthrough and the sheet', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          walkthroughStoreProvider.overrideWithValue(
            MemoryWalkthroughStore(seen: true),
          ),
          originStoreProvider.overrideWithValue(MemoryOriginStore()),
        ],
        child: const SaveItApp(),
      ),
    );
    await tester.pump();
    await tester.pump(SplashScreen.hold);
    await tester.pumpAndSettle();
    expect(find.byKey(WelcomeScreen.screenKey), findsNothing);
    expect(find.text('See food venues near you.'), findsWidgets);
    expect(find.text('Nearby surplus will show up here.'), findsOneWidget);
  });

  testWidgets('Skip opens the location sheet and does not show again', (
    tester,
  ) async {
    final store = MemoryWalkthroughStore();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          walkthroughStoreProvider.overrideWithValue(store),
          originStoreProvider.overrideWithValue(MemoryOriginStore()),
        ],
        child: const SaveItApp(),
      ),
    );
    await tester.pump();
    await tester.pump(SplashScreen.hold);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('location-sheet')), findsOneWidget);
    expect(store.seen, isTrue);
  });
}
