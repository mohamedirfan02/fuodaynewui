import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';

class HRCard extends StatelessWidget {
  final String totalEmployeesCount;
  final String description;
  final String filterByHR;
  final IconData hrCardIcon;
  final VoidCallback? onTap;

  const HRCard({
    super.key,
    required this.totalEmployeesCount,
    required this.description,
    required this.filterByHR,
    required this.hrCardIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: isTablet
                ? (isLandscape ? 0.48.sw : 0.47.sw)
                : 0.4.sw, //0.4.sw,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.1.w,
                color: theme.textTheme.bodyLarge?.color ?? AppColors.greyColor,
              ), //BORDER COLOR),
              borderRadius: BorderRadius.circular(8.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? AppColors.cardGradientColorDark
                    : AppColors.cardGradientColor, //Card Gradiant,
              ),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // EmployeeCount
                KText(
                  text: totalEmployeesCount,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  //color: AppColors.titleColor,
                ),

                KVerticalSpacer(height: 8.h),

                // Description
                KText(
                  text: description,
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                  //color: AppColors.titleColor,
                ),

                KVerticalSpacer(height: 4.h),

                Row(
                  spacing: 4.w,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: theme.primaryColor,
                      radius: 3.r,
                    ),

                    // filter by week
                    KText(
                      text: filterByHR,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: theme
                          .textTheme
                          .bodyLarge
                          ?.color, //AppColors.greyColor,
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
              backgroundColor:
                  theme.secondaryHeaderColor, //AppColors.secondaryColor
              child: Icon(hrCardIcon, color: theme.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
