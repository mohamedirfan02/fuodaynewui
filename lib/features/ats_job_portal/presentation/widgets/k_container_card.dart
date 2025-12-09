import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/ats_job_portal/presentation/widgets/k_ats_overlap_avatar_widget.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String status;
  final String subtitle;
  final String candidatesInfo;
  final String timeInfo;
  final Color statusColor;
  final Color? statusBackgroundColor;
  final List<String>? candidateslist;

  const JobCard({
    super.key,
    required this.title,
    required this.status,
    required this.subtitle,
    required this.candidatesInfo,
    required this.timeInfo,
    this.statusColor = const Color(0xFF10B981),
    this.statusBackgroundColor,
    this.candidateslist,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 327.w,
      height: 150.h,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: theme.secondaryHeaderColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.1) ??
              AppColors.greyColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isDark ? Color(0xFF064E3B) : Color(0xFFECFDF3),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Subtitle
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),

          SizedBox(height: 8.h),

          // Avatars + Count
          Row(
            children: [
              if ((candidateslist?.length ?? 0) > 0)
                OverlapCirclesAuto(
                  items: candidateslist!.take(3).toList(), // show only max 3
                ),
              if ((candidateslist?.length ?? 0) > 0) SizedBox(width: 5.h),
              Text(
                candidatesInfo,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),
          // Time Info
          Text(
            timeInfo,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}
