import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:syarah_app_task/features/todos/data/dto/todo_dto.dart';

part 'todo_model.freezed.dart';

@freezed
abstract class TodoModel with _$TodoModel {
  const factory TodoModel({
    required int id,
    required int userId,
    required String title,
    required bool completed,
  }) = _TodoModel;

  factory TodoModel.fromDto(TodoDto dto) => TodoModel(
        id: dto.id ?? 0,
        userId: dto.userId ?? 0,
        title: dto.title ?? '',
        completed: dto.completed ?? false,
      );
}
