import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KAtsGlowButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final BorderRadius borderRadius;
  final Widget? icon; // 👈 added

  const KAtsGlowButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width = 140,
    this.height = 44,
    this.backgroundColor = const Color(0xFF9258BC),
    this.textColor = Colors.white,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.icon, // 👈 added
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    return InkWell(
      borderRadius: borderRadius,
      onTap: isLoading
          ? null
          : () {
              HapticFeedback.mediumImpact();
              onPressed();
            },
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(color: backgroundColor, width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFEBF2FF),
              spreadRadius: 4,
              blurRadius: 0,
              offset: Offset(0, 0),
            ),
            BoxShadow(
              color: Color.fromRGBO(0, 11, 33, 0.05),
              spreadRadius: 0,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      icon!,
                      const SizedBox(width: 6), // spacing between icon & text
                    ],
                    Text(
                      text,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
