import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class AttendancePunctualArrivalCard extends StatelessWidget {
  final String punctualCountOrPercentageText;
  final String punctualCountOrPercentageDescriptionText;

  const AttendancePunctualArrivalCard({
    super.key,
    required this.punctualCountOrPercentageText,
    required this.punctualCountOrPercentageDescriptionText,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      height: 140.w,
      width: 140.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Count
          KText(
            text: punctualCountOrPercentageText,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
          ),

          // Description
          KText(
            text: punctualCountOrPercentageDescriptionText,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
          ),
        ],
      ),
    );
  }
}
