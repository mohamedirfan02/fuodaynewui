import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/attendance/presentation/widgets/attendance_line_chart.dart';

class TotalTimeWorkedCard extends StatelessWidget {
  const TotalTimeWorkedCard({
    super.key,
    required this.theme,
    required this.months,
  });

  final ThemeData theme;
  final List<String> months;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 320.h,
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
        padding: EdgeInsets.all(10.0.w),
        child: Column(
          children: [
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
                        child: Icon(
                          Icons.access_time_outlined,
                          size: 16,
                          color: theme
                              .textTheme
                              .bodyLarge
                              ?.color, //AppColors.greyColor,,
                        ),
                      ),
                    ),
                    KHorizontalSpacer(width: 5.w),
                    KText(
                      text: "Total Time worked",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
            // KText(
            //   text: "13h 32m 09s +1.5%",
            //   fontWeight: FontWeight.w500,
            //   fontSize: 12.sp,
            // ),
            KVerticalSpacer(height: 10.h),
            Align(
              alignment: Alignment.centerLeft,

              child: RichText(
                text: TextSpan(
                  children: [
                    // Total value
                    TextSpan(
                      text: "13h 32m 09s",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: theme
                            .textTheme
                            .headlineLarge
                            ?.color, //AppColors.titleColor,,
                      ),
                    ),

                    // Gap
                    const WidgetSpan(
                      child: SizedBox(width: 6), // you can adjust
                    ),
                    TextSpan(
                      text: "+1.5%",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 10.sp,
                        color:
                        AppColors.inReviewedColor, //AppColors.titleColor,,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),

            // Chart
            SizedBox(
              height: 300.h,
              child: AttendanceLineChart(
                showHourSuffix: true,
                attendanceValues: [10, 8, 6, 4, 2, 0, 5],
                months: months,
              ),
            ),
          ],
        ),
      ),
    );
  }
}