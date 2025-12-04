import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/helper/notification_helper.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/home/presentation/provider/check_in_provider.dart';
import 'package:fuoday/features/home/presentation/provider/checkin_status_provider.dart';
import 'package:fuoday/features/home/presentation/widgets/k_checkin_button.dart';
import 'package:fuoday/features/home/presentation/widgets/live_timer_widget.dart';

class TimeTrackerContainer extends StatelessWidget {
  const TimeTrackerContainer({
    super.key,
    required this.theme,
    required this.checkinStatusProvider,
    required this.checkInProvider,
    required this.isDark,
    required this.webUserId,
  });

  final ThemeData theme;
  final CheckinStatusProvider checkinStatusProvider;
  final CheckInProvider checkInProvider;
  final bool isDark;
  final int webUserId;

  @override
  Widget build(BuildContext context) {
    void _showLocationSwitchDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final theme = Theme.of(context);

          String? selectedLocation;

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                title: KText(
                  text: "Switch Location",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    KText(
                      text: "Select your working mode",
                      fontSize: 14.sp,
                      color: theme
                          .inputDecorationTheme
                          .focusedBorder
                          ?.borderSide
                          .color,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 16.h),

                    // Remote Button
                    InkWell(
                      onTap: () {
                        setState(() => selectedLocation = "Remote");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: selectedLocation == "Remote"
                                ? theme.primaryColor
                                : theme.dividerColor,
                            width: 1.2,
                          ),
                        ),
                        child: KText(
                          text: "Remote",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: selectedLocation == "Remote"
                              ? theme.primaryColor
                              : theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Office Button
                    InkWell(
                      onTap: () {
                        setState(() => selectedLocation = "Office");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: selectedLocation == "Office"
                                ? theme.primaryColor
                                : theme.dividerColor,
                            width: 1.2,
                          ),
                        ),
                        child: KText(
                          text: "Office",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: selectedLocation == "Office"
                              ? theme.primaryColor
                              : theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                  ],
                ),

                actions: [
                  // Cancel
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: KText(
                      text: "Cancel",
                      color: theme
                          .inputDecorationTheme
                          .focusedBorder
                          ?.borderSide
                          .color,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),

                  // Confirm
                  TextButton(
                    onPressed: selectedLocation == null
                        ? null
                        : () {
                            Navigator.pop(context);
                            // 🔹 No API — only message
                            KSnackBar.success(
                              context,
                              "$selectedLocation Mode Selected",
                            );
                          },
                    child: KText(
                      text: "Confirm",
                      color: selectedLocation == null
                          ? theme.disabledColor
                          : theme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    String selectedLocation = "Remote"; // default text

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5.w,
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: theme.secondaryHeaderColor.withValues(alpha: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Column(
          children: [
            //Top Contents
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 20.h,
                      width: 23.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5.w,
                          color:
                              theme.textTheme.bodyLarge?.color?.withValues(
                                alpha: 0.3,
                              ) ??
                              AppColors.greyColor,
                        ),
                        borderRadius: BorderRadius.circular(5.r),
                        color: theme.secondaryHeaderColor.withValues(alpha: 1),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssetsConstants.timeTrackerIcon,
                          width: 12.w,
                          height: 12.w,
                          colorFilter: ColorFilter.mode(
                            theme.textTheme.headlineLarge?.color?.withValues(
                                  alpha: 0.5,
                                ) ??
                                Colors.black,
                            BlendMode.srcIn,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    KHorizontalSpacer(width: 5.w),
                    KText(
                      text: "Time Tracker",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                Container(
                  height: 25.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5.w,
                      color:
                          theme.textTheme.bodyLarge?.color?.withValues(
                            alpha: 0.3,
                          ) ??
                          AppColors.greyColor,
                    ),
                    borderRadius: BorderRadius.circular(5.r),
                    color: theme.secondaryHeaderColor.withValues(alpha: 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 20,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                        KHorizontalSpacer(width: 5.w),
                        KText(
                          text: "History",
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            KVerticalSpacer(height: 16.h),
            //Check In Button Part
            Container(
              height: 170.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5.w,
                  color:
                      theme.textTheme.bodyLarge?.color?.withValues(
                        alpha: 0.3,
                      ) ??
                      AppColors.greyColor,
                ),
                borderRadius: BorderRadius.circular(12.r),
                color: theme.secondaryHeaderColor.withValues(alpha: 1),
              ),
              child: Column(
                children: [
                  Container(
                    height: 25.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 0.5.w,
                          color:
                              theme.textTheme.bodyLarge?.color?.withValues(
                                alpha: 0.3,
                              ) ??
                              AppColors.greyColor,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                      ),
                      color: theme.textTheme.bodyLarge?.color?.withValues(
                        alpha: 0.1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssetsConstants.logo,
                          width: 30.w,
                          height: 30.h,
                        ),
                        KText(
                          text: "Fuoday.com",
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ],
                    ),
                  ),
                  KVerticalSpacer(height: 16.h),
                  Container(
                    height: 25.h,
                    width: 133.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5.w,
                        color:
                            theme.textTheme.bodyLarge?.color?.withValues(
                              alpha: 0.3,
                            ) ??
                            AppColors.greyColor,
                      ),
                      borderRadius: BorderRadius.circular(5.r),
                      color: theme.textTheme.bodyLarge?.color?.withValues(
                        alpha: 0.1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0.w),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 20,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                          KHorizontalSpacer(width: 5.w),
                          KText(
                            text: "Mon, 23 Apr 2025",
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  KVerticalSpacer(height: 10.h),

                  ///  LiveTimerDisplay widget
                  LiveTimerDisplay(
                    checkinStatusProvider: checkinStatusProvider,
                    checkInProvider: checkInProvider,
                    theme: theme,
                  ),

                  KVerticalSpacer(height: 10.h),

                  /// Check-in/out button
                  checkinStatusProvider.isLoading
                      ? CircularProgressIndicator(
                          color: theme.primaryColor,
                          strokeWidth: 2.5,
                        )
                      : KCheckInButton(
                          textColor: theme.secondaryHeaderColor,
                          text: checkInProvider.isLoading
                              ? "Loading..."
                              : (checkinStatusProvider.isCurrentlyCheckedIn ||
                                    checkInProvider.isCheckedIn)
                              ? "Clock Out"
                              : "Clock In",
                          fontSize: 10.sp,
                          height: 25.h,
                          width: 125.w,
                          backgroundColor: checkInProvider.isLoading
                              ? Colors.grey
                              : (checkinStatusProvider.isCurrentlyCheckedIn ||
                                    checkInProvider.isCheckedIn)
                              ? isDark
                                    ? AppColors.checkOutColorDark
                                    : AppColors.checkOutColor
                              : isDark
                              ? AppColors.checkInColorDark
                              : AppColors.newCheckInColor.withValues(
                                  alpha: 0.7,
                                ),
                          onPressed: checkInProvider.isLoading
                              ? null
                              : () async {
                                  final now = DateTime.now().toIso8601String();
                                  if (checkinStatusProvider
                                          .isCurrentlyCheckedIn ||
                                      checkInProvider.isCheckedIn) {
                                    await context.checkInProviderRead
                                        .handleCheckOut(
                                          userId: webUserId,
                                          time: now,
                                        );
                                    checkInProvider.stopWatchTimer
                                        .onStopTimer();

                                    // // ✅ Show real system notification
                                    // await NotificationHelper.showNotification(
                                    //   'Attendance',
                                    //   'Checked out successfully for today!',
                                    // );
                                    AppLoggerHelper.logInfo(
                                      "Check Out Web User Id: $webUserId",
                                    );
                                  } else {
                                    await context.checkInProviderRead
                                        .handleCheckIn(
                                          userId: webUserId,
                                          time: now,
                                        );

                                    checkInProvider.stopWatchTimer
                                        .onResetTimer();
                                    checkInProvider.stopWatchTimer
                                        .onStartTimer();

                                    // ✅ Show real system notification
                                    // await NotificationHelper.showNotification(
                                    //   'Attendance',
                                    //   'Checked in successfully for today!',
                                    // );
                                    AppLoggerHelper.logInfo(
                                      "Check In Web User Id: $webUserId",
                                    );
                                  }
                                  if (webUserId > 0) {
                                    await context.checkinStatusProviderRead
                                        .fetchCheckinStatus(webUserId);
                                  }
                                },
                        ),
                ],
              ),
            ),
            KVerticalSpacer(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    KText(
                      text: "Clock In",
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    KVerticalSpacer(height: 10.h),
                    Icon(Icons.login),
                    KText(
                      text: checkinStatusProvider.formattedCheckinTime,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ],
                ),
                Column(
                  children: [
                    KText(
                      text: "Location",
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    KVerticalSpacer(height: 15.h),

                    InkWell(
                      onTap: () {
                        _showLocationSwitchDialog(context); // show dialog
                      },
                      child: Container(
                        height: 25.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5.w,
                            color:
                                theme.textTheme.bodyLarge?.color?.withValues(
                                  alpha: 0.3,
                                ) ??
                                AppColors.greyColor,
                          ),
                          borderRadius: BorderRadius.circular(5.r),
                          color: theme.textTheme.bodyLarge?.color?.withValues(
                            alpha: 0.1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5.0.w,
                            horizontal: 10.w,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssetsConstants.locationIcon,
                                width: 12.w,
                                height: 12.w,
                                colorFilter: ColorFilter.mode(
                                  theme.textTheme.headlineLarge?.color
                                          ?.withValues(alpha: 0.5) ??
                                      Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                              KHorizontalSpacer(width: 5.w),
                              KText(
                                text: selectedLocation, // 🔥 changes here only
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    KText(
                      text: "Clock Out",
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    KVerticalSpacer(height: 10.h),
                    Icon(Icons.logout),
                    KText(
                      text: checkinStatusProvider.formattedCheckoutTime,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ],
                ),
              ],
            ),
            KVerticalSpacer(height: 5.h),
          ],
        ),
      ),
    );
  }
}
