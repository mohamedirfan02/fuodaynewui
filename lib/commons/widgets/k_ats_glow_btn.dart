import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KAtsGlowButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final BorderRadius borderRadius;
  final Widget? icon; // 👈 added
  final List<Color>? gradientColors;

  const KAtsGlowButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 44,
    this.backgroundColor = const Color(0xFF9258BC),
    this.textColor = Colors.white,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.icon, // 👈 added
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    // final theme = Theme.of(context);
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
          // color: backgroundColor,
          borderRadius: borderRadius,
          border: Border.all(color: backgroundColor, width: 1),
          gradient: gradientColors != null
              ? LinearGradient(
                  colors: gradientColors!,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: gradientColors == null ? backgroundColor : null,
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

class KAtsGlowSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final BorderRadius borderRadius;
  final Widget? prefixIcon;
  final List<Color>? gradientColors;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const KAtsGlowSearchField({
    super.key,
    required this.controller,
    required this.hintText,
    this.width = double.infinity,
    this.height = 44,
    this.backgroundColor = const Color(0xFF9258BC),
    this.textColor = Colors.white,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.prefixIcon,
    this.gradientColors,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(color: backgroundColor, width: 1),
        gradient: gradientColors != null
            ? LinearGradient(
                colors: gradientColors!,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        color: gradientColors == null ? backgroundColor : null,
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
      child: Row(
        children: [
          if (prefixIcon != null) ...[prefixIcon!, const SizedBox(width: 6)],
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: textColor.withValues(alpha: 0.6),
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isCollapsed: true,
                suffixIcon: controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          controller.clear();
                          if (onChanged != null) onChanged!('');
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
