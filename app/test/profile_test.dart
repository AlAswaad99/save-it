import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/features/location/data/origin_store.dart';
import 'package:save_it/features/location/domain/search_origin.dart';
import 'package:save_it/features/onboarding/data/walkthrough_store.dart';
import 'package:save_it/features/onboarding/presentation/splash_screen.dart';
import 'package:save_it/features/profile/data/account_directory.dart';
import 'package:save_it/features/profile/data/external_links.dart';
import 'package:save_it/features/profile/domain/account_profile.dart';
import 'package:save_it/main.dart';

void main() {
  testWidgets('name and phone update, and legal and support links open', (
    tester,
  ) async {
    final directory = MemoryAccountDirectory(
      const AccountProfile(
        fullName: 'Sara Ahmed',
        email: 'sara.ahmed@gmail.com',
        phone: '+971501234567',
        supportEmail: 'contact@arisehub.org',
      ),
    );
    final links = MemoryExternalLinks();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          walkthroughStoreProvider.overrideWithValue(
            MemoryWalkthroughStore(seen: true),
          ),
          originStoreProvider.overrideWithValue(_origin),
          accountDirectoryProvider.overrideWithValue(directory),
          externalLinksProvider.overrideWithValue(links),
        ],
        child: const SaveItApp(),
      ),
    );
    await tester.pump();
    await tester.pump(SplashScreen.hold);
    await tester.pumpAndSettle();

    final context = tester.element(find.text('Explore').first);
    ProviderScope.containerOf(context)
        .read(appSessionProvider.notifier)
        .signedInCustomer(profileComplete: true);
    await tester.pump();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Sara Ahmed'), findsOneWidget);
    expect(find.text('sara.ahmed@gmail.com'), findsOneWidget);
    expect(find.text('+971 50 123 4567'), findsOneWidget);
    expect(find.text('contact@arisehub.org'), findsOneWidget);

    await tester.tap(find.text('contact@arisehub.org'));
    await tester.pump();
    expect(links.mailed, 'contact@arisehub.org');

    await tester.tap(find.text('Terms and Conditions'));
    await tester.pumpAndSettle();
    expect(find.byType(AppBar), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Privacy Policy'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Privacy Policy'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    final emailField = tester.widget<TextField>(
      find.descendant(
        of: find.byKey(const Key('email-locked')),
        matching: find.byType(TextField),
      ),
    );
    expect(emailField.readOnly, isTrue);
    expect(emailField.controller?.text, 'sara.ahmed@gmail.com');

    await tester.enterText(find.byType(TextField).first, 'Sara Ali');
    await tester.enterText(find.byType(TextField).at(1), '501112233');
    await tester.tap(find.text('Save changes'));
    await tester.pumpAndSettle();

    expect(find.text('Sara Ali'), findsOneWidget);
    expect(find.text('+971 50 111 2233'), findsOneWidget);
    expect(find.text('sara.ahmed@gmail.com'), findsOneWidget);
    expect(directory.savedName, 'Sara Ali');
    expect(directory.savedPhone, '+971501112233');
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
