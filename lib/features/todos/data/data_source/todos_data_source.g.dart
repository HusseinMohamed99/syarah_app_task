// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Functional provider exposing the [TodosRepo] to the presentation layer.

@ProviderFor(todosRepo)
const todosRepoProvider = TodosRepoProvider._();

/// Functional provider exposing the [TodosRepo] to the presentation layer.

final class TodosRepoProvider
    extends $FunctionalProvider<TodosRepo, TodosRepo, TodosRepo>
    with $Provider<TodosRepo> {
  /// Functional provider exposing the [TodosRepo] to the presentation layer.
  const TodosRepoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todosRepoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todosRepoHash();

  @$internal
  @override
  $ProviderElement<TodosRepo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TodosRepo create(Ref ref) {
    return todosRepo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodosRepo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodosRepo>(value),
    );
  }
}

String _$todosRepoHash() => r'afeba1560536a3c1ce66ef0a48c5e9db9eded6b2';
