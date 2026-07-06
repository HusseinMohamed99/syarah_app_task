import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';
import 'package:syarah_app_task/core/helpers/extensions/snack_bar_extension.dart';
import 'package:syarah_app_task/core/helpers/extensions/text_styles_extension.dart';
import 'package:syarah_app_task/core/helpers/extensions/widget_extensions.dart';
import 'package:syarah_app_task/core/helpers/functions/network_error_helper.dart';
import 'package:syarah_app_task/core/network/network_exception.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';
import 'package:syarah_app_task/core/widgets/appbar/basic_app_bar.dart';
import 'package:syarah_app_task/core/widgets/buttons/custom_button.dart';
import 'package:syarah_app_task/core/widgets/inputs/custom_text_form_field.dart';
import 'package:syarah_app_task/core/widgets/missing_data/missing_data_view.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';
import 'package:syarah_app_task/features/todos/presentation/controller/notifier/todo_list_notifier.dart';

/// Route-level screen to add a new todo or edit/delete an existing one.
class AddEditTodoView extends ConsumerStatefulWidget {
  const AddEditTodoView({this.todoId, super.key});

  final int? todoId;

  @override
  ConsumerState<AddEditTodoView> createState() => _AddEditTodoViewState();
}

class _AddEditTodoViewState extends ConsumerState<AddEditTodoView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  TodoModel? _existing;
  bool _completed = false;
  bool _isSaving = false;

  bool get _isEdit => widget.todoId != null;

  TodoListNotifier get _notifier =>
      ref.read(todoListProvider.notifier);

  @override
  void initState() {
    super.initState();
    final id = widget.todoId;
    if (id != null) {
      final todo = _notifier.todoById(id);
      if (todo != null) {
        _existing = todo;
        _titleController.text = todo.title;
        _completed = todo.completed;
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isSaving = true);

    final title = _titleController.text.trim();
    final NetworkException? error;
    if (_isEdit && _existing != null) {
      error = await _notifier.updateTodo(
        _existing!.copyWith(title: title, completed: _completed),
      );
    } else {
      error = await _notifier.addTodo(title: title, completed: _completed);
    }

    if (!mounted) return;
    setState(() => _isSaving = false);

    if (error != null) {
      context.showSnackBar(
        message: getNetworkErrorMessage(error),
        type: SnackBarType.error,
      );
      return;
    }
    context.showSnackBar(
      message: _isEdit ? 'Todo updated' : 'Todo added',
      type: SnackBarType.success,
    );
    context.pop();
  }

  Future<void> _confirmDelete() async {
    final existing = _existing;
    if (existing == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete todo'),
        content: const Text('Are you sure you want to delete this todo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              'Delete',
              style: TextStyle(color: ColorManager.error),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final error = await _notifier.deleteTodo(existing.id);
    if (!mounted) return;
    if (error != null) {
      context.showSnackBar(
        message: getNetworkErrorMessage(error),
        type: SnackBarType.error,
      );
      return;
    }
    context.showSnackBar(
      message: 'Todo deleted',
      type: SnackBarType.success,
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final title = _isEdit ? 'Edit Todo' : 'Add Todo';

    if (_isEdit && _existing == null) {
      return Scaffold(
        appBar: basicAppBar(context, title: title, showBackButton: true),
        body: const MissingDataView(
          title: 'Todo not found',
          icon: Icons.error_outline_rounded,
        ),
      );
    }

    return Scaffold(
      appBar: basicAppBar(
        context,
        title: title,
        showBackButton: true,
        actions: [
          if (_isEdit)
            IconButton(
              onPressed: _confirmDelete,
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: ColorManager.error,
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, (1 - value) * 24.h),
                child: child,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  verticalSpacing(kSpacingXL),
                  _buildFormCard(context),
                  verticalSpacing(kSpacingXL),
                  CustomButton(
                    label: _isEdit ? 'Save Changes' : 'Add Todo',
                    icon: Icons.check_rounded,
                    isLoading: _isSaving,
                    onPressed: _save,
                  ),
                ],
              ).allPadding(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56.r,
          height: 56.r,
          decoration: BoxDecoration(
            color: ColorManager.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(kRadiusL.r),
          ),
          child: Icon(
            _isEdit ? Icons.edit_note_rounded : Icons.playlist_add_rounded,
            color: ColorManager.primary,
            size: kIconM.r,
          ),
        ),
        SizedBox(width: kSpacingL.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isEdit ? 'Edit your todo' : 'Create a new todo',
                style: context.headingH5,
              ),
              SizedBox(height: kSpacingXXS.h),
              Text(
                _isEdit
                    ? 'Update the details below'
                    : 'What would you like to get done?',
                style: context.bodySmall?.copyWith(
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kSpacingL.w),
      decoration: BoxDecoration(
        color: ColorManager.surface,
        borderRadius: BorderRadius.circular(kRadiusL.r),
        border: Border.all(color: ColorManager.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: _titleController,
            labelText: 'Todo title',
            hintText: 'Enter the todo title',
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Title is required';
              }
              return null;
            },
          ),
          verticalSpacing(kSpacingL),
          Divider(color: ColorManager.border, height: 1.h),
          verticalSpacing(kSpacingM),
          _buildCompletedToggle(context),
        ],
      ),
    );
  }

  Widget _buildCompletedToggle(BuildContext context) {
    return Row(
      children: [
        Icon(
          _completed
              ? Icons.check_circle_rounded
              : Icons.radio_button_unchecked_rounded,
          color: _completed
              ? ColorManager.success
              : ColorManager.textSecondary,
          size: kIconM.r,
        ),
        SizedBox(width: kSpacingM.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Completed',
                style: context.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Mark this todo as done',
                style: context.bodySmall?.copyWith(
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: _completed,
          onChanged: (value) => setState(() => _completed = value),
          activeThumbColor: ColorManager.primary,
        ),
      ],
    );
  }
}
