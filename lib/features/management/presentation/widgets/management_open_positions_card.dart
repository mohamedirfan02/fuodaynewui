import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagementOpenPositionsCard extends StatelessWidget {
  final String openPositonJobDesignation;
  final String openPositionJobDescription;

  const ManagementOpenPositionsCard({
    super.key,
    required this.openPositonJobDesignation,
    required this.openPositionJobDescription,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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

      child: ListTile(
        title: Text(openPositonJobDesignation),
        subtitle: Text(openPositionJobDescription),

        titleTextStyle: GoogleFonts.sora(
          fontWeight: FontWeight.w600,
          color: theme.textTheme.headlineLarge?.color, //AppColors.titleColor,
          fontSize: 13.sp,
        ),
        subtitleTextStyle: GoogleFonts.sora(
          fontWeight: FontWeight.w500,
          color: theme
              .inputDecorationTheme
              .focusedBorder
              ?.borderSide
              .color, //subTitleColor
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
