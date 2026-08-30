import 'package:flutter/widgets.dart';

/// Lightweight responsive helpers based on a base design size (390x844).
/// Use R.w(context, value) for width-based scaling, R.h for height,
/// and R.sp for scaling font sizes.
class R {
  static const double _baseWidth = 390.0;
  static const double _baseHeight = 844.0;

  static double w(BuildContext context, double size) {
    final screenW = MediaQuery.of(context).size.width;
    return size * screenW / _baseWidth;
  }

  static double h(BuildContext context, double size) {
    final screenH = MediaQuery.of(context).size.height;
    return size * screenH / _baseHeight;
  }

  static double sp(BuildContext context, double size) {
    // Use width scale for font sizes to keep proportions consistent.
    return w(context, size);
  }
}
