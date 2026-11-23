import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/config/env.dart';
import 'package:save_it/core/dev/widget_gallery_screen.dart';
import 'package:save_it/core/router/app_redirect.dart';
import 'package:save_it/core/router/app_shell.dart';
import 'package:save_it/core/router/route_placeholder.dart';
import 'package:save_it/core/session/app_session_controller.dart';
import 'package:save_it/features/discovery/presentation/explore_screen.dart';
import 'package:save_it/features/location/presentation/area_screen.dart';
import 'package:save_it/features/onboarding/data/walkthrough_store.dart';
import 'package:save_it/features/onboarding/presentation/splash_screen.dart';
import 'package:save_it/features/onboarding/presentation/welcome_screen.dart';
import 'package:save_it/features/orders/presentation/orders_screen.dart';
import 'package:save_it/features/profile/presentation/profile_screen.dart';
import 'package:save_it/l10n/app_localizations.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final isDev = ref.watch(envProvider).isDev;
  final refresh = ValueNotifier<int>(0);
  ref
    ..listen(appSessionProvider, (_, _) {
      refresh.value++;
    })
    ..listen(walkthroughSeenProvider, (_, _) {
      refresh.value++;
    })
    ..onDispose(refresh.dispose);
  final router = GoRouter(
    initialLocation: '/splash',
    refreshListenable: refresh,
    redirect: (_, state) {
      final seen = ref.read(walkthroughSeenProvider);
      if (!seen.hasValue) {
        return null;
      }
      return resolveAppRedirect(
        state.uri,
        ref.read(appSessionProvider),
        walkthroughSeen: seen.requireValue,
      );
    },
    routes: buildAppRoutes(isDev: isDev),
  );
  ref.onDispose(router.dispose);
  return router;
});

List<RouteBase> buildAppRoutes({required bool isDev}) {
  return [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/area',
      builder: (context, state) => const AreaScreen(),
    ),
    GoRoute(
      path: '/auth/email',
      builder: (context, state) => RoutePlaceholder(
        screenKey: const Key('auth-email'),
        title: _l10n(context).tabProfile,
      ),
    ),
    GoRoute(
      path: '/auth/code',
      builder: (context, state) => RoutePlaceholder(
        screenKey: const Key('auth-code'),
        title: _l10n(context).tabProfile,
      ),
    ),
    GoRoute(
      path: '/auth/profile',
      builder: (context, state) => RoutePlaceholder(
        screenKey: const Key('auth-profile'),
        title: _l10n(context).tabProfile,
      ),
    ),
    GoRoute(
      path: '/basket',
      builder: (context, state) => RoutePlaceholder(
        screenKey: const Key('basket'),
        title: _l10n(context).tabExplore,
      ),
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => RoutePlaceholder(
        screenKey: const Key('checkout'),
        title: _l10n(context).tabOrders,
      ),
    ),
    GoRoute(
      path: '/restaurant/:id',
      builder: (context, state) => RoutePlaceholder(
        screenKey: const Key('restaurant'),
        title: _l10n(context).tabExplore,
      ),
    ),
    GoRoute(
      path: '/orders/:id',
      builder: (context, state) => RoutePlaceholder(
        screenKey: const Key('order-detail'),
        title: _l10n(context).tabOrders,
      ),
    ),
    GoRoute(
      path: '/profile/edit',
      builder: (context, state) => RoutePlaceholder(
        screenKey: const Key('profile-edit'),
        title: _l10n(context).tabProfile,
      ),
    ),
    GoRoute(
      path: '/business/login',
      builder: (context, state) => RoutePlaceholder(
        screenKey: const Key('business-login'),
        title: _l10n(context).tabProfile,
      ),
    ),
    GoRoute(
      path: '/business/terms',
      builder: (context, state) => RoutePlaceholder(
        screenKey: const Key('business-terms'),
        title: _l10n(context).tabProfile,
      ),
    ),
    GoRoute(
      path: '/business/today',
      builder: (context, state) => RoutePlaceholder(
        screenKey: const Key('business-today'),
        title: _l10n(context).tabExplore,
      ),
    ),
    if (isDev)
      GoRoute(
        path: '/dev/gallery',
        builder: (context, state) => const WidgetGalleryScreen(),
      ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/explore',
              builder: (context, state) => const ExploreScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/orders',
              builder: (context, state) => const OrdersScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ];
}

AppLocalizations _l10n(BuildContext context) {
  final localizations = AppLocalizations.of(context);
  if (localizations == null) {
    throw StateError('AppLocalizations is not installed');
  }
  return localizations;
}
