import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class TimeTrackerOverviewCard extends StatelessWidget {
  final IconData iconData;
  final String timeTrackerOverviewCardTitle;
  final String timeTrackerOverviewCardWorkingHours;

  const TimeTrackerOverviewCard({
    super.key,
    required this.iconData,
    required this.timeTrackerOverviewCardTitle,
    required this.timeTrackerOverviewCardWorkingHours,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: 0.4.sw,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.1.w,
          color: theme.textTheme.bodyLarge?.color ?? AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(8.r),
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
        // Changed from center to start
        mainAxisSize: MainAxisSize.min,
        // Added this
        children: [
          // Icon
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.secondaryHeaderColor, //AppColors.secondaryColor
              border: Border.all(
                color:
                    theme.textTheme.bodyLarge?.color?.withOpacity(0.1) ??
                    AppColors.greyColor,
              ),
            ),
            child: Center(child: Icon(iconData, color: AppColors.primaryColor)),
          ),

          KVerticalSpacer(height: 12.h),

          // Weekly working hours
          KText(
            textAlign: TextAlign.center,
            text: timeTrackerOverviewCardTitle,
            fontWeight: FontWeight.w500,
            color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
            fontSize: 10.sp,
          ),

          KVerticalSpacer(height: 4.h),

          // Hours
          KText(
            textAlign: TextAlign.center,
            text: timeTrackerOverviewCardWorkingHours,
            fontWeight: FontWeight.w600,
            // color: AppColors.titleColor,
            fontSize: 12.sp,
          ),
        ],
      ),
    );
  }
}
