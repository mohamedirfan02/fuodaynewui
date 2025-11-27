import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

Future<void> selectMonthYearPicker(
  BuildContext context,
  TextEditingController controller,
) async {
  final DateTime? picked = await showMonthPicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    monthPickerDialogSettings: MonthPickerDialogSettings(),
  );

  if (picked != null) {
    controller.text = "${picked.month}/${picked.year}";
  }
}
