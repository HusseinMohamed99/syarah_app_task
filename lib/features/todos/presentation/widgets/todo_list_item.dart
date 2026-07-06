import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';
import 'package:syarah_app_task/core/helpers/extensions/text_styles_extension.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';

/// A single todo row: swipe-to-delete, tap to edit, checkbox to toggle.
class TodoListItem extends StatelessWidget {
  const TodoListItem({
    required this.todo,
    this.onTap,
    this.onToggle,
    this.onDelete,
    super.key,
  });

  final TodoModel todo;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey<int>(todo.id),
      direction: onDelete == null
          ? DismissDirection.none
          : DismissDirection.endToStart,
      onDismissed: (_) => onDelete?.call(),
      background: _buildDeleteBackground(),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: kSpacingXS.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kRadiusM.r),
          side: const BorderSide(color: ColorManager.border),
        ),
        child: ListTile(
          onTap: onTap,
          leading: Checkbox(
            value: todo.completed,
            onChanged: onToggle == null ? null : (_) => onToggle?.call(),
            activeColor: ColorManager.primary,
          ),
          title: Text(
            todo.title,
            style: context.bodyLarge?.copyWith(
              decoration:
                  todo.completed ? TextDecoration.lineThrough : null,
              color: todo.completed
                  ? ColorManager.textSecondary
                  : ColorManager.textPrimary,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right_rounded,
            color: ColorManager.textSecondary,
            size: kIconM.r,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: kSpacingXL.w),
      decoration: BoxDecoration(
        color: ColorManager.error,
        borderRadius: BorderRadius.circular(kRadiusM.r),
      ),
      child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
    );
  }
}
