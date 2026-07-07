import 'package:json_annotation/json_annotation.dart';

part 'todo_dto.g.dart';

@JsonSerializable()
class TodoDto {
  const TodoDto({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory TodoDto.fromJson(Map<String, dynamic> json) =>
      _$TodoDtoFromJson(json);

  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  Map<String, dynamic> toJson() => _$TodoDtoToJson(this);
}
