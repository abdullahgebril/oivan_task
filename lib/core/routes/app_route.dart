import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oivan_task/core/routes/app_route_const.dart';
import 'package:oivan_task/features/bookmarks/presentation/screens/bookmarks_screen.dart';
import 'package:oivan_task/features/home/presentation/screens/home_screen.dart';
import 'package:oivan_task/features/splash/splash_screen.dart';
import 'package:oivan_task/features/users/presentation/screens/user_reputation_screen.dart';
import 'package:oivan_task/features/users/presentation/screens/users_screen.dart';
import 'package:oivan_task/shared/page_not_found_screen.dart';

class GoRouteProvider {
  GoRouteProvider._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;
  static GlobalKey<NavigatorState> get shellNavigatorKey => _shellNavigatorKey;

  static final routerProvider = Provider<GoRouter>((ref) {
    return GoRouter(
      initialLocation: AppRoute.splash.path,
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: AppRoute.splash.path,
          name: AppRoute.splash.name,
          builder: (context, state) => const SplashScreen(),
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return ScaffoldWithNavBar(child: child);
          },
          routes: [
            GoRoute(
              path: AppRoute.users.path,
              name: AppRoute.users.name,
              builder: (context, state) => const UsersScreen(),
            ),
            GoRoute(
              path: AppRoute.bookmarks.path,
              name: AppRoute.bookmarks.name,
              builder: (context, state) => const BookmarksScreen(),
            ),
          ],
        ),
        GoRoute(
          path: AppRoute.userReputation.path,
          name: AppRoute.userReputation.name,
          builder: (context, state) {
            final userId = int.parse(state.pathParameters['userId']!);
            return UserReputationScreen(userId: userId);
          },
        ),
      ],
      errorBuilder: (_, state) => const PageNotFoundScreen(),
    );
  });
}
