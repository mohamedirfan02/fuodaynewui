import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class KAlertDialogBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? closeButtonText;
  final VoidCallback? onClose;

  const KAlertDialogBox({
    super.key,
    required this.title,
    required this.subtitle,
    this.closeButtonText = "Close",
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      title: KText(
        text: title,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
        color: theme.primaryColor,
      ),
      content: KText(
        text: subtitle,
        fontWeight: FontWeight.w500,
        color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,,
        fontSize: 11.sp,
      ),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Close Btn
            TextButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: GoogleFonts.sora(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: theme.primaryColor,
                ),
              ),
            ),

            // Close Btn
            TextButton(
              onPressed: onClose,
              child: Text(
                closeButtonText!,
                style: GoogleFonts.sora(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
