import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';
import 'package:syarah_app_task/core/helpers/extensions/text_styles_extension.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';

/// A single todo card with a colored status accent, an animated custom
/// checkmark and a completed/pending badge. Swipe to delete, tap to edit.
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
    final accent =
        todo.completed ? ColorManager.success : ColorManager.primary;

    return Dismissible(
      key: ValueKey<int>(todo.id),
      direction: onDelete == null
          ? DismissDirection.none
          : DismissDirection.endToStart,
      onDismissed: (_) => onDelete?.call(),
      background: _buildDeleteBackground(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: kSpacingS.h),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: ColorManager.surface,
            borderRadius: BorderRadius.circular(kRadiusL.r),
            boxShadow: [
              BoxShadow(
                color: ColorManager.shimmerBase.withValues(alpha: 0.5),
                blurRadius: 12.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(kRadiusL.r),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(width: 5.w, color: accent),
                  Expanded(child: _buildContent(context, accent)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Color accent) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(kSpacingL.w),
          child: Row(
            children: [
              _AnimatedCheck(
                completed: todo.completed,
                accent: accent,
                onTap: onToggle,
              ),
              SizedBox(width: kSpacingL.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 250),
                      style: (context.bodyLarge ?? const TextStyle()).copyWith(
                        fontWeight: FontWeight.w600,
                        color: todo.completed
                            ? ColorManager.textSecondary
                            : ColorManager.textPrimary,
                        decoration: todo.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: ColorManager.textSecondary,
                      ),
                      child: Text(todo.title),
                    ),
                    SizedBox(height: kSpacingS.h),
                    Row(
                      children: [
                        _StatusBadge(completed: todo.completed),
                        SizedBox(width: kSpacingS.w),
                        _UserTag(userId: todo.userId),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: ColorManager.disabled,
                size: kIconM.r,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSpacingS.h),
      child: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: kSpacingXL.w),
        decoration: BoxDecoration(
          color: ColorManager.error,
          borderRadius: BorderRadius.circular(kRadiusL.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.delete_outline_rounded,
              color: ColorManager.textOnPrimary,
              size: kIconM.r,
            ),
            SizedBox(width: kSpacingS.w),
            Text(
              'Delete',
              style: TextStyle(
                color: ColorManager.textOnPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animated circular checkbox that fills and shows a check when completed.
class _AnimatedCheck extends StatelessWidget {
  const _AnimatedCheck({
    required this.completed,
    required this.accent,
    this.onTap,
  });

  final bool completed;
  final Color accent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: 28.r,
        height: 28.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: completed ? accent : Colors.transparent,
          border: Border.all(
            color: completed ? accent : ColorManager.disabled,
            width: 2.w,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: completed
              ? Icon(
                  Icons.check_rounded,
                  key: const ValueKey<bool>(true),
                  size: kIconS.r,
                  color: ColorManager.textOnPrimary,
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}

/// Small pill showing whether the todo is done or still pending.
class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.completed});

  final bool completed;

  @override
  Widget build(BuildContext context) {
    final color = completed ? ColorManager.success : ColorManager.warning;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingS.w,
        vertical: kSpacingXXS.h,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(kRadiusS.r),
      ),
      child: Text(
        completed ? 'Done' : 'Pending',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}

/// Subtle tag showing which user the todo belongs to.
class _UserTag extends StatelessWidget {
  const _UserTag({required this.userId});

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.person_outline_rounded,
          size: kIconS.r,
          color: ColorManager.textSecondary,
        ),
        SizedBox(width: kSpacingXXS.w),
        Text(
          'User $userId',
          style: context.bodySmall?.copyWith(
            color: ColorManager.textSecondary,
          ),
        ),
      ],
    );
  }
}
