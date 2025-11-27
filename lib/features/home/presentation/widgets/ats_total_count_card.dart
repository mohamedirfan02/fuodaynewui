import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class AtsTotalCountCard extends StatelessWidget {
  final Color employeePercentageColor;
  final Color employeeIconColor;
  final String employeeCount;
  final String employeeDescription;
  final String? growthText;

  //   Dynamic icon: can be SVG asset (String) or IconData
  final dynamic employeeCardIcon;

  const AtsTotalCountCard({
    super.key,
    required this.employeeCount,
    required this.employeeDescription,
    required this.employeeIconColor,
    required this.employeePercentageColor,
    this.growthText,
    this.employeeCardIcon,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: 155.w,
      height: 103.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5.w,
          color:
              theme.textTheme.bodyLarge?.color?.withOpacity(0.3) ??
              AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: theme.secondaryHeaderColor.withOpacity(1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //   Dynamic Icon
          CircleAvatar(
            radius: 14.r,
            backgroundColor: isDark
                ? AppColors.cardBorderColorDark
                : AppColors.cardBorderColor,
            child: _buildIcon(context),
          ),

          SizedBox(height: 8.h),

          // Count + Growth Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              KText(
                text: employeeCount,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                // color: AppColors.titleColor,
              ),
              SizedBox(width: 6.w),

              if (growthText != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: employeePercentageColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        color: employeePercentageColor,
                        size: 12.sp,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        growthText!,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: employeePercentageColor,
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
            text: employeeDescription,
            fontWeight: FontWeight.w400,
            fontSize: 10.sp,
            color: theme.textTheme.headlineLarge?.color,
          ),
        ],
      ),
    );
  }

  //   Helper to render Icon or SVG
  Widget _buildIcon(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    if (employeeCardIcon is IconData) {
      return Icon(employeeCardIcon, size: 16.sp, color: AppColors.titleColor);
    } else if (employeeCardIcon is String) {
      return SvgPicture.asset(
        employeeCardIcon,
        width: 16.w,
        height: 16.w,
        //SVG IMAGE COLOR
        colorFilter: ColorFilter.mode(
          theme.textTheme.headlineLarge?.color ?? Colors.black,
          BlendMode.srcIn,
        ),
        fit: BoxFit.contain,
      );
    }
    return Icon(
      Icons.help_outline,
      size: 16.sp,
      color: theme.textTheme.headlineLarge?.color,
    );
  }
}
