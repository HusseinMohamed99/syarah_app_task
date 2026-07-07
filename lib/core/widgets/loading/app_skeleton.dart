import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({
    required this.child,
    this.enabled = true,
    super.key,
  });

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      effect: const ShimmerEffect(
        baseColor: ColorManager.shimmerBase,
        highlightColor: ColorManager.shimmerHighlight,
      ),
      child: child,
    );
  }
}
