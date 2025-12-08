import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KAuthTextFormField extends StatelessWidget {
  final String? hintText;
  final String? label;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final int? maxLines;
  final bool isReadOnly;
  final bool floatingLabel;
  final Color? labelColor;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;
  final ValueChanged<String>? onChanged;
  final bool isRequiredStar;
  final ValueChanged<String>? onFieldSubmitted; // ✅ Added
  final FocusNode? focusNode; // ✅ Added

  const KAuthTextFormField({
    super.key,
    this.hintText,
    this.label,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onTap,
    this.maxLines,
    this.isReadOnly = false,
    this.floatingLabel = false,
    this.labelColor,
    this.labelFontSize,
    this.labelFontWeight,
    this.onChanged,
    this.isRequiredStar = false,
    this.onFieldSubmitted, // ✅ Added
    this.focusNode, // ✅ Added
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label above the field (only if label is provided and floatingLabel is false)
        if (label != null && !floatingLabel) ...[
          Row(
            children: [
              Text(
                label!,
                style: GoogleFonts.sora(
                  fontSize: labelFontSize ?? 12.sp,
                  fontWeight: labelFontWeight ?? FontWeight.w600,
                  color: labelColor ?? theme.textTheme.headlineLarge?.color,
                ),
              ),
              if (isRequiredStar)
                KText(
                  text: " *",
                  color: isDark ? AppColors.checkOutColorDark : Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
            ],
          ),
          SizedBox(height: 6.h),
        ],

        // TextFormField
        TextFormField(
          onTap: onTap,
          readOnly: isReadOnly,
          maxLines: maxLines ?? 1,
          validator: validator,
          focusNode: focusNode, // ✅ Added
          textInputAction: TextInputAction.next, // ✅ Added
          onFieldSubmitted: onFieldSubmitted, // ✅ Added
          style: GoogleFonts.sora(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: theme.textTheme.headlineLarge?.color,
          ),
          cursorColor: theme.primaryColor,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: floatingLabel ? label : null,
            labelStyle: floatingLabel
                ? GoogleFonts.sora(
              fontSize: labelFontSize ?? 12.sp,
              fontWeight: labelFontWeight ?? FontWeight.w500,
              color:
              labelColor ??
                  theme.textTheme.headlineLarge?.color?.withValues(
                    alpha: 0.7,
                  ),
            )
                : null,
            floatingLabelStyle: floatingLabel
                ? GoogleFonts.sora(
              fontSize: (labelFontSize ?? 12.sp) + 1,
              fontWeight: labelFontWeight ?? FontWeight.w600,
              color: labelColor ?? theme.primaryColor,
            )
                : null,
            suffixIcon: suffixIcon != null
                ? Icon(
              suffixIcon,
              color: theme.textTheme.bodyLarge?.color?.withValues(
                alpha: 0.7,
              ),
            )
                : null,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                theme
                    .inputDecorationTheme
                    .enabledBorder
                    ?.borderSide
                    .color ??
                    AppColors.authUnderlineBorderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: theme.primaryColor, width: 2.w),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDark
                    ? AppColors.checkOutColorDark
                    : AppColors.checkOutColor,
                width: 1.w,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDark
                    ? AppColors.checkOutColorDark
                    : AppColors.checkOutColor,
                width: 2.w,
              ),
            ),
            errorStyle: GoogleFonts.sora(
              fontSize: 10.sp,
              color: isDark
                  ? AppColors.checkOutColorDark
                  : AppColors.checkOutColor,
            ),
          ),
        ),
      ],
    );
  }
}