import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KSnackBar {
  static void success(BuildContext context, String message) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    _showSnackBar(
      context,
      message,
      backgroundColor: isDark
          ? AppColors.checkInColorDark
          : AppColors.checkInColor,
      icon: Icons.check_circle_outline,
    );
  }

  static void failure(BuildContext context, String message) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    _showSnackBar(
      context,
      message,
      backgroundColor: isDark
          ? AppColors.checkOutColorDark
          : AppColors.checkOutColor,
      icon: Icons.error_outline,
    );
  }

  static void _showSnackBar(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    required IconData icon,
  }) {
    //App Theme Data
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          spacing: 12.w,
          children: [
            Icon(
              icon,
              color: theme.secondaryHeaderColor,
            ), //AppColors.secondaryColor),

            Expanded(
              child: Text(
                message,
                style: GoogleFonts.sora(color: theme.secondaryHeaderColor),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        closeIconColor: theme.secondaryHeaderColor,
        showCloseIcon: true,
        dismissDirection: DismissDirection.down,
      ),
    );
  }
}
