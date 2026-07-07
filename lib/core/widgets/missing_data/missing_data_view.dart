import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';
import 'package:syarah_app_task/core/helpers/extensions/text_styles_extension.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';

class MissingDataView extends StatelessWidget {
  const MissingDataView({
    required this.title,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.action,
    this.accentColor = ColorManager.primary,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? action;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(kScreenPadding.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _IconHalo(icon: icon, color: accentColor),
            SizedBox(height: kSpacingXL.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.headingH4,
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
              SizedBox(height: kSpacingXL.h),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

class _IconHalo extends StatelessWidget {
  const _IconHalo({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 108.r,
      height: 108.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.06),
      ),
      child: Center(
        child: Container(
          width: 72.r,
          height: 72.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: 0.12),
          ),
          child: Icon(icon, size: 36.r, color: color),
        ),
      ),
    );
  }
}
