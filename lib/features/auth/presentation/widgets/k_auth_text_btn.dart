import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KAuthTextBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final TextAlign textAlign;
  final Color textColor;
  final bool showUnderline;
  final Color? underlineColor;

  const KAuthTextBtn({
    super.key,
    required this.onTap,
    required this.text,
    required this.fontWeight,
    required this.fontSize,
    required this.textAlign,
    required this.textColor,
    required this.showUnderline,
    this.underlineColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(),
      onPressed: () {
        HapticFeedback.mediumImpact();

        onTap();
      },
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: showUnderline
              ? TextDecoration.underline
              : TextDecoration.none,
          decorationColor: underlineColor ?? textColor,
          decorationThickness: 1.5,
        ),
      ),
    );
  }
}
