import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KAuthPasswordTextField extends StatefulWidget {
  final String? hintText;
  final String? label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool isReadOnly;
  final bool floatingLabel;
  final Color? labelColor;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;

  const KAuthPasswordTextField({
    super.key,
    this.hintText,
    this.label,
    this.controller,
    this.validator,
    this.onTap,
    this.isReadOnly = false,
    this.floatingLabel =
        false, // true for floating label, false for above label
    this.labelColor,
    this.labelFontSize,
    this.labelFontWeight,
  });

  @override
  State<KAuthPasswordTextField> createState() => _KAuthPasswordTextFieldState();
}

class _KAuthPasswordTextFieldState extends State<KAuthPasswordTextField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label above the field (only if label is provided and floatingLabel is false)
        if (widget.label != null && !widget.floatingLabel) ...[
          Text(
            widget.label!,
            style: GoogleFonts.sora(
              fontSize: widget.labelFontSize ?? 12.sp,
              fontWeight: widget.labelFontWeight ?? FontWeight.w600,
              color:
                  widget.labelColor ??
                  theme.textTheme.headlineLarge?.color, //AppColors.titleColor,,
            ),
          ),
          SizedBox(height: 6.h),
        ],

        // TextFormField
        TextFormField(
          onTap: widget.onTap,
          readOnly: widget.isReadOnly,
          validator: widget.validator,
          style: GoogleFonts.sora(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color:
                theme.textTheme.headlineLarge?.color, //AppColors.titleColor,,
          ),
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Password',
            hintStyle: TextStyle(color: theme.textTheme.headlineLarge?.color),
            labelText: widget.floatingLabel ? widget.label : null,
            // floating label
            labelStyle: widget.floatingLabel
                ? GoogleFonts.sora(
                    fontSize: widget.labelFontSize ?? 12.sp,
                    fontWeight: widget.labelFontWeight ?? FontWeight.w500,
                    color:
                        widget.labelColor ??
                        theme.textTheme.headlineLarge?.color?.withOpacity(0.7),
                  )
                : null,
            floatingLabelStyle: widget.floatingLabel
                ? GoogleFonts.sora(
                    fontSize: (widget.labelFontSize ?? 12.sp) + 1,
                    fontWeight: widget.labelFontWeight ?? FontWeight.w600,
                    color: widget.labelColor ?? theme.primaryColor,
                  )
                : null,
            suffixIcon: IconButton(
              onPressed: _togglePasswordVisibility,
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
                color: theme.textTheme.headlineLarge?.color?.withOpacity(0.7),
              ),
            ),
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
