import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/config/env.dart';
import 'package:save_it/core/dev/widget_gallery_screen.dart';
import 'package:save_it/core/router/app_router.dart';
import 'package:save_it/core/theme/app_theme.dart';
import 'package:save_it/core/widgets/save_it_badge.dart';
import 'package:save_it/core/widgets/save_it_button.dart';
import 'package:save_it/core/widgets/save_it_card.dart';
import 'package:save_it/core/widgets/save_it_empty_state.dart';
import 'package:save_it/core/widgets/save_it_error_state.dart';
import 'package:save_it/core/widgets/save_it_loading_state.dart';
import 'package:save_it/core/widgets/save_it_logo.dart';
import 'package:save_it/core/widgets/save_it_offline_banner.dart';
import 'package:save_it/core/widgets/save_it_text_field.dart';
import 'package:save_it/features/onboarding/presentation/splash_screen.dart';
import 'package:save_it/l10n/app_localizations.dart';
import 'package:save_it/main.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('gallery route is registered only for the dev flavor', () {
    final dev = ProviderContainer();
    addTearDown(dev.dispose);
    final prod = ProviderContainer(
      overrides: [
        envProvider.overrideWithValue(
          const Env(flavor: 'prod', supabaseUrl: '', supabaseAnonKey: ''),
        ),
      ],
    );
    addTearDown(prod.dispose);

    expect(_hasGallery(dev.read(appRouterProvider)), isTrue);
    expect(_hasGallery(prod.read(appRouterProvider)), isFalse);
  });

  testWidgets('gallery shows every core widget and the logo', (tester) async {
    await _pumpGallery(tester);
    expect(find.byType(SaveItLogo), findsOneWidget);
    expect(find.bySemanticsLabel('Save It logo'), findsOneWidget);
    expect(find.byType(SaveItButton), findsWidgets);
    expect(find.text('Primary'), findsWidgets);
    expect(find.text('Secondary'), findsOneWidget);
    expect(find.text('Text'), findsOneWidget);
    expect(find.text('Destructive'), findsOneWidget);
    expect(find.text('Disabled'), findsWidgets);
    expect(find.bySemanticsLabel('Loading'), findsWidgets);
    expect(find.byType(SaveItTextField), findsNWidgets(3));
    expect(find.text('Enter a valid email.'), findsOneWidget);
    expect(find.byType(SaveItCard), findsOneWidget);
    expect(find.text('Restaurant'), findsOneWidget);
    expect(
      find.byType(SaveItBadge),
      findsNWidgets(SaveItBadgeKind.values.length),
    );
    expect(find.text('Reserved'), findsOneWidget);
    expect(find.text('Collected'), findsOneWidget);
    expect(find.text('Cancelled'), findsOneWidget);
    expect(find.text('Expired'), findsOneWidget);
    expect(find.text('Draft'), findsOneWidget);
    expect(find.text('Live'), findsOneWidget);
    expect(find.text('Sold out'), findsOneWidget);
    expect(find.text('Hidden'), findsOneWidget);
    expect(find.byType(SaveItEmptyState), findsOneWidget);
    expect(find.byType(SaveItErrorState), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
    expect(find.byType(SaveItLoadingState), findsOneWidget);
    expect(find.byType(SaveItOfflineBanner), findsOneWidget);
    expect(
      find.text('You are offline. A saved pickup pass still opens.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('gallery stays within bounds at 1.3 text scale', (tester) async {
    await _pumpGallery(tester, textScale: 1.3);
    expect(find.byType(SaveItOfflineBanner), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dev profile opens the gallery', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: SaveItApp()));
    await _leaveSplash(tester);
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Widget gallery'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(WidgetGalleryScreen), findsOneWidget);
    expect(find.byType(SaveItLogo), findsOneWidget);
  });

  testWidgets('prod profile has no gallery link', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          envProvider.overrideWithValue(
            const Env(flavor: 'prod', supabaseUrl: '', supabaseAnonKey: ''),
          ),
        ],
        child: const SaveItApp(),
      ),
    );
    await _leaveSplash(tester);
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Widget gallery'), findsNothing);
    expect(find.text('Sign in to manage your account.'), findsOneWidget);
  });
}

Future<void> _pumpGallery(WidgetTester tester, {double textScale = 1}) async {
  await tester.binding.setSurfaceSize(const Size(390, 844));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    MaterialApp(
      theme: buildAppTheme(),
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(textScale)),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const WidgetGalleryScreen(),
    ),
  );
}

Future<void> _leaveSplash(WidgetTester tester) async {
  await tester.pump(SplashScreen.hold);
  await tester.pumpAndSettle();
}

bool _hasGallery(GoRouter router) {
  return router.configuration.routes.whereType<GoRoute>().any(
    (route) => route.path == '/dev/gallery',
  );
}
