import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final FontWeight fontWeight;
  final double fontSize;
  final Color? color;
  final bool isUnderline;
  final Color? underlineColor;
  // 🔥 Add new optional parameters
  final int? maxLines;
  final TextOverflow? overflow;

  const KText({
    super.key,
    required this.text,
    this.textAlign,
    required this.fontWeight,
    required this.fontSize,
    this.color,
    this.isUnderline = false,
    this.underlineColor,
    this.maxLines,         // ✅ not required
    this.overflow,         // ✅ not required
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,   // ✅ applied
      overflow: overflow,   // ✅ applied
      style: GoogleFonts.inter(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        decoration: isUnderline ? TextDecoration.underline : null,
        decorationColor: underlineColor,
      ),

      // style: GoogleFonts.sora(
      //   fontWeight: fontWeight,
      //   fontSize: fontSize,
      //   color: color,
      //   decoration: isUnderline ? TextDecoration.underline : null,
      //   decorationColor: underlineColor,
      // ),
    );
  }
}
