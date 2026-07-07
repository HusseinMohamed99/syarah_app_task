import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';
import 'package:syarah_app_task/core/widgets/loading/adaptive_loading_indicator.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.backgroundColor,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? ColorManager.primary,
          foregroundColor: ColorManager.textOnPrimary,
          disabledBackgroundColor: ColorManager.disabled,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadiusM.r),
          ),
        ),
        child: isLoading
            ? const AdaptiveLoadingIndicator(
                color: ColorManager.textOnPrimary,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: kIconS.r),
                    SizedBox(width: kSpacingS.w),
                  ],
                  Text(label),
                ],
              ),
      ),
    );
  }
}
