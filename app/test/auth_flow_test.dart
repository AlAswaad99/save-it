import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/features/auth/data/email_auth.dart';
import 'package:save_it/features/auth/data/profile_writer.dart';
import 'package:save_it/features/location/data/origin_store.dart';
import 'package:save_it/features/location/domain/search_origin.dart';
import 'package:save_it/features/onboarding/data/walkthrough_store.dart';
import 'package:save_it/features/onboarding/presentation/splash_screen.dart';
import 'package:save_it/main.dart';

void main() {
  final origin = MemoryOriginStore()
    ..origin = SearchOrigin(
      latitude: 24.47,
      longitude: 54.34,
      isGps: false,
      fixedAt: DateTime.utc(2026, 11, 23),
      areaName: 'Corniche',
    );

  Future<void> openShell(
    WidgetTester tester, {
    required EmailAuth auth,
    ProfileWriter? writer,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        key: UniqueKey(),
        overrides: [
          walkthroughStoreProvider.overrideWithValue(
            MemoryWalkthroughStore(seen: true),
          ),
          originStoreProvider.overrideWithValue(origin),
          emailAuthProvider.overrideWithValue(auth),
          if (writer != null) profileWriterProvider.overrideWithValue(writer),
        ],
        child: const SaveItApp(),
      ),
    );
    await tester.pump();
    await tester.pump(SplashScreen.hold);
    await tester.pumpAndSettle();
  }

  testWidgets('a new email completes the profile and returns to orders', (
    tester,
  ) async {
    final auth = FakeEmailAuth();
    final writer = FakeProfileWriter();
    await openShell(tester, auth: auth, writer: writer);

    await tester.tap(find.text('Orders'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with email'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with email').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'new@example.com');
    await tester.pump();
    await tester.tap(find.text('Send code'));
    await tester.pumpAndSettle();

    expect(find.text('Code sent to n***@example.com.'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, '123456');
    await tester.pumpAndSettle();

    expect(find.text('Almost done.'), findsOneWidget);
    await tester.enterText(find.byType(TextField).at(0), 'Ada');
    await tester.enterText(find.byType(TextField).at(1), '501234567');
    await tester.pump();
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(writer.fullName, 'Ada');
    expect(writer.phone, '+971501234567');
    expect(writer.accepted, isTrue);
    expect(find.text('Your reservations will show up here.'), findsOneWidget);
  });

  testWidgets('a returning email skips the profile and returns to profile', (
    tester,
  ) async {
    await openShell(
      tester,
      auth: FakeEmailAuth(profileComplete: true),
      writer: FakeProfileWriter(),
    );

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with email'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with email').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'ada@example.com');
    await tester.pump();
    await tester.tap(find.text('Send code'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '123456');
    await tester.pumpAndSettle();

    expect(find.text('Almost done.'), findsNothing);
    expect(find.text('Log out'), findsOneWidget);
  });

  testWidgets('a wrong code and a rate limit show their messages', (
    tester,
  ) async {
    final auth = FakeEmailAuth(
      verifyFailure: const AuthFailure(AuthFailureKind.wrongOrExpired),
    );
    await openShell(tester, auth: auth);

    await tester.tap(find.text('Orders'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with email'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue with email').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'ada@example.com');
    await tester.pump();
    await tester.tap(find.text('Send code'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, '000000');
    await tester.pumpAndSettle();

    expect(find.text('Incorrect or expired code'), findsOneWidget);
    expect(find.text('Check the code or request a new one.'), findsWidgets);

    auth
      ..verifyFailure = null
      ..sendFailure = const AuthFailure(
        AuthFailureKind.rateLimited,
        retryAfterMinutes: 20,
      );
    await tester.tap(find.text('Resend code'));
    await tester.pumpAndSettle();

    expect(find.text('You can request up to 3 codes per hour.'), findsOneWidget);
    expect(find.text('Try again in 20 min'), findsOneWidget);
  });
}
