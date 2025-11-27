import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class AttendanceMessageContent extends StatelessWidget {
  final String messageContentTitle;
  final String messageContentSubTitle;

  const AttendanceMessageContent({
    super.key,
    required this.messageContentTitle,
    required this.messageContentSubTitle,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 90.h),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
      width: double.infinity,
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
        spacing: 8.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Performance High
          KText(
            text: messageContentTitle,
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            color: theme.primaryColor,
          ),

          // description
          KText(
            text: messageContentSubTitle,
            fontWeight: FontWeight.w500,
            color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
            fontSize: 11.sp,
          ),
        ],
      ),
    );
  }
}
