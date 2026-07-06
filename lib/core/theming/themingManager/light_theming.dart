import 'package:flutter/material.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';
import 'package:syarah_app_task/core/theming/themingManager/app_text_theme.dart';

/// Light theme definition. Typography feeds the `context.*` text getters.
ThemeData buildLightTheme() {
  const colorScheme = ColorScheme.light(
    primary: ColorManager.primary,
    secondary: ColorManager.secondary,
    surface: ColorManager.surface,
    error: ColorManager.error,
    onPrimary: ColorManager.textOnPrimary,
    onSurface: ColorManager.textPrimary,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: ColorManager.background,
    textTheme: buildAppTextTheme(ColorManager.textPrimary),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.surface,
      foregroundColor: ColorManager.textPrimary,
      elevation: 0,
      centerTitle: true,
    ),
  );
}
