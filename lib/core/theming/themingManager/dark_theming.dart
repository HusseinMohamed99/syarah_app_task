import 'package:flutter/material.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';
import 'package:syarah_app_task/core/theming/themingManager/app_text_theme.dart';

/// Dark theme definition.
ThemeData buildDarkTheme() {
  const colorScheme = ColorScheme.dark(
    primary: ColorManager.primaryLight,
    secondary: ColorManager.secondary,
    surface: ColorManager.darkSurface,
    error: ColorManager.error,
    onPrimary: ColorManager.textOnPrimary,
    onSurface: ColorManager.textOnDark,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: ColorManager.darkBackground,
    textTheme: buildAppTextTheme(ColorManager.textOnDark),
    appBarTheme: const AppBarTheme(
      backgroundColor: ColorManager.darkSurface,
      foregroundColor: ColorManager.textOnDark,
      elevation: 0,
      centerTitle: true,
    ),
  );
}
