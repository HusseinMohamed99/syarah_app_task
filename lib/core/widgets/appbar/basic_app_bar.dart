import 'package:flutter/material.dart';
import 'package:syarah_app_task/core/helpers/extensions/text_styles_extension.dart';
import 'package:syarah_app_task/core/widgets/appbar/back_button_widget.dart';

/// Factory for the app's standard [AppBar]. Adds a [BackButtonWidget]
/// leading when [showBackButton] is true.
PreferredSizeWidget basicAppBar(
  BuildContext context, {
  required String title,
  bool showBackButton = false,
  List<Widget>? actions,
}) {
  return AppBar(
    title: Text(title, style: context.headingH5),
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: showBackButton ? const BackButtonWidget() : null,
    actions: actions,
  );
}
