import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:syarah_app_task/core/network/network_exception.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';

part 'todo_list_state.freezed.dart';

/// Lifecycle status of the todo list screen.
enum TodoListStatus { initial, loading, loaded, error }

/// Immutable UI state for the todo list.
@freezed
abstract class TodoListState with _$TodoListState {
  const factory TodoListState({
    @Default(TodoListStatus.initial) TodoListStatus status,
    @Default(<TodoModel>[]) List<TodoModel> todos,
    @Default('') String searchQuery,
    NetworkException? error,
  }) = _TodoListState;

  const TodoListState._();

  bool get isLoading => status == TodoListStatus.loading;
  bool get hasError => status == TodoListStatus.error;

  /// Todos after applying the client-side title search.
  List<TodoModel> get filteredTodos {
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return todos;
    return todos
        .where((todo) => todo.title.toLowerCase().contains(query))
        .toList();
  }

  /// True when loading finished but there are no todos at all.
  bool get isEmpty =>
      status == TodoListStatus.loaded && todos.isEmpty;

  /// True when there are todos but the current search matches none.
  bool get hasNoSearchResults =>
      status == TodoListStatus.loaded &&
      todos.isNotEmpty &&
      filteredTodos.isEmpty;
}
