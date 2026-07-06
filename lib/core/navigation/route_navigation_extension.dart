import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Navigation helpers layered on top of typed [GoRouteData] routes.
///
/// `safePush` guards against accidentally pushing the same route twice in
/// quick succession (e.g. a double tap).
extension RouteNavigationExtension on GoRouteData {
  static bool _isNavigating = false;

  Future<T?> safePush<T extends Object?>(BuildContext context) async {
    if (_isNavigating) return null;
    _isNavigating = true;
    try {
      return await push<T>(context);
    } finally {
      _isNavigating = false;
    }
  }

  void safeGo(BuildContext context) => go(context);
}
