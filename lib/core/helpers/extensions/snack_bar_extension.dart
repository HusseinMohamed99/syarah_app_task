import 'package:flutter/material.dart';
import 'package:syarah_app_task/core/theming/colorManager/color_manager.dart';

/// Visual category of a snackbar message.
enum SnackBarType { success, error, info, warning }

/// Shows a themed snackbar via `context.showSnackBar(...)`.
extension SnackBarExtension on BuildContext {
  void showSnackBar({
    required String message,
    SnackBarType type = SnackBarType.info,
  }) {
    final messenger = ScaffoldMessenger.of(this)..hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _backgroundColor(type),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Color _backgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return ColorManager.success;
      case SnackBarType.error:
        return ColorManager.error;
      case SnackBarType.warning:
        return ColorManager.warning;
      case SnackBarType.info:
        return ColorManager.info;
    }
  }
}
