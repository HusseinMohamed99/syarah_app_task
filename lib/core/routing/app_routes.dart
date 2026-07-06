/// Centralized route path constants consumed by the typed go_router
/// route declarations.
class AppPaths {
  const AppPaths._();

  /// Todo list (root).
  static const String todoList = '/';

  /// Add a new todo (relative to [todoList]).
  static const String addTodo = 'add';

  /// Edit an existing todo by id (relative to [todoList]).
  static const String editTodo = 'edit/:id';
}
