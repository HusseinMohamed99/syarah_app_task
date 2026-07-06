import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syarah_app_task/core/network/api_result.dart';
import 'package:syarah_app_task/core/network/network_exception.dart';
import 'package:syarah_app_task/features/todos/data/data_source/todos_data_source.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';
import 'package:syarah_app_task/features/todos/domain/repo/todos_repo.dart';
import 'package:syarah_app_task/features/todos/presentation/controller/states/todo_list_state.dart';

part 'todo_list_notifier.g.dart';

/// Owns the [TodoListState]: fetching, searching and mutating todos.
///
/// jsonplaceholder does not persist mutations, so local state is updated
/// optimistically after a successful call instead of refetching.
@riverpod
class TodoListNotifier extends _$TodoListNotifier {
  @override
  TodoListState build() {
    _fetchTodos();
    return const TodoListState(status: TodoListStatus.loading);
  }

  TodosRepo get _repo => ref.read(todosRepoProvider);

  Future<void> _fetchTodos() async {
    final result = await _repo.getTodos();
    if (!ref.mounted) return;
    switch (result) {
      case Success(:final data):
        state = state.copyWith(
          status: TodoListStatus.loaded,
          todos: data,
          error: null,
        );
      case Failure(:final error):
        state = state.copyWith(
          status: TodoListStatus.error,
          error: error,
        );
    }
  }

  /// Reloads from scratch, showing the skeleton again (used on retry).
  Future<void> retry() async {
    state = state.copyWith(status: TodoListStatus.loading, error: null);
    await _fetchTodos();
  }

  /// Pull-to-refresh: keeps existing data visible while reloading.
  Future<void> refresh() => _fetchTodos();

  /// Updates the client-side search query.
  void search(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Creates a todo and prepends it locally on success.
  ///
  /// Returns `null` on success, or the [NetworkException] on failure.
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

  /// Updates a todo and replaces it locally on success.
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

  /// Toggles the completed flag of [todo] locally after a successful call.
  Future<NetworkException?> toggleCompleted(TodoModel todo) {
    return updateTodo(todo.copyWith(completed: !todo.completed));
  }

  /// Deletes a todo and removes it locally on success.
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

  /// Looks up a todo by id from the current state.
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
