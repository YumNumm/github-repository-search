// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<GoRoute> get $appRoutes => [
      $homeRoute,
      $repositoryRoute,
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
