import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/leave_tracker/presentation/widgets/leave_pie_chart.dart';

class LeaveBalanceCard extends StatelessWidget {
  final double usedAmount; // Value between 0-12
  final double totalAmount; // Should be 12
  final String? title;
  final String? usedLabel;
  final String? unusedLabel;
  final String? totalLabel;
  final double? chartSize;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final List<Color>? gradientColors;

  const LeaveBalanceCard({
    super.key,
    required this.usedAmount,
    this.totalAmount = 12.0,
    this.title,
    this.usedLabel = 'Used',
    this.unusedLabel = 'Available',
    this.totalLabel,
    this.chartSize,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        border: Border.all(
          width: borderWidth ?? 0.1.w,
          color:
              borderColor ??
              theme.textTheme.bodyLarge?.color ??
              AppColors.greyColor,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? AppColors.cardGradientColorDark
              : AppColors.cardGradientColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Leave Pie Chart
          LeavePieChart(
            usedAmount: usedAmount,
            totalAmount: totalAmount,
            title: title,
            usedLabel: usedLabel,
            unusedLabel: unusedLabel,
            totalLabel: totalLabel,
            size: chartSize,
          ),
        ],
      ),
    );
  }
}
