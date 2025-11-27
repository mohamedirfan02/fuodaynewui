import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KHomeEmployeeFeedsPendingWorksTile extends StatelessWidget {
  final Color pendingVerticalDividerColor;
  final String pendingProjectTitle;
  final String pendingDeadline;
  final String pendingWorkStatus;
  final String assignedBy;
  final String date;
  final String description;
  final String? comment;
  final String? progressNote;

  const KHomeEmployeeFeedsPendingWorksTile({
    super.key,
    required this.pendingVerticalDividerColor,
    required this.pendingProjectTitle,
    required this.pendingDeadline,
    required this.pendingWorkStatus,
    required this.assignedBy,
    required this.date,
    required this.description,
    this.comment,
    this.progressNote,
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
            // Vertical divider
            Container(
              width: 3.w,
              height: double.infinity,
              decoration: BoxDecoration(
                color: pendingVerticalDividerColor,
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
                      Expanded(
                        child: Text(
                          pendingProjectTitle,
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
                        "Task: $description",
                        style: GoogleFonts.sora(fontSize: 12.sp),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Deadline: $pendingDeadline",
                        style: GoogleFonts.sora(fontSize: 10.sp),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Assigned By: $assignedBy",
                        style: GoogleFonts.sora(fontSize: 10.sp),
                      ),
                      SizedBox(height: 2.h),
                      KText(
                        text: "Project Status: $pendingWorkStatus",
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        color: theme.textTheme.headlineLarge?.color,
                      ),
                      SizedBox(height: 2.h),
                      KText(
                        text: "Progress Note: ${progressNote ?? 'N/A'}",
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        color: theme.textTheme.headlineLarge?.color,
                      ),
                      SizedBox(height: 2.h),
                      KText(
                        text: "Comment: ${comment ?? 'No comment'}",
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        color: theme.textTheme.headlineLarge?.color,
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
