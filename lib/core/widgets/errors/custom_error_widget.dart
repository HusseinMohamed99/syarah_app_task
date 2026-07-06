import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';
import 'package:syarah_app_task/core/helpers/extensions/text_styles_extension.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';

/// Full-screen error state with a message and a retry action.
class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    required this.message,
    this.onRetry,
    this.retryLabel = 'Retry',
    super.key,
  });

  final String message;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(kScreenPadding.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: kIconL.r,
              color: ColorManager.error,
            ),
            SizedBox(height: kSpacingL.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.bodyLarge,
            ),
            if (onRetry != null) ...[
              SizedBox(height: kSpacingL.h),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh_rounded, size: kIconS.r),
                label: Text(retryLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
