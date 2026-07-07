import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syarah_app_task/core/network/api_result.dart';
import 'package:syarah_app_task/core/network/network_exception.dart';
import 'package:syarah_app_task/core/widgets/errors/custom_error_widget.dart';
import 'package:syarah_app_task/features/todos/data/data_source/todos_data_source.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';
import 'package:syarah_app_task/features/todos/domain/repo/todos_repo.dart';
import 'package:syarah_app_task/main.dart';

class _OfflineTodosRepo implements TodosRepo {
  @override
  Future<ApiResult<List<TodoModel>>> getTodos({
    required int page,
    required int limit,
  }) async {
    return const ApiResult.failure(NetworkException.noInternetConnection());
  }

  @override
  Future<ApiResult<TodoModel>> createTodo({
    required String title,
    required bool completed,
  }) =>
      throw UnimplementedError();

  @override
  Future<ApiResult<TodoModel>> updateTodo(TodoModel todo) =>
      throw UnimplementedError();

  @override
  Future<ApiResult<bool>> deleteTodo(int id) => throw UnimplementedError();
}

void main() {
  testWidgets('offline failure renders CustomErrorWidget with the English '
      'message', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          todosRepoProvider.overrideWithValue(_OfflineTodosRepo()),
        ],
        child: const TodoApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(CustomErrorWidget), findsOneWidget);
    expect(find.textContaining('No internet connection'), findsOneWidget);
  });
}
