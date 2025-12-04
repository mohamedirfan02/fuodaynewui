import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class AtsTotalCountCard extends StatelessWidget {
  final Color employeePercentageColor;
  final Color employeeIconColor;
  final Color? empTextColors;
  final Color? avatarBgColors;
  final String employeeCount;
  final String employeeDescription;
  final String? growthText;
  final String? backgroundImage;

  //   Dynamic icon: can be SVG asset (String) or IconData
  final dynamic employeeCardIcon;
  final dynamic employeeCardArrowIcon;

  const AtsTotalCountCard({
    super.key,
    required this.employeeCount,
    required this.employeeDescription,
    required this.employeeIconColor,
    required this.employeePercentageColor,
    this.growthText,
    this.employeeCardIcon,
    this.backgroundImage,
    this.empTextColors,
    this.avatarBgColors,
    this.employeeCardArrowIcon,
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
        // image: DecorationImage(
        //   image: AssetImage(AppAssetsConstants.homeCard1),
        //   fit: BoxFit.cover,
        //   opacity: isDark ? 0.7 : 1.0,
        //   // Image.asset(
        //   //   AppAssetsConstants.logo,
        //   //   height: 180.h,
        //   //   width: 180.w,
        //   //   // fit: BoxFit.cover,
        //   //  )
        // ),
        image: backgroundImage != null
            ? DecorationImage(
                image: AssetImage(backgroundImage!),
                fit: BoxFit.cover,
                // opacity: isDark ? 0.7 : 1.0,
              )
            : null,
        border: Border.all(
          width: 0.5.w,
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: theme.secondaryHeaderColor.withValues(alpha: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //   Dynamic Icon
          CircleAvatar(
            radius: 14.r,
            backgroundColor:
                avatarBgColors ??
                (isDark
                    ? AppColors.cardBorderColorDark
                    : AppColors.cardBorderColor),
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
                color:
                    empTextColors ??
                    theme
                        .textTheme
                        .headlineLarge
                        ?.color, //AppColors.titleColor,
              ),
              SizedBox(width: 6.w),

              if (growthText != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color:
                        empTextColors ??
                        employeePercentageColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssetsConstants.upArrowIcon,
                        width: 5.w,
                        height: 5.w,
                        //SVG IMAGE COLOR
                        colorFilter: ColorFilter.mode(
                          employeePercentageColor,
                          BlendMode.srcIn,
                        ),
                        fit: BoxFit.contain,
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
            color: empTextColors ?? theme.textTheme.headlineLarge?.color,
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
