import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class ApplicantItem extends StatelessWidget {
  final String name;
  final String email;
  final String employeeType;
  final Color avatarColor;
  final bool showInitials;
  final String? initials;

  const ApplicantItem({
    Key? key,
    required this.name,
    required this.email,
    required this.employeeType,
    required this.avatarColor,
    this.showInitials = false,
    this.initials,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Avatar
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: avatarColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: showInitials && initials != null
                  ? Center(
                child: KText(
                  text: initials!,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )
                  : Icon(Icons.person, color: Colors.white, size: 16.sp),
            ),
            SizedBox(width: 12.w),

            // Name & Email
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: name,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                  SizedBox(height: 2.h),
                  KText(
                    text: email,
                    fontSize: 12.sp,
                    color: AppColors.greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),

            // Employee Type
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: KText(
                  text: employeeType,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.titleColor,
                ),
              ),
            ),
          ],
        ),

        // Divider
        SizedBox(height: 12.h),
        Divider(
          thickness: 1,
          color: AppColors.greyColor.withOpacity(0.1),
        ),
      ],
    );
  }

}
