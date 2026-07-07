import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syarah_app_task/core/helpers/dimensions/dimensions.dart';

extension WidgetExtensions on Widget {
  Widget allPadding({
    double vPadding = kSpacingL,
    double hPadding = kSpacingL,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vPadding.h,
        horizontal: hPadding.w,
      ),
      child: this,
    );
  }

  Widget hPadding([double value = kSpacingL]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value.w),
      child: this,
    );
  }

  Widget vPadding([double value = kSpacingL]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value.h),
      child: this,
    );
  }

  Widget center() => Center(child: this);
}
