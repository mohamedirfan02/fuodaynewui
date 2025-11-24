import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String status;
  final String subtitle;
  final String candidatesInfo;
  final String timeInfo;
  final Color statusColor;
  final Color? statusBackgroundColor;

  const JobCard({
    super.key,
    required this.title,
    required this.status,
    required this.subtitle,
    required this.candidatesInfo,
    required this.timeInfo,
    this.statusColor = const Color(0xFF10B981),
    this.statusBackgroundColor, //= const Color(0xFFECFDF3),
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: 327.w,
      height: 150.h,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: theme.secondaryHeaderColor, //AppColors.secondaryColor
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: theme.textTheme.bodyLarge?.color ?? AppColors.greyColor,
        ), //BORDER COLOR, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  // color: AppColors.titleColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  // color: statusBackgroundColor,
                  color: isDark
                      ? theme.secondaryHeaderColor
                      : Color(0xFFECFDF3), //AppColors.secondaryColor,
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
              color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
            ),
          ),
          SizedBox(height: 8.h),

          // Candidates Info
          Text(
            candidatesInfo,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: theme.textTheme.bodyLarge?.color,
            ),
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
