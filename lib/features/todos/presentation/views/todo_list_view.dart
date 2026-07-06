import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';
import 'package:syarah_app_task/core/helpers/extensions/snack_bar_extension.dart';
import 'package:syarah_app_task/core/helpers/extensions/widget_extensions.dart';
import 'package:syarah_app_task/core/helpers/functions/network_error_helper.dart';
import 'package:syarah_app_task/core/navigation/route_navigation_extension.dart';
import 'package:syarah_app_task/core/network/network_exception.dart';
import 'package:syarah_app_task/core/routing/app_router.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';
import 'package:syarah_app_task/core/widgets/appbar/basic_app_bar.dart';
import 'package:syarah_app_task/core/widgets/errors/custom_error_widget.dart';
import 'package:syarah_app_task/core/widgets/missing_data/missing_data_view.dart';
import 'package:syarah_app_task/features/todos/data/model/todo_model.dart';
import 'package:syarah_app_task/features/todos/presentation/controller/notifier/todo_list_notifier.dart';
import 'package:syarah_app_task/features/todos/presentation/controller/states/todo_list_state.dart';
import 'package:syarah_app_task/features/todos/presentation/helpers/todo_list_skeleton.dart';
import 'package:syarah_app_task/features/todos/presentation/widgets/todo_list_item.dart';
import 'package:syarah_app_task/features/todos/presentation/widgets/todo_search_field.dart';

/// Route-level screen listing all todos with search and pull-to-refresh.
class TodoListView extends ConsumerStatefulWidget {
  const TodoListView({super.key});

  @override
  ConsumerState<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends ConsumerState<TodoListView> {
  TodoListNotifier get _notifier =>
      ref.read(todoListProvider.notifier);

  Future<void> _onToggle(TodoModel todo) async {
    final error = await _notifier.toggleCompleted(todo);
    _reportIfFailed(error);
  }

  Future<void> _onDelete(TodoModel todo) async {
    final error = await _notifier.deleteTodo(todo.id);
    if (!mounted) return;
    if (error == null) {
      context.showSnackBar(
        message: 'تم حذف المهمة',
        type: SnackBarType.success,
      );
    } else {
      _reportIfFailed(error);
    }
  }

  void _reportIfFailed(NetworkException? error) {
    if (!mounted || error == null) return;
    context.showSnackBar(
      message: getNetworkErrorMessage(error),
      type: SnackBarType.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(todoListProvider);

    return Scaffold(
      appBar: basicAppBar(context, title: 'المهام'),
      floatingActionButton: FloatingActionButton(
        onPressed: () => const AddTodoRoute().safePush(context),
        backgroundColor: ColorManager.primary,
        child: const Icon(Icons.add, color: ColorManager.textOnPrimary),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TodoSearchField(onChanged: _notifier.search).hPadding(),
            Expanded(child: _buildBody(state)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(TodoListState state) {
    switch (state.status) {
      case TodoListStatus.initial:
      case TodoListStatus.loading:
        return const TodoListSkeleton().hPadding();

      case TodoListStatus.error:
        return _refreshableSingle(
          CustomErrorWidget(
            message: getNetworkErrorMessage(
              state.error ?? const NetworkException.unexpectedError(),
            ),
            onRetry: _notifier.retry,
          ),
        );

      case TodoListStatus.loaded:
        if (state.isEmpty) {
          return _refreshableSingle(
            const MissingDataView(
              title: 'لا توجد مهام بعد',
              subtitle: 'أضف مهمتك الأولى بالضغط على زر الإضافة',
              icon: Icons.checklist_rtl_rounded,
            ),
          );
        }
        if (state.hasNoSearchResults) {
          return _refreshableSingle(
            const MissingDataView(
              title: 'لا توجد نتائج',
              subtitle: 'جرّب كلمة بحث مختلفة',
              icon: Icons.search_off_rounded,
            ),
          );
        }
        return _buildList(state.filteredTodos);
    }
  }

  Widget _buildList(List<TodoModel> todos) {
    return RefreshIndicator(
      onRefresh: _notifier.refresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: kScreenPadding.w,
          vertical: kSpacingS.h,
        ),
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return TodoListItem(
            todo: todo,
            onTap: () => EditTodoRoute(id: todo.id).safePush(context),
            onToggle: () => _onToggle(todo),
            onDelete: () => _onDelete(todo),
          );
        },
      ),
    );
  }

  /// Wraps a non-list state so pull-to-refresh still works everywhere.
  Widget _refreshableSingle(Widget child) {
    return RefreshIndicator(
      onRefresh: _notifier.refresh,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: child,
          ),
        ),
      ),
    );
  }
}
