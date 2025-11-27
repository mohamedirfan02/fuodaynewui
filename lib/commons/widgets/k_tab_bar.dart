import 'package:flutter/material.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final Color? indicatorColor;
  final Color? selectedLabelColor;
  final Color? unselectedLabelColor;
  final Color? dividerColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final BorderRadius? borderRadius;
  final TabBarIndicatorSize? indicatorSize;
  final EdgeInsetsGeometry? indicatorPadding;
  final TabController? controller;
  final EdgeInsetsGeometry? labelPadding; // Added parameter for spacing

  const KTabBar({
    super.key,
    required this.tabs,
    this.indicatorColor,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.dividerColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.borderRadius,
    this.indicatorSize,
    this.indicatorPadding,
    this.controller,
    this.labelPadding, // Added to constructor

  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;

    return TabBar(
      controller: controller,
      tabs: tabs,
      dividerColor: dividerColor ?? AppColors.transparentColor,
      indicator: BoxDecoration(
        color: indicatorColor ?? theme.primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
      ),
      indicatorColor: AppColors.transparentColor,
      indicatorSize: indicatorSize ?? TabBarIndicatorSize.tab,
      indicatorPadding: indicatorPadding ?? EdgeInsets.zero,
      unselectedLabelColor: unselectedLabelColor ?? theme.primaryColor,
      labelColor: selectedLabelColor ?? theme.secondaryHeaderColor,
      labelStyle:
          labelStyle ??
          GoogleFonts.sora(fontSize: 10.sp, fontWeight: FontWeight.bold),
      unselectedLabelStyle:
          unselectedLabelStyle ??
          GoogleFonts.sora(fontSize: 10.sp, fontWeight: FontWeight.normal),
      labelPadding: labelPadding ?? EdgeInsets.symmetric(horizontal: 8.w), // Now customizable
      tabAlignment: TabAlignment.center,
      isScrollable: true,
    );
  }
}
