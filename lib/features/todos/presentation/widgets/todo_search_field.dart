import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';
import 'package:syarah_app_task/core/widgets/inputs/custom_text_form_field.dart';

/// Search box that filters todos by title as the user types.
class TodoSearchField extends StatelessWidget {
  const TodoSearchField({required this.onChanged, super.key});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kSpacingS.h),
      child: CustomTextFormField(
        hintText: 'Search todos...',
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        prefixIcon: Icon(
          Icons.search_rounded,
          color: ColorManager.textSecondary,
          size: kIconM.r,
        ),
      ),
    );
  }
}
