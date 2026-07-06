import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';
import 'package:syarah_app_task/core/helpers/extensions/snack_bar_extension.dart';
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
      message: _isEdit ? 'تم تحديث المهمة' : 'تمت إضافة المهمة',
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
        title: const Text('حذف المهمة'),
        content: const Text('هل أنت متأكد من حذف هذه المهمة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              'حذف',
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
      message: 'تم حذف المهمة',
      type: SnackBarType.success,
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final title = _isEdit ? 'تعديل المهمة' : 'إضافة مهمة';

    if (_isEdit && _existing == null) {
      return Scaffold(
        appBar: basicAppBar(context, title: title, showBackButton: true),
        body: const MissingDataView(
          title: 'المهمة غير موجودة',
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: _titleController,
                  labelText: 'عنوان المهمة',
                  hintText: 'اكتب عنوان المهمة',
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'العنوان مطلوب';
                    }
                    return null;
                  },
                ),
                verticalSpacing(kSpacingS),
                SwitchListTile(
                  value: _completed,
                  onChanged: (value) => setState(() => _completed = value),
                  title: const Text('مكتملة'),
                  activeThumbColor: ColorManager.primary,
                  contentPadding: EdgeInsets.zero,
                ),
                verticalSpacing(kSpacingL),
                CustomButton(
                  label: _isEdit ? 'حفظ التغييرات' : 'إضافة',
                  icon: Icons.check_rounded,
                  isLoading: _isSaving,
                  onPressed: _save,
                ),
              ],
            ).allPadding(),
          ),
        ),
      ),
    );
  }
}
