import 'package:flutter/material.dart';

extension TextStylesExtension on BuildContext {
  TextTheme get _textTheme => Theme.of(this).textTheme;

  TextStyle? get primaryHeadingH1 => _textTheme.displayLarge;
  TextStyle? get primaryHeadingH2 => _textTheme.displayMedium;
  TextStyle? get headingH3 => _textTheme.headlineMedium;
  TextStyle? get headingH4 => _textTheme.headlineSmall;
  TextStyle? get headingH5 => _textTheme.titleLarge;
  TextStyle? get headingH6 => _textTheme.titleMedium;
  TextStyle? get bodyLarge => _textTheme.bodyLarge;
  TextStyle? get bodyRegular => _textTheme.bodyMedium;
  TextStyle? get bodySmall => _textTheme.bodySmall;
  TextStyle? get labelLarge => _textTheme.labelLarge;
}
