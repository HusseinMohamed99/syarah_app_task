import 'package:syarah_app_task/core/network/api_result.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';

abstract interface class TodosRepo {

  Future<ApiResult<List<TodoModel>>> getTodos({
    required int page,
    required int limit,
  });

  Future<ApiResult<TodoModel>> createTodo({
    required String title,
    required bool completed,
  });

  Future<ApiResult<TodoModel>> updateTodo(TodoModel todo);

  Future<ApiResult<bool>> deleteTodo(int id);
}
