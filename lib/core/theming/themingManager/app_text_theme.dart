import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shared typography scale, tinted by [color] per theme brightness.
TextTheme buildAppTextTheme(Color color) {
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.bold,
      color: color,
    ),
    displayMedium: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
      color: color,
    ),
    headlineMedium: TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.w600,
      color: color,
    ),
    headlineSmall: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      color: color,
    ),
    titleLarge: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: color,
    ),
    titleMedium: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: color,
    ),
    bodyLarge: TextStyle(fontSize: 16.sp, color: color),
    bodyMedium: TextStyle(fontSize: 14.sp, color: color),
    bodySmall: TextStyle(fontSize: 12.sp, color: color),
    labelLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: color,
    ),
  );
}
