import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repository_search/ui/page/repository_view/repository_view.dart';
import 'package:github_repository_search/ui/page/route_error_view/route_error_view.dart';
import 'package:github_repository_search/ui/page/search_view/search_view.dart';
import 'package:github_repository_search/ui/page/setting_view/settings_view.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

// ref: https://zenn.dev/susatthi/articles/20220801-135028-flutter-go-router-builder

@TypedGoRoute<HomeRoute>(
  path: '/',
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context) => const SearchPage();
}

@TypedGoRoute<RepositoryRoute>(
  path: '/repository/:id',
)
class RepositoryRoute extends GoRouteData {
  const RepositoryRoute({
    required this.id,
  });

  final int id;
  @override
  Widget build(BuildContext context) {
    return RepositoryView(id: id);
  }
}

@TypedGoRoute<SettingRoute>(
  path: '/setting',
)
class SettingRoute extends GoRouteData {
  const SettingRoute();

  @override
  Widget build(BuildContext context) {
    return const SettingView();
  }
}

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
    errorBuilder: (context, state) => RouteErrorScreen(state.error!),
  ),
);
