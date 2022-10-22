// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $homeRoute,
      $repositoryRoute,
      $settingRoute,
    ];

GoRoute get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

GoRoute get $repositoryRoute => GoRouteData.$route(
      path: '/repository/:id',
      factory: $RepositoryRouteExtension._fromState,
    );

extension $RepositoryRouteExtension on RepositoryRoute {
  static RepositoryRoute _fromState(GoRouterState state) => RepositoryRoute(
        id: int.parse(state.params['id']!),
      );

  String get location => GoRouteData.$location(
        '/repository/${Uri.encodeComponent(id.toString())}',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

GoRoute get $settingRoute => GoRouteData.$route(
      path: '/setting',
      factory: $SettingRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'theme',
          factory: $ThemeChoiceRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'language',
          factory: $LanguageChoiceRouteExtension._fromState,
        ),
      ],
    );

extension $SettingRouteExtension on SettingRoute {
  static SettingRoute _fromState(GoRouterState state) => const SettingRoute();

  String get location => GoRouteData.$location(
        '/setting',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $ThemeChoiceRouteExtension on ThemeChoiceRoute {
  static ThemeChoiceRoute _fromState(GoRouterState state) =>
      const ThemeChoiceRoute();

  String get location => GoRouteData.$location(
        '/setting/theme',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}

extension $LanguageChoiceRouteExtension on LanguageChoiceRoute {
  static LanguageChoiceRoute _fromState(GoRouterState state) =>
      const LanguageChoiceRoute();

  String get location => GoRouteData.$location(
        '/setting/language',
      );

  void go(BuildContext context) => context.go(location, extra: this);

  void push(BuildContext context) => context.push(location, extra: this);
}
