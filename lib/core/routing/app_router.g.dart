// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$todoListRoute];

RouteBase get $todoListRoute => GoRouteData.$route(
  path: '/',
  factory: $TodoListRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'add', factory: $AddTodoRoute._fromState),
    GoRouteData.$route(path: 'edit/:id', factory: $EditTodoRoute._fromState),
  ],
);

mixin $TodoListRoute on GoRouteData {
  static TodoListRoute _fromState(GoRouterState state) => const TodoListRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $AddTodoRoute on GoRouteData {
  static AddTodoRoute _fromState(GoRouterState state) => const AddTodoRoute();

  @override
  String get location => GoRouteData.$location('/add');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $EditTodoRoute on GoRouteData {
  static EditTodoRoute _fromState(GoRouterState state) =>
      EditTodoRoute(id: int.parse(state.pathParameters['id']!));

  EditTodoRoute get _self => this as EditTodoRoute;

  @override
  String get location => GoRouteData.$location(
    '/edit/${Uri.encodeComponent(_self.id.toString())}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
