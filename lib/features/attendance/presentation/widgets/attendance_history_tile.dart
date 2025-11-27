import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceHistoryTile extends StatelessWidget {
  final String attendanceTitle;
  final String attendanceCount;

  const AttendanceHistoryTile({
    super.key,
    required this.attendanceTitle,
    required this.attendanceCount,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(color: AppColors.titleColor, width: 0.1.w),
      ),
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? AppColors.cardGradientColorDark
                : AppColors.cardGradientColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(
            attendanceTitle,
            style: GoogleFonts.sora(
              color: theme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            attendanceCount,
            style: GoogleFonts.sora(
              color:
                  theme.textTheme.headlineLarge?.color, //AppColors.titleColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
