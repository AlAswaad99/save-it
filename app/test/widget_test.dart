import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/core/session/app_session.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/features/onboarding/presentation/splash_screen.dart';
import 'package:save_it/main.dart';

void main() {
  testWidgets('guest shell opens on Explore after the splash', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: SaveItApp()));
    expect(find.byKey(SplashScreen.screenKey), findsOneWidget);

    await tester.pump(SplashScreen.hold);
    await tester.pump();

    expect(find.text('Explore'), findsWidgets);
    expect(find.text('Orders'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Nearby surplus will show up here.'), findsOneWidget);
  });

  testWidgets('a restaurant session leaves the splash for business', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appSessionProvider.overrideWith(
            () => _FixedSession(
              const AppSession.restaurant(restaurantTermsAccepted: false),
            ),
          ),
        ],
        child: const SaveItApp(),
      ),
    );

    await tester.pump(SplashScreen.hold);
    await tester.pump();

    expect(find.byKey(const Key('business-terms')), findsOneWidget);
    expect(find.text('Explore'), findsNothing);
  });
}

class _FixedSession extends AppSessionController {
  _FixedSession(this.initial);

  final AppSession initial;

  @override
  AppSession build() => initial;
}
