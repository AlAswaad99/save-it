import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/core/session/app_session.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/features/auth/data/email_auth.dart';
import 'package:save_it/features/auth/data/public_settings.dart';
import 'package:save_it/features/business/data/restaurant_terms.dart';
import 'package:save_it/features/location/data/origin_store.dart';
import 'package:save_it/features/location/domain/search_origin.dart';
import 'package:save_it/features/onboarding/data/walkthrough_store.dart';
import 'package:save_it/features/onboarding/presentation/splash_screen.dart';
import 'package:save_it/main.dart';

void main() {
  Future<void> open(WidgetTester tester, {required EmailAuth auth}) async {
    await tester.pumpWidget(
      ProviderScope(
        key: UniqueKey(),
        overrides: [
          walkthroughStoreProvider.overrideWithValue(
            MemoryWalkthroughStore(seen: true),
          ),
          originStoreProvider.overrideWithValue(_origin),
          emailAuthProvider.overrideWithValue(auth),
          publicSettingsProvider.overrideWithValue(
            const FixedPublicSettings('contact@arisehub.org'),
          ),
          restaurantTermsProvider.overrideWithValue(
            MemoryRestaurantTerms('Olive Grove Bakery'),
          ),
        ],
        child: const SaveItApp(),
      ),
    );
    await tester.pump();
    await tester.pump(SplashScreen.hold);
    await tester.pumpAndSettle();
  }

  Future<void> sendCode(WidgetTester tester, String email) async {
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Restaurant? Log in to Business mode.'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), email);
    await tester.tap(find.text('Send code'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '123456');
    await tester.pumpAndSettle();
  }

  testWidgets('a customer email cannot enter Business mode', (tester) async {
    final auth = FakeEmailAuth();
    await open(tester, auth: auth);
    await sendCode(tester, 'ada@example.com');

    expect(auth.lastAllowCreate, isFalse);
    expect(find.text('You cannot do that with this account.'), findsOneWidget);
    expect(find.byKey(const Key('business-today')), findsNothing);
    final context = tester.element(
      find.text('You cannot do that with this account.'),
    );
    expect(
      ProviderScope.containerOf(context).read(appSessionProvider).role,
      AppRole.guest,
    );
  });

  testWidgets('the first restaurant login must accept the terms', (
    tester,
  ) async {
    final auth = FakeEmailAuth(
      role: AppRole.restaurant,
      restaurantTermsAccepted: false,
    );
    await open(tester, auth: auth);
    await sendCode(tester, 'kitchen@example.com');

    expect(find.byKey(const Key('business-terms')), findsOneWidget);
    expect(find.text('Final legal text supplied by Arise Ltd.'), findsOneWidget);
    expect(find.textContaining('Olive Grove Bakery'), findsWidgets);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    await tester.tap(find.text('Accept and continue'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('business-today')), findsOneWidget);
    final context = tester.element(find.byKey(const Key('business-today')));
    final session = ProviderScope.containerOf(context).read(appSessionProvider);
    expect(session.role, AppRole.restaurant);
    expect(session.restaurantTermsAccepted, isTrue);
  });

  testWidgets('a returning restaurant skips the terms', (tester) async {
    await open(
      tester,
      auth: FakeEmailAuth(
        role: AppRole.restaurant,
        restaurantTermsAccepted: true,
      ),
    );
    await sendCode(tester, 'kitchen@example.com');

    expect(find.byKey(const Key('business-today')), findsOneWidget);
    expect(find.byKey(const Key('business-terms')), findsNothing);
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
