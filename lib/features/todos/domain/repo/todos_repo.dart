import 'package:syarah_app_task/core/network/api_result.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';

/// Abstract contract for the todos data source. Framework-free.
///
/// Implemented by `TodosRepoImpl` in the data layer; consumed directly by
/// presentation notifiers (no separate use-case layer).
abstract interface class TodosRepo {
  /// Fetches all todos.
  Future<ApiResult<List<TodoModel>>> getTodos();

  /// Creates a todo. jsonplaceholder echoes the created item back.
  Future<ApiResult<TodoModel>> createTodo({
    required String title,
    required bool completed,
  });

  /// Updates an existing todo.
  Future<ApiResult<TodoModel>> updateTodo(TodoModel todo);

  /// Deletes a todo by [id].
  Future<ApiResult<bool>> deleteTodo(int id);
}
