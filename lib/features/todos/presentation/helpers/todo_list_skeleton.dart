import 'package:flutter/material.dart';
import 'package:syarah_app_task/core/widgets/loading/app_skeleton.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';
import 'package:syarah_app_task/features/todos/presentation/widgets/todo_list_item.dart';

/// Skeleton placeholder shown while the todo list is loading. Renders a
/// handful of fake [TodoListItem]s under [AppSkeleton]'s shimmer.
class TodoListSkeleton extends StatelessWidget {
  const TodoListSkeleton({this.itemCount = 8, super.key});

  final int itemCount;

  static const TodoModel _placeholder = TodoModel(
    id: 0,
    userId: 0,
    title: 'Placeholder todo title example',
    completed: false,
  );

  @override
  Widget build(BuildContext context) {
    return AppSkeleton(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) =>
            const TodoListItem(todo: _placeholder),
      ),
    );
  }
}
