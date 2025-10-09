import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
class JobPortalDevelopmentPositionTab extends StatefulWidget {
  const JobPortalDevelopmentPositionTab({super.key});

  @override
  State<JobPortalDevelopmentPositionTab> createState() => _JobPortalDevelopmentPositionTabState();
}

class _JobPortalDevelopmentPositionTabState extends State<JobPortalDevelopmentPositionTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 190.h,
        width: 327.w,
        padding: EdgeInsets.all(18.47.w),
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.77.w,
            color: AppColors.greyColor.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(7.69.r),
          color: AppColors.secondaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                KText(
                  text: "Applicant details",
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppColors.titleColor,
                ),
              ],
            ),
            KVerticalSpacer(height: 20.h),
          ],
        ),
      ),
    );
  }
}
