import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'page/route_error_view/route_error_view.dart';
import 'page/search_view/search_view.dart';
import 'page/setting_view/language_choice_page.dart';
import 'page/setting_view/settings_view.dart';
import 'page/setting_view/theme_choice_page.dart';

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

@TypedGoRoute<SettingRoute>(
  path: '/setting',
  routes: [
    TypedGoRoute<ThemeChoiceRoute>(
      path: 'theme',
    ),
    TypedGoRoute<LanguageChoiceRoute>(
      path: 'language',
    ),
  ],
)
class SettingRoute extends GoRouteData {
  const SettingRoute();

  @override
  Widget build(BuildContext context) {
    return const SettingView();
  }
}

class ThemeChoiceRoute extends GoRouteData {
  const ThemeChoiceRoute();

  @override
  Widget build(BuildContext context) {
    return const ThemeChoicePage();
  }
}

class LanguageChoiceRoute extends GoRouteData {
  const LanguageChoiceRoute();

  @override
  Widget build(BuildContext context) {
    return const LanguageChoicePage();
  }
}

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: kDebugMode,
    errorBuilder: (context, state) => RouteErrorScreen(state.error!),
  ),
);
