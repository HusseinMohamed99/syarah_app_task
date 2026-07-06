import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';

/// Consistent leading back button that pops the current route.
class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new_rounded, size: kIconM.r),
      onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
    );
  }
}
