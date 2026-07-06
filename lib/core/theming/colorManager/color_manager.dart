import 'package:flutter/material.dart';

/// Central palette. All colors must be referenced through [ColorManager]
/// — never raw `Colors.x` or `Color(0x..)` in feature code.
class ColorManager {
  const ColorManager._();

  static const Color primary = Color(0xFF1E6F5C);
  static const Color primaryLight = Color(0xFF29A19C);
  static const Color secondary = Color(0xFFF2A65A);

  static const Color background = Color(0xFFF7F8FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color darkBackground = Color(0xFF121417);
  static const Color darkSurface = Color(0xFF1D2126);

  static const Color textPrimary = Color(0xFF1A1C1E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnDark = Color(0xFFECECEC);

  static const Color error = Color(0xFFD64545);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED8F03);
  static const Color info = Color(0xFF2F6FED);

  static const Color border = Color(0xFFE2E5EA);
  static const Color disabled = Color(0xFFBFC5CE);
  static const Color shimmerBase = Color(0xFFE6E8EB);
  static const Color shimmerHighlight = Color(0xFFF4F5F7);
}
