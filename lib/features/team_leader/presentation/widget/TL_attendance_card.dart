import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';

class TLAttendanceCard extends StatelessWidget {
  final String attendancePercentage;
  final IconData attendancePercentageIcon;
  final Color attendancePercentageColor;
  final Color attendanceIconColor;
  final String attendanceCount;
  final IconData attendanceCardIcon;
  final String attendanceDescription;

  const TLAttendanceCard({
    super.key,
    required this.attendancePercentage,
    required this.attendancePercentageIcon,
    required this.attendanceCount,
    required this.attendanceCardIcon,
    required this.attendanceDescription,
    required this.attendanceIconColor,
    required this.attendancePercentageColor,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);
    final cardWidth = isTablet
        ? (isLandscape ? 0.48.sw : 0.47.sw)
        : 0.45.sw; // dynamic width
    final paddingValue = isTablet ? 18.w : 14.w;
    return Stack(
      children: [
        // Card Content
        Container(
          width: cardWidth, //0.4.sw,
          padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 19.h),
          decoration: BoxDecoration(
            border: Border.all(width: 0.1.w, color: AppColors.greyColor),
            borderRadius: BorderRadius.circular(8.r),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.cardGradientColor,
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Attendance count
              KText(
                text: attendanceCount,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: AppColors.titleColor,
              ),

              KVerticalSpacer(height: 8.h),

              // Attendance Description
              Expanded(
                child: KText(
                  text: attendanceDescription,
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  color: AppColors.titleColor,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),

              KVerticalSpacer(height: 4.h),

              Row(
                spacing: 4.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 4.r,
                    backgroundColor: AppColors.approvedColor,
                  ), // Percentage Text
                  KText(
                    text: attendancePercentage,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: AppColors.titleColor,
                  ),
                ],
              ),
            ],
          ),
        ),

        Positioned(
          top: 10,
          right: 20,
          child: CircleAvatar(
            radius: 14.r,
            backgroundColor: AppColors.secondaryColor,
            child: Icon(attendanceCardIcon, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
