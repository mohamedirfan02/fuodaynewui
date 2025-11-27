import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportInfoCard extends StatelessWidget {
  final String priority;
  final String issue;
  final String avatarText;
  final String userName;
  final String ticketIssuedDate;
  final String ticketIssue;
  final String domain;

  const SupportInfoCard({
    super.key,
    required this.priority,
    required this.issue,
    required this.avatarText,
    required this.userName,
    required this.ticketIssuedDate,
    required this.ticketIssue,
    required this.domain,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
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
              : AppColors.cardGradientColor, //Card Gradiant
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Priority Status
              KText(
                text: priority,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: isDark
                    ? AppColors.checkOutColorDark
                    : AppColors.checkOutColor,
              ),

              // Issue
              KText(
                text: issue,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                // color: AppColors.titleColor,
              ),
            ],
          ),

          KVerticalSpacer(height: 12.h),

          Row(
            spacing: 14.w,
            children: [
              // Avatar
              CircleAvatar(
                radius: 20.r,
                backgroundColor: theme.primaryColor,
                child: Center(
                  child: KText(
                    textAlign: TextAlign.center,
                    text: avatarText,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color:
                        theme.secondaryHeaderColor, //AppColors.secondaryColor
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Username
                  KText(
                    text: userName,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    //color: AppColors.titleColor,
                  ),

                  // Date
                  KText(
                    text: ticketIssuedDate,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    //color: AppColors.titleColor,
                  ),
                ],
              ),
            ],
          ),

          KVerticalSpacer(height: 12.h),

          // Ticket Issue
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: "Ticket: ",
              style: GoogleFonts.sora(
                color: theme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: issue,
                  style: GoogleFonts.sora(
                    color: theme
                        .textTheme
                        .headlineLarge
                        ?.color, //AppColors.titleColor,,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          KVerticalSpacer(height: 8.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Username
              Row(
                children: [
                  Icon(
                    Icons.add,
                    color: isDark
                        ? AppColors.checkInColorDark
                        : AppColors.checkInColor,
                    size: 14.w,
                  ),

                  // Assign
                  KText(
                    text: "Assign",
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: isDark
                        ? AppColors.checkInColorDark
                        : AppColors.checkInColor,
                  ),
                ],
              ),

              // Domain
              KText(
                text: domain,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
                color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
