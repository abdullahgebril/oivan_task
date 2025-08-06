enum AppRoute {
  splash('/splash'),
  home('/'),
  users('/users'),
  bookmarks('/bookmarks'),
  userReputation('/user-reputation/:userId');

  final String path;

  const AppRoute(this.path);
}

class AppRouteConst {
  AppRouteConst._();

  static const String splash = '/splash';
  static const String home = '/';
  static const String users = '/users';
  static const String bookmarks = '/bookmarks';
  static const String userReputation = '/user-reputation/:userId';

  static String userReputationWithId(int userId) => '/user-reputation/$userId';
}
