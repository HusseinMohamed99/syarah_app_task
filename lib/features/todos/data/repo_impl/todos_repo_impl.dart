import 'package:syarah_app_task/core/config/app_constants.dart';
import 'package:syarah_app_task/core/network/api_result.dart';
import 'package:syarah_app_task/core/network/base_api_client.dart';
import 'package:syarah_app_task/features/todos/data/dto/todo_dto.dart';
import 'package:syarah_app_task/features/todos/data/dto/todo_request.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';
import 'package:syarah_app_task/features/todos/domain/repo/todos_repo.dart';

/// Concrete [TodosRepo] backed by the raw jsonplaceholder endpoints.
class TodosRepoImpl implements TodosRepo {
  const TodosRepoImpl(this._client);

  final BaseApiClient _client;

  @override
  Future<ApiResult<List<TodoModel>>> getTodos() {
    return _client.getRaw<List<TodoModel>>(
      AppConstants.todosEndpoint,
      fromJson: (data) => (data as List<dynamic>)
          .map((e) => TodoModel.fromDto(
                TodoDto.fromJson(e as Map<String, dynamic>),
              ))
          .toList(),
    );
  }

  @override
  Future<ApiResult<TodoModel>> createTodo({
    required String title,
    required bool completed,
  }) {
    return _client.postRaw<TodoModel>(
      AppConstants.todosEndpoint,
      data: TodoRequest(title: title, completed: completed).toJson(),
      fromJson: (data) => TodoModel.fromDto(
        TodoDto.fromJson(data as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<ApiResult<TodoModel>> updateTodo(TodoModel todo) {
    return _client.putRaw<TodoModel>(
      '${AppConstants.todosEndpoint}/${todo.id}',
      data: TodoRequest(
        title: todo.title,
        completed: todo.completed,
        userId: todo.userId,
      ).toJson(),
      fromJson: (data) => TodoModel.fromDto(
        TodoDto.fromJson(data as Map<String, dynamic>),
      ).copyWith(id: todo.id),
    );
  }

  @override
  Future<ApiResult<bool>> deleteTodo(int id) {
    return _client.deleteRaw('${AppConstants.todosEndpoint}/$id');
  }
}
