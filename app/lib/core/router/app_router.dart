import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_it/core/config/env.dart';
import 'package:save_it/core/dev/widget_gallery_screen.dart';
import 'package:save_it/core/router/app_shell.dart';
import 'package:save_it/features/discovery/presentation/explore_screen.dart';
import 'package:save_it/features/orders/presentation/orders_screen.dart';
import 'package:save_it/features/profile/presentation/profile_screen.dart';

/// Guest shell: Explore, Orders, Profile.
///
/// Role redirects (restaurant to `/business`, incomplete profile to
/// `/auth/profile`) are added with sign-in. Guests stay on these tabs.
final appRouterProvider = Provider<GoRouter>((ref) {
  final isDev = ref.watch(envProvider).isDev;
  final router = GoRouter(
    initialLocation: '/explore',
    routes: [
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
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
