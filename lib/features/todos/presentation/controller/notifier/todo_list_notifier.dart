import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syarah_app_task/core/config/app_constants.dart';
import 'package:syarah_app_task/core/network/api_result.dart';
import 'package:syarah_app_task/core/network/network_exception.dart';
import 'package:syarah_app_task/features/todos/data/data_source/todos_data_source.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';
import 'package:syarah_app_task/features/todos/domain/repo/todos_repo.dart';
import 'package:syarah_app_task/features/todos/presentation/controller/states/todo_list_state.dart';

part 'todo_list_notifier.g.dart';

@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  static const int _limit = AppConstants.todosPageLimit;

  @override
  TodoListState build() {
    _loadFirstPage();
    return const TodoListState(status: TodoListStatus.loading);
  }

  TodosRepo get _repo => ref.read(todosRepoProvider);

  Future<void> _loadFirstPage() async {
    final result = await _repo.getTodos(page: 1, limit: _limit);
    if (!ref.mounted) return;
    _applyFirstPage(result);
  }

  void _applyFirstPage(
    ApiResult<List<TodoModel>> result, {
    bool keepDataOnError = false,
  }) {
    switch (result) {
      case Success(:final data):
        state = state.copyWith(
          status: TodoListStatus.loaded,
          todos: data,
          currentPage: 1,
          hasMore: data.length >= _limit,
          isLoadingMore: false,
          error: null,
        );
      case Failure(:final error):
        if (!keepDataOnError || state.todos.isEmpty) {
          state = state.copyWith(
            status: TodoListStatus.error,
            error: error,
          );
        }
    }
  }

  Future<void> retry() async {
    state = state.copyWith(status: TodoListStatus.loading, error: null);
    await _loadFirstPage();
  }

  Future<void> refresh() async {
    final result = await _repo.getTodos(page: 1, limit: _limit);
    if (!ref.mounted) return;
    _applyFirstPage(result, keepDataOnError: true);
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore ||
        !state.hasMore ||
        state.isSearching ||
        state.status != TodoListStatus.loaded) {
      return;
    }

    state = state.copyWith(isLoadingMore: true);
    final nextPage = state.currentPage + 1;
    final result = await _repo.getTodos(page: nextPage, limit: _limit);
    if (!ref.mounted) return;
    switch (result) {
      case Success(:final data):
        state = state.copyWith(
          todos: [...state.todos, ...data],
          currentPage: nextPage,
          hasMore: data.length >= _limit,
          isLoadingMore: false,
        );
      case Failure():

        state = state.copyWith(isLoadingMore: false);
    }
  }

  void search(String query) {
    state = state.copyWith(searchQuery: query);
  }

  Future<NetworkException?> addTodo({
    required String title,
    required bool completed,
  }) async {
    final result = await _repo.createTodo(title: title, completed: completed);
    if (!ref.mounted) return null;
    switch (result) {
      case Success(:final data):
        final created = data.copyWith(id: _nextLocalId());
        state = state.copyWith(todos: [created, ...state.todos]);
        return null;
      case Failure(:final error):
        return error;
    }
  }

  Future<NetworkException?> updateTodo(TodoModel todo) async {
    final result = await _repo.updateTodo(todo);
    if (!ref.mounted) return null;
    switch (result) {
      case Success(:final data):
        state = state.copyWith(
          todos: [
            for (final item in state.todos)
              if (item.id == data.id) data else item,
          ],
        );
        return null;
      case Failure(:final error):
        return error;
    }
  }

  Future<NetworkException?> toggleCompleted(TodoModel todo) {
    return updateTodo(todo.copyWith(completed: !todo.completed));
  }

  Future<NetworkException?> deleteTodo(int id) async {
    final result = await _repo.deleteTodo(id);
    if (!ref.mounted) return null;
    switch (result) {
      case Success():
        state = state.copyWith(
          todos: state.todos.where((todo) => todo.id != id).toList(),
        );
        return null;
      case Failure(:final error):
        return error;
    }
  }

  TodoModel? todoById(int id) {
    for (final todo in state.todos) {
      if (todo.id == id) return todo;
    }
    return null;
  }

  int _nextLocalId() {
    final maxId = state.todos.fold<int>(
      0,
      (previous, todo) => todo.id > previous ? todo.id : previous,
    );
    return maxId + 1;
  }
}
