import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/providers/checkbox_provider.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:provider/provider.dart';

class KCheckbox extends StatelessWidget {
  final String text;
  final String checkboxKey; // Unique key for this checkbox
  final Color? activeColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  final ValueChanged<bool>? onChanged; // Optional callback

  const KCheckbox({
    super.key,
    required this.text,
    required this.checkboxKey,
    this.activeColor,
    this.fontWeight = FontWeight.w500,
    this.fontSize,
    this.textColor,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckboxProvider>(
      builder: (context, checkboxProvider, child) {
        final value = checkboxProvider.getCheckboxState(checkboxKey);

        return Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                checkboxProvider.setCheckboxState(
                  checkboxKey,
                  newValue ?? false,
                );
                onChanged?.call(newValue ?? false);
              },
              activeColor: activeColor ?? AppColors.primaryColor,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  checkboxProvider.toggleCheckbox(checkboxKey);
                  onChanged?.call(
                    checkboxProvider.getCheckboxState(checkboxKey),
                  );
                },
                child: KText(
                  text: text,
                  fontWeight: fontWeight ?? FontWeight.w500,
                  fontSize: fontSize ?? 12.sp,
                  color: textColor ?? AppColors.titleColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
