import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KDropdownTextFormField<T> extends StatelessWidget {
  final String? hintText;

  final List<T> items;
  final T? value;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  const KDropdownTextFormField({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hintText,

    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DropdownButtonFormField2<T>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.sora(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: theme.textTheme.headlineLarge?.color?.withOpacity(.7),
        ),

        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                theme.inputDecorationTheme.enabledBorder?.borderSide.color ??
                AppColors.authUnderlineBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2.w),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.checkOutColor, width: 1.w),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.checkOutColor, width: 2.w),
        ),
        errorStyle: GoogleFonts.sora(fontSize: 10.sp, color: Colors.red),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      ),
      validator: validator,
      items: items
          .map(
            (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                item.toString(),
                style: GoogleFonts.sora(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: theme.textTheme.headlineLarge?.color,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      dropdownStyleData: DropdownStyleData(
        elevation: 3,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: theme.secondaryHeaderColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
