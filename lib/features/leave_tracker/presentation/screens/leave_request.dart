import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/leave_tracker/data/datasources/leave_remote_data_source.dart';
import 'package:hive/hive.dart';

class LeaveRequest extends StatefulWidget {
  const LeaveRequest({super.key});

  @override
  State<LeaveRequest> createState() => _LeaveRequestState();
}

class _LeaveRequestState extends State<LeaveRequest> {
  // Controllers
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController permission_timing = TextEditingController();

  // Format Date
  String formatDate(String date) {
    final parts = date.split('/');
    if (parts.length == 3) {
      final day = parts[0].padLeft(2, '0');
      final month = parts[1].padLeft(2, '0');
      final year = parts[2];
      return "$year-$month-$day"; // Format: yyyy-MM-dd
    }
    return date;
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Select Date
    Future<void> selectDate(
      BuildContext context,
      TextEditingController controller,
    ) async {
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
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: AppColors.secondaryColor,
                onSurface: AppColors.titleColor,
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

    // Get the current selected leave type
    final selectedLeaveType = context.dropDownProviderWatch.getValue(
      'leaveType',
    );
    final isPermissionSelected =
        selectedLeaveType?.toLowerCase() == 'permission';

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        spacing: 14.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Type Drop Down TextForm Field
          KDropdownTextFormField<String>(
            hintText: "Select Type",
            value: context.dropDownProviderWatch.getValue('leaveType'),
            items: [
              'Sick Leave',
              'Periods Leave',
              'Casual Leave',
              'UnPaid Leave',
              'paternity leave',
              'permission',
            ],
            onChanged: (value) =>
                context.dropDownProviderRead.setValue('leaveType', value),
          ),

          // Conditional Timing Drop Down TextForm Field - Only show when permission is selected
          if (isPermissionSelected) ...[
            KDropdownTextFormField<String>(
              hintText: "Select timing",
              value: context.dropDownProviderWatch.getValue('permissionHour'),
              items: ['1 Hour', '2 Hour', '3 Hour', '4 Hour'],
              onChanged: (value) => context.dropDownProviderRead.setValue(
                'permissionHour',
                value,
              ),
            ),
          ],
          // Start Date TextFormField
          KAuthTextFormField(
            onTap: () {
              selectDate(context, startDateController);
            },
            hintText: "Enter start date",
            suffixIcon: Icons.calendar_month_outlined,
            controller: startDateController,
            keyboardType: TextInputType.datetime,
          ),

          // End Date TextFormField
          KAuthTextFormField(
            hintText: "Enter end date",
            onTap: () {
              selectDate(context, endDateController);
            },
            suffixIcon: Icons.calendar_month_outlined,
            controller: endDateController,
            keyboardType: TextInputType.datetime,
          ),

          // Reason TextFormField
          KAuthTextFormField(
            hintText: "Enter reason",
            suffixIcon: Icons.description,
            controller: reasonController,
            keyboardType: TextInputType.text,
            maxLines: 4,
          ),

          KVerticalSpacer(height: 20.h),

          // Request Btn
          KAuthFilledBtn(
            height: AppResponsive.responsiveBtnHeight(context),
            fontSize: 10.sp,
            width: double.infinity,
            text: "Request",
            onPressed: () async {
              final employeeBox = Hive.box('employeeDetails');
              AppLoggerHelper.logInfo("Hive keys: ${employeeBox.keys}");
              AppLoggerHelper.logInfo("Hive values: ${employeeBox.toMap()}");

              try {
                final type = context.dropDownProviderRead.getValue('leaveType');
                final startDate = formatDate(startDateController.text);
                final timing = context.dropDownProviderRead.getValue(
                  'permissionHour',
                );
                final endDate = formatDate(endDateController.text);
                final reason = reasonController.text;

                if (type == null ||
                    startDate.isEmpty ||
                    endDate.isEmpty ||
                    reason.isEmpty) {
                  KSnackBar.failure(context, "Please fill all fields");
                  return;
                }

                // Additional validation for permission type
                if (type.toLowerCase() == 'permission' && timing == null) {
                  KSnackBar.failure(
                    context,
                    "Please select timing for permission",
                  );
                  return;
                }

                // Send API request
                final dioService = getIt<DioService>();
                final leaveRemoteDataSource = LeaveRemoteDataSource(
                  dioService.client,
                );

                await leaveRemoteDataSource.sendLeaveRequest(
                  type: type,
                  fromDate: startDate,
                  toDate: endDate,
                  reason: reason,
                  permissionTiming: type.toLowerCase() == 'permission'
                      ? timing ?? ''
                      : '', // Only send timing for permission
                );

                // Show success message
                KSnackBar.success(
                  context,
                  "Leave request submitted successfully",
                );

                // Optionally clear fields
                startDateController.clear();
                endDateController.clear();
                reasonController.clear();
                context.dropDownProviderRead.setValue('leaveType', null);
                context.dropDownProviderRead.setValue(
                  'permissionHour',
                  null,
                ); // Clear timing too
              } catch (e) {
                AppLoggerHelper.logError('Leave request error: $e');
                KSnackBar.failure(context, "Error: ${e.toString()}");
              }
            },
            backgroundColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}
