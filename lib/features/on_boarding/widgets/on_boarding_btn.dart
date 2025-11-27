import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingBtn extends StatelessWidget {
  final String btnText;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onTap;
  final double btnHeight;
  final double btnWidth;
  final bool isLoading;
  final double borderRadius;
  final double btnTextFontSize;

  const OnBoardingBtn({
    super.key,
    required this.btnText,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
    required this.btnHeight,
    required this.btnWidth,
    required this.borderRadius,

    this.isLoading = false, required this.btnTextFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      height: btnHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          disabledBackgroundColor: bgColor.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                btnText,
                style: GoogleFonts.sora(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: btnTextFontSize,
                ),
              ),
      ),
    );
  }
}
