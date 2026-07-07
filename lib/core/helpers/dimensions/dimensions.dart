import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const double kSpacingXXS = 2;
const double kSpacingXS = 4;
const double kSpacingS = 8;
const double kSpacingM = 12;
const double kSpacingL = 16;
const double kSpacingXL = 24;
const double kSpacingXXL = 32;

const double kRadiusS = 8;
const double kRadiusM = 12;
const double kRadiusL = 16;

const double kIconS = 16;
const double kIconM = 24;
const double kIconL = 48;

const double kScreenPadding = 16;

Widget verticalSpacing(double height) => SizedBox(height: height.h);

Widget horizontalSpacing(double width) => SizedBox(width: width.w);
