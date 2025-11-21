import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class KAuthFilledBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading; // external loading control
  final double height;
  final double width;
  final Color backgroundColor;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final BorderRadiusGeometry borderRadius;
  final Widget? icon; // optional icon
  final Widget? suffixIcon; // 🔹  optional right icon

  const KAuthFilledBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.height = 48,
    this.width = double.infinity,
    this.backgroundColor = Colors.blue,
    this.textColor,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.icon, // optional
    this.suffixIcon, //optional suffix icon
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          elevation: 0,
        ),
        onPressed: isLoading
            ? null
            : () {
                HapticFeedback.mediumImpact();
                onPressed();
              },
        child: isLoading
            ? SizedBox(
                height: 18.h,
                width: 18.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    icon!,
                    SizedBox(width: 6.w), // spacing between icon and text
                  ],
                  Text(
                    text,
                    style: GoogleFonts.sora(
                      color:
                          textColor ??
                          theme
                              .secondaryHeaderColor, //AppColors.secondaryColor, //AppColors.titleColor,,
                      fontSize: fontSize.sp,
                      fontWeight: fontWeight,
                    ),
                  ),
                  if (suffixIcon != null) ...[
                    // 🔹 CHANGED: added right icon display
                    SizedBox(width: 6.w),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
