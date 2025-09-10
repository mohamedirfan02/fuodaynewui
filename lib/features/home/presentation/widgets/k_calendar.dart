// 1. Main Calendar Widget (minimal code for your main file)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';

// ===================================
// 2. Calendar Header Widget
// ===================================
class CalendarHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        KText(
          text: "Calendar",
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
          color: AppColors.titleColor,
        ),
        InkWell(
          onTap: () {
            // TODO: navigate to full screen
          },
          child: Row(
            children: [
              KText(
                text: "See all",
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
                color: AppColors.subTitleColor,
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 12.sp,
                color: AppColors.subTitleColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ===================================
// 3. Today Section Widget
// ===================================
class TodaySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KText(
          text: "TODAY",
          fontWeight: FontWeight.w500,
          fontSize: 11.sp,
          color: AppColors.greyColor,
        ),
        SizedBox(height: 12.h),
        CalendarEventItem(
          role: "UI UX Designer",
          task: "Onboarding",
          date: "01 May",
          borderColor: Colors.purple,
        ),
      ],
    );
  }
}

// ===================================
// 4. Upcoming Section Widget
// ===================================
class UpcomingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KText(
          text: "UPCOMING",
          fontWeight: FontWeight.w500,
          fontSize: 11.sp,
          color: AppColors.greyColor,
        ),
        SizedBox(height: 12.h),
        CalendarEventItem(
          role: "QA Engineer",
          task: "Send Task",
          date: "04 May",
          borderColor: Colors.cyan,
        ),
        SizedBox(height: 16.h),
        CalendarEventItem(
          role: "Software Engineer",
          task: "Technical Interview",
          date: "06 May",
          borderColor: Colors.orange,
        ),
        SizedBox(height: 16.h),
        CalendarEventItem(
          role: "UI UX Designer",
          task: "Onboarding",
          date: "08 May",
          borderColor: Colors.green,
        ),
      ],
    );
  }
}

// ===================================
// 5. Calendar Event Item Widget (Reusable)
// ===================================
class CalendarEventItem extends StatelessWidget {
  final String role;
  final String task;
  final String date;
  final Color borderColor;

  const CalendarEventItem({
    Key? key,
    required this.role,
    required this.task,
    required this.date,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.w),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 3.w, color: borderColor),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: role,
                fontWeight: FontWeight.w400,
                fontSize: 11.sp,
                color: AppColors.titleColor,
              ),
              SizedBox(height: 4.h),
              KText(
                text: task,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.titleColor,
              ),
            ],
          ),
          KText(
            text: date,
            fontWeight: FontWeight.w400,
            fontSize: 11.sp,
            color: AppColors.greyColor,
          ),
        ],
      ),
    );
  }
}
