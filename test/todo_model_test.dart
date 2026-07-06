import 'package:flutter_test/flutter_test.dart';
import 'package:syarah_app_task/features/todos/data/dto/todo_dto.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';

void main() {
  group('TodoModel.fromDto', () {
    test('maps all fields from a fully populated DTO', () {
      const dto = TodoDto(
        userId: 3,
        id: 42,
        title: 'Buy milk',
        completed: true,
      );

      final model = TodoModel.fromDto(dto);

      expect(model.id, 42);
      expect(model.userId, 3);
      expect(model.title, 'Buy milk');
      expect(model.completed, isTrue);
    });

    test('applies safe defaults for null DTO fields', () {
      const dto = TodoDto();

      final model = TodoModel.fromDto(dto);

      expect(model.id, 0);
      expect(model.userId, 0);
      expect(model.title, isEmpty);
      expect(model.completed, isFalse);
    });
  });
}
