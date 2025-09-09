import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class AtsTotalCountCard extends StatelessWidget {
  final Color attendancePercentageColor;
  final Color attendanceIconColor;
  final String attendanceCount;
  final IconData attendanceCardIcon;
  final String attendanceDescription;
  final String? growthText; // ✅ Added for growth (+5.1%)

  const AtsTotalCountCard({
    super.key,
    required this.attendanceCount,
    required this.attendanceCardIcon,
    required this.attendanceDescription,
    required this.attendanceIconColor,
    required this.attendancePercentageColor,
    this.growthText, // optional
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.4.sw,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        border: Border.all(width: 0.1.w, color: AppColors.greyColor),
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.secondaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Icon
          CircleAvatar(
            radius: 14.r,
            backgroundColor: AppColors.attendanceCardTextLightColor,
            child: Icon(attendanceCardIcon, color: AppColors.primaryColor, size: 16.sp),
          ),

          SizedBox(height: 8.h),

          // Count + Growth Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              KText(
                text: attendanceCount,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: AppColors.titleColor,
              ),
              SizedBox(width: 6.w),

              if (growthText != null) // ✅ Only show if provided
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: attendancePercentageColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_upward, color: attendancePercentageColor, size: 12.sp),
                      SizedBox(width: 2.w),
                      Text(
                        growthText!,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: attendancePercentageColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          KVerticalSpacer(height: 8.h),

          // Description
          KText(
            text: attendanceDescription,
            fontWeight: FontWeight.w500,
            fontSize: 10.sp,
            color: AppColors.titleColor,
          ),
        ],
      ),
    );
  }
}
