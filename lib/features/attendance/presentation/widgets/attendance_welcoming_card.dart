import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';

class AttendanceWelcomingCard extends StatelessWidget {
  final String attendanceCardTime;
  final String attendanceCardTimeMessage;
  final String attendanceDay;
  final String attendanceDate;
  final VoidCallback onViewAttendance;

  const AttendanceWelcomingCard({
    super.key,
    required this.attendanceCardTime,
    required this.attendanceCardTimeMessage,
    required this.attendanceDay,
    required this.attendanceDate,
    required this.onViewAttendance,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: AppColors.greyColor),
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
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    spacing: 10.w,
                    children: [
                      // Sun Svg
                      SvgPicture.asset(
                        AppAssetsConstants.sunImg,
                        height: 40.h,
                        width: 40.w,
                        fit: BoxFit.cover, color: AppColors.greyColor,
                      ),

                      Column(
                        spacing: 2.h,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Time
                          KText(
                            text: attendanceCardTime,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: isDark
                                ? AppColors.attendanceCardTextLightColorDark
                                : AppColors
                                      .greyColor, //theme.textTheme.bodyLarge?.color,
                          ),

                          // Welcoming TExt
                          KText(
                            text: attendanceCardTimeMessage,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: isDark
                                ? AppColors.attendanceCardTextLightColorDark
                                : AppColors.greyColor,
                          ),
                        ],
                      ),
                    ],
                  ),

                  KVerticalSpacer(height: 10.h),

                  // Day
                  KText(
                    text: attendanceDay,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: theme
                        .textTheme
                        .headlineLarge
                        ?.color, //AppColors.titleColor,
                  ),

                  KVerticalSpacer(height: 2.h),

                  // Date
                  KText(
                    text: attendanceDate,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: theme.textTheme.headlineLarge?.color,
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Sun Svg
                  SvgPicture.asset(
                    AppAssetsConstants.attendanceImg,
                    height: 80.h,
                    width: 80.w,
                    fit: BoxFit.cover,
                    color: AppColors.greyColor,
                  ),
                ],
              ),
            ],
          ),

          // View Attendance btn
          KAuthFilledBtn(
            text: "View Attendance",
            onPressed: () {
              onViewAttendance();
            },
            backgroundColor: theme.primaryColor,
            height: 23.h,
            fontSize: 10.sp,
          ),
        ],
      ),
    );
  }
}
