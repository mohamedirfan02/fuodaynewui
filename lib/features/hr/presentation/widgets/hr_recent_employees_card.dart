import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HRRecentEmployeesCard extends StatelessWidget {
  final String leadingEmployeeFirstLetter;
  final String employeeName;
  final String employeeDesignation;
  final String employeeJoinDate;

  const HRRecentEmployeesCard({
    super.key,
    required this.leadingEmployeeFirstLetter,
    required this.employeeName,
    required this.employeeDesignation,
    required this.employeeJoinDate,
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
        ), //AppColors.greyColor,),
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
        leading: CircleAvatar(
          backgroundColor: theme.primaryColor,
          child: Center(
            child: KText(
              text: leadingEmployeeFirstLetter,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: theme
                  .secondaryHeaderColor, //AppColors.secondaryColorAppColors.secondaryColor,
            ),
          ),
        ),
        trailing: Column(
          spacing: 2.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // employee Join Date
            KText(
              text: "DOJ",
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
              //  color: AppColors.titleColor,
            ),

            // employee Join Date
            KText(
              text: employeeJoinDate,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
              color: theme.primaryColor,
            ),
          ],
        ),

        title: Text(employeeName),
        subtitle: Text(employeeDesignation),

        titleTextStyle: GoogleFonts.sora(
          fontWeight: FontWeight.w600,
          color: theme.textTheme.headlineLarge?.color, //AppColors.titleColor,,
          fontSize: 13.sp,
        ),
        subtitleTextStyle: GoogleFonts.sora(
          fontWeight: FontWeight.w500,
          color: theme
              .inputDecorationTheme
              .focusedBorder
              ?.borderSide
              .color, //subTitleColor,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
