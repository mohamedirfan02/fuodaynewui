import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class KHomeActivityAlertDialogBox extends StatelessWidget {
  final String activityType;
  final String date;
  final String title;
  final String subtitle;
  final String? closeButtonText;
  final VoidCallback? onClose;

  const KHomeActivityAlertDialogBox({
    super.key,
    required this.activityType,
    required this.date,
    required this.title,
    required this.subtitle,
    this.closeButtonText = "Close",
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      title: KText(
        text: activityType,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          KText(
            text: title,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: AppColors.titleColor,
          ),

          KVerticalSpacer(height: 5.h),

          // Subtitle
          KText(
            text: subtitle,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: AppColors.greyColor,
          ),

          KVerticalSpacer(height: 8.h),
        ],
      ),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Date
            KText(
              text: date,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.greyColor,
            ),

            // Close Btn
            TextButton(
              onPressed:
                  onClose ??
                  () {
                    GoRouter.of(context).pop();
                  },
              child: Text(
                closeButtonText!,
                style: GoogleFonts.sora(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
