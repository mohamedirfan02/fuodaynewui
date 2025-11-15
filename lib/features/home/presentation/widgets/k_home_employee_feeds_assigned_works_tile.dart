import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KHomeEmployeeFeedsAssignedWorksTile extends StatelessWidget {
  final Color leadingVerticalDividerColor;
  final String assignedWorksTitle;
  final String assignedWorkSubTitle;
  final String assignedWorkDeadLine;
  final String assignedBy;
  final String assignedTo;
  final String date;
  final String progress;
  final String deadline;
  final String? progressNote;
  final String? command;

  const KHomeEmployeeFeedsAssignedWorksTile({
    super.key,
    required this.leadingVerticalDividerColor,
    required this.assignedWorksTitle,
    required this.assignedWorkSubTitle,
    required this.assignedWorkDeadLine,
    required this.assignedBy,
    required this.assignedTo,
    required this.date,
    required this.progress,
    required this.deadline,
    this.progressNote,
    this.command,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Leading vertical divider
            Container(
              width: 3.w,
              height: double.infinity,
              decoration: BoxDecoration(
                color: leadingVerticalDividerColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),

            SizedBox(width: 12.w),

            // Main content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row with date on right
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Expanded(
                        child: Text(
                          assignedWorksTitle,
                          style: GoogleFonts.sora(
                            fontWeight: FontWeight.w600,
                            color: theme.textTheme.headlineLarge?.color,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),

                      // Assigned Date on right
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          date,
                          style: GoogleFonts.sora(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w500,
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Subtitle content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task : $assignedWorkSubTitle",
                        style: GoogleFonts.sora(fontSize: 10.sp),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Assigned To: $assignedTo",
                        style: GoogleFonts.sora(fontSize: 10.sp),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Deadline: $deadline",
                        style: GoogleFonts.sora(fontSize: 10.sp),
                      ),

                      SizedBox(height: 4.h),
                      KText(
                        text: "Progress Note: $progressNote",
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: theme.textTheme.headlineLarge?.color,
                      ),
                      SizedBox(height: 4.h),
                      KText(
                        text: "reason: $command",
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: theme.textTheme.headlineLarge?.color,
                      ),
                      SizedBox(height: 4.h),
                      KText(
                        text: "Status: $progress",
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.softRedDark
                            : AppColors.softRed,
                        fontSize: 10.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
