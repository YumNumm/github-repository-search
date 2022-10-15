import 'package:flutter/cupertino.dart';
import 'package:flutter_enginner_codecheck/ui/page/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

// ref: https://zenn.dev/susatthi/articles/20220801-135028-flutter-go-router-builder

@TypedGoRoute<HomeRoute>(
  path: '/',
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context) => const HomePage();
}

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: $appRoutes,
  ),
);
