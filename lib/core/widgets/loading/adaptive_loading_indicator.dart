import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Platform-aware spinner: Cupertino on iOS, Material elsewhere.
class AdaptiveLoadingIndicator extends StatelessWidget {
  const AdaptiveLoadingIndicator({this.color, this.size, super.key});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final dimension = (size ?? 22).r;
    if (Platform.isIOS) {
      return SizedBox(
        width: dimension,
        height: dimension,
        child: CupertinoActivityIndicator(color: color),
      );
    }
    return SizedBox(
      width: dimension,
      height: dimension,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: color == null
            ? null
            : AlwaysStoppedAnimation<Color>(color!),
      ),
    );
  }
}
