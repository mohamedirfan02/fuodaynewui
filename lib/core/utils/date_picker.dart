import 'package:flutter/material.dart';
import 'package:fuoday/core/themes/app_colors.dart';

// Select Date Utility
Future<void> selectDatePicker(
  BuildContext context,
  TextEditingController controller,
) async {
  //App Theme Data
  final theme = Theme.of(context);
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    initialDatePickerMode: DatePickerMode.day,
    helpText: 'Select Date',
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          dividerTheme: DividerThemeData(
            color: theme.textTheme.headlineLarge?.color,
          ),
          colorScheme: ColorScheme.light(
            surface: theme.secondaryHeaderColor,
            primary: theme.primaryColor,
            onPrimary: theme.secondaryHeaderColor, //AppColors.secondaryColor,
            onSurface:
                theme.textTheme.headlineLarge?.color ??
                AppColors
                    .titleColor, //AppColors.titleColor,theme.textTheme.headlineLarge?.color,//AppColors.titleColor,
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null) {
    controller.text = "${picked.day}/${picked.month}/${picked.year}";
  }
}
