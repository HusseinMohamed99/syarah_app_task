import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syarah_app_task/core/network/app_provider.dart';
import 'package:syarah_app_task/features/todos/data/repo_impl/todos_repo_impl.dart';
import 'package:syarah_app_task/features/todos/domain/repo/todos_repo.dart';

part 'todos_data_source.g.dart';

/// Functional provider exposing the [TodosRepo] to the presentation layer.
@riverpod
TodosRepo todosRepo(Ref ref) {
  return TodosRepoImpl(ref.watch(baseApiClientProvider));
}
