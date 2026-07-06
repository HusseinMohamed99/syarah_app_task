import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';
import 'package:syarah_app_task/core/helpers/extensions/text_styles_extension.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';

/// Generic empty-state view: icon, title, optional subtitle and action.
class MissingDataView extends StatelessWidget {
  const MissingDataView({
    required this.title,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.action,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(kScreenPadding.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: kIconL.r, color: ColorManager.textSecondary),
            SizedBox(height: kSpacingL.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.headingH5,
            ),
            if (subtitle != null) ...[
              SizedBox(height: kSpacingS.h),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: context.bodyRegular?.copyWith(
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
            if (action != null) ...[
              SizedBox(height: kSpacingL.h),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
