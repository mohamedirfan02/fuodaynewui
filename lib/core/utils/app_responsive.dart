import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppResponsive {
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > 600;
  }

  static bool isLandscape(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > size.height;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 600;
  }

  /// Reusable method to get button height responsively
  static double responsiveBtnHeight(BuildContext context) {
    final isTablet = isTabletDevice(context);
    final isLandscape = isLandscapeMode(context);

    if (isTablet) {
      return isLandscape ? 30.h : 27.h;
    } else {
      return 24.h;
    }
  }

  // Optional renaming helpers for better readability
  static bool isTabletDevice(BuildContext context) => isTablet(context);
  static bool isLandscapeMode(BuildContext context) => isLandscape(context);
}
