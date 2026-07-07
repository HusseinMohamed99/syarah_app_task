import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';
import 'package:syarah_app_task/core/helpers/extensions/text_styles_extension.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';

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
            Container(
              width: 108.r,
              height: 108.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.error.withValues(alpha: 0.08),
              ),
              child: Center(
                child: Container(
                  width: 72.r,
                  height: 72.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.error.withValues(alpha: 0.14),
                  ),
                  child: Icon(
                    Icons.cloud_off_rounded,
                    size: 36.r,
                    color: ColorManager.error,
                  ),
                ),
              ),
            ),
            SizedBox(height: kSpacingXL.h),
            Text(
              'Oops! Something went wrong',
              textAlign: TextAlign.center,
              style: context.headingH4,
            ),
            SizedBox(height: kSpacingS.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.bodyRegular?.copyWith(
                color: ColorManager.textSecondary,
              ),
            ),
            if (onRetry != null) ...[
              SizedBox(height: kSpacingXL.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh_rounded, size: kIconS.r),
                label: Text(retryLabel),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  foregroundColor: ColorManager.textOnPrimary,
                  padding: EdgeInsets.symmetric(
                    horizontal: kSpacingXL.w,
                    vertical: kSpacingM.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kRadiusL.r),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
