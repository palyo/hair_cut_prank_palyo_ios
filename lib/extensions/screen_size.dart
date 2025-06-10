import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  // Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  // Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenHeightWithoutSystemBars => MediaQuery.of(this).size.height - MediaQuery.of(this).padding.top - MediaQuery.of(this).padding.bottom;

  // Optional: Get screen orientation
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isTabletSize =>
      MediaQuery.of(this).size.shortestSide >= 600;
}
