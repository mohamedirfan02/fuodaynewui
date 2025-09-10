import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
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
    this.growthText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155.w,
      height: 103.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5.w, color: AppColors.greyColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.secondaryColor.withOpacity(1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Icon
          CircleAvatar(
            radius: 14.r,
            backgroundColor: AppColors.cardBorderColor,
            child: SvgPicture.asset(
              AppAssetsConstants.atsUserIcon,
              width: 16.w,
              height: 16.w,
              color: AppColors.titleColor,
              fit: BoxFit.contain,
            ),
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

              if (growthText != null)
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

          KVerticalSpacer(height: 6.h),

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
