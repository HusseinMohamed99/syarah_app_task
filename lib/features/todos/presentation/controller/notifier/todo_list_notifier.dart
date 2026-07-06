import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syarah_app_task/core/config/app_constants.dart';
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
  static const int _limit = AppConstants.todosPageLimit;

  @override
  TodoListState build() {
    _loadFirstPage();
    return const TodoListState(status: TodoListStatus.loading);
  }

  TodosRepo get _repo => ref.read(todosRepoProvider);

  /// Loads page 1 and replaces the list. Surfaces a full-screen error when
  /// nothing could be loaded.
  Future<void> _loadFirstPage() async {
    final result = await _repo.getTodos(page: 1, limit: _limit);
    if (!ref.mounted) return;
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
        state = state.copyWith(
          status: TodoListStatus.error,
          error: error,
        );
    }
  }

  /// Reloads from scratch, showing the skeleton again (used on retry).
  Future<void> retry() async {
    state = state.copyWith(status: TodoListStatus.loading, error: null);
    await _loadFirstPage();
  }

  /// Pull-to-refresh: resets back to page 1, keeping existing data visible
  /// until the fresh page arrives.
  Future<void> refresh() async {
    final result = await _repo.getTodos(page: 1, limit: _limit);
    if (!ref.mounted) return;
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
        // Keep the current list if we still have one; only fail hard when
        // there is nothing to show.
        if (state.todos.isEmpty) {
          state = state.copyWith(
            status: TodoListStatus.error,
            error: error,
          );
        }
    }
  }

  /// Loads the next page and appends it. No-op while already loading, when
  /// there are no more pages, or while the user is searching.
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
        // Stop the spinner; the user can scroll again to retry.
        state = state.copyWith(isLoadingMore: false);
    }
  }

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
