import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LeavePieChart extends StatelessWidget {
  final double usedAmount; // Value between 0-12
  final double totalAmount; // Should be 12
  final String? title;
  final String? usedLabel;
  final String? unusedLabel;
  final String? totalLabel;
  final double? size;

  const LeavePieChart({
    super.key,
    required this.usedAmount,
    this.totalAmount = 12.0,
    this.title,
    this.usedLabel = 'Used',
    this.unusedLabel = 'Available',
    this.size,
    this.totalLabel,
  });

  @override
  Widget build(BuildContext context) {
    final double clampedUsed = usedAmount.clamp(0.0, totalAmount);
    final double availableAmount = totalAmount - clampedUsed;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Text(
              title!,
              style: GoogleFonts.sora(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.headlineLarge?.color,
              ),
            ),
          ),
        SizedBox(
          width: size ?? 120.w,
          height: size ?? 120.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40.r,
                  startDegreeOffset: -90,
                  sections: [
                    PieChartSectionData(
                      color: theme.primaryColor,
                      value: clampedUsed,
                      title: '',
                      radius: 20.r,
                    ),
                    if (availableAmount > 0)
                      PieChartSectionData(
                        color: Colors.grey.shade300,
                        value: availableAmount,
                        title: '',
                        radius: 20.r,
                      ),
                  ],
                ),
              ),
              Text(
                '${clampedUsed.toStringAsFixed(clampedUsed == clampedUsed.toInt() ? 0 : 1)}/${totalAmount.toInt()}',
                style: GoogleFonts.sora(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: theme.textTheme.headlineLarge?.color,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        // Legend - Using Wrap to handle overflow
        Wrap(
          spacing: 16.w,
          runSpacing: 8.h,
          alignment: WrapAlignment.center,
          children: [
            _buildLegendItem(
              theme.primaryColor,
              '${usedLabel!} (${clampedUsed.toStringAsFixed(clampedUsed == clampedUsed.toInt() ? 0 : 1)})',
              context,
              showCircle: true,
            ),
            _buildLegendItem(
              Colors.grey.shade300,
              '${unusedLabel!} (${availableAmount.toStringAsFixed(availableAmount == availableAmount.toInt() ? 0 : 1)})',
              context,
              showCircle: true,
            ),
            if (totalLabel != null)
              _buildLegendItem(
                Colors.transparent,
                totalLabel!,
                context,
                showCircle: false,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(
    Color color,
    String label,
    BuildContext context, {
    bool showCircle = true,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showCircle) ...[
          Container(
            width: 12.w,
            height: 12.h,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 4.w),
        ],
        Flexible(
          child: Text(
            label,
            style: GoogleFonts.sora(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: theme.textTheme.headlineLarge?.color,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
