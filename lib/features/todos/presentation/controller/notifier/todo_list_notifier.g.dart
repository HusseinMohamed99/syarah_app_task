// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Owns the [TodoListState]: fetching, searching and mutating todos.
///
/// jsonplaceholder does not persist mutations, so local state is updated
/// optimistically after a successful call instead of refetching.

@ProviderFor(TodoListNotifier)
const todoListProvider = TodoListNotifierProvider._();

/// Owns the [TodoListState]: fetching, searching and mutating todos.
///
/// jsonplaceholder does not persist mutations, so local state is updated
/// optimistically after a successful call instead of refetching.
final class TodoListNotifierProvider
    extends $NotifierProvider<TodoListNotifier, TodoListState> {
  /// Owns the [TodoListState]: fetching, searching and mutating todos.
  ///
  /// jsonplaceholder does not persist mutations, so local state is updated
  /// optimistically after a successful call instead of refetching.
  const TodoListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todoListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todoListNotifierHash();

  @$internal
  @override
  TodoListNotifier create() => TodoListNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodoListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodoListState>(value),
    );
  }
}

String _$todoListNotifierHash() => r'bcf6d66a719a52cf8755d593e65f8c3f2517f16e';

/// Owns the [TodoListState]: fetching, searching and mutating todos.
///
/// jsonplaceholder does not persist mutations, so local state is updated
/// optimistically after a successful call instead of refetching.

abstract class _$TodoListNotifier extends $Notifier<TodoListState> {
  TodoListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TodoListState, TodoListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TodoListState, TodoListState>,
              TodoListState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
