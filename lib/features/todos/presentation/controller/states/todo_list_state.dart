import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:syarah_app_task/core/network/network_exception.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';

part 'todo_list_state.freezed.dart';

enum TodoListStatus { initial, loading, loaded, error }

@freezed
abstract class TodoListState with _$TodoListState {
  const factory TodoListState({
    @Default(TodoListStatus.initial) TodoListStatus status,
    @Default(<TodoModel>[]) List<TodoModel> todos,
    @Default('') String searchQuery,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
    NetworkException? error,
  }) = _TodoListState;

  const TodoListState._();

  bool get isLoading => status == TodoListStatus.loading;
  bool get hasError => status == TodoListStatus.error;
  bool get isSearching => searchQuery.trim().isNotEmpty;

  List<TodoModel> get filteredTodos {
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return todos;
    return todos
        .where((todo) => todo.title.toLowerCase().contains(query))
        .toList();
  }

  bool get isEmpty =>
      status == TodoListStatus.loaded && todos.isEmpty;

  bool get hasNoSearchResults =>
      status == TodoListStatus.loaded &&
      todos.isNotEmpty &&
      filteredTodos.isEmpty;
}
