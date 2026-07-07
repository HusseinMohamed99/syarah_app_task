import 'package:json_annotation/json_annotation.dart';

part 'todo_request.g.dart';

@JsonSerializable(createFactory: false)
class TodoRequest {
  const TodoRequest({
    required this.title,
    required this.completed,
    this.userId = 1,
  });

  final String title;
  final bool completed;
  final int userId;

  Map<String, dynamic> toJson() => _$TodoRequestToJson(this);
}
