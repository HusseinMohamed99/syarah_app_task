import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syarah_app_task/core/routing/app_routes.dart';
import 'package:syarah_app_task/features/todos/presentation/views/add_edit_todo_view.dart';
import 'package:syarah_app_task/features/todos/presentation/views/todo_list_view.dart';

part 'app_router.g.dart';

/// Root route: the todo list, with add / edit as child routes.
@TypedGoRoute<TodoListRoute>(
  path: AppPaths.todoList,
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<AddTodoRoute>(path: AppPaths.addTodo),
    TypedGoRoute<EditTodoRoute>(path: AppPaths.editTodo),
  ],
)
class TodoListRoute extends GoRouteData with $TodoListRoute {
  const TodoListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TodoListView();
}

class AddTodoRoute extends GoRouteData with $AddTodoRoute {
  const AddTodoRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AddEditTodoView();
}

class EditTodoRoute extends GoRouteData with $EditTodoRoute {
  const EditTodoRoute({required this.id});

  final int id;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      AddEditTodoView(todoId: id);
}

/// Exposes the app's [GoRouter] as a hand-written provider.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppPaths.todoList,
    routes: $appRoutes,
  );
});
