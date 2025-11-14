import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class KFilterBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final BorderRadiusGeometry borderRadius;
  final Widget? icon; // right-side icon
  final Color borderColor;
  final double borderWidth;

  const KFilterBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.height = 44,
    this.width = double.infinity,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.icon,
    this.borderColor = const Color.fromRGBO(233, 234, 236, 1),
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: isTablet ? 0 : MediaQuery.of(context).size.height * 0.015,
          ),
          side: BorderSide(color: borderColor, width: borderWidth),
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
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.sora(
                      color: textColor,
                      fontSize: fontSize.sp,
                      fontWeight: fontWeight,
                    ),
                  ),
                  if (icon != null) icon!,
                ],
              ),
      ),
    );
  }
}
