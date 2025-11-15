import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/providers/dropdown_provider.dart';
import 'package:fuoday/commons/widgets/k_app_%20bar_with_drawer.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/leave_tracker/domain/entities/leave_regulation_entity.dart';
import 'package:fuoday/features/leave_tracker/presentation/providers/leave_regulation_provider.dart';
import 'package:fuoday/features/leave_tracker/presentation/screens/leave_balance.dart';
import 'package:fuoday/features/leave_tracker/presentation/screens/leave_reports.dart';
import 'package:fuoday/features/leave_tracker/presentation/screens/leave_request.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LeaveTrackerScreen extends StatefulWidget {
  const LeaveTrackerScreen({super.key});

  @override
  State<LeaveTrackerScreen> createState() => _LeaveTrackerScreenState();
}

class _LeaveTrackerScreenState extends State<LeaveTrackerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController fromDateMonthYearController =
      TextEditingController();
  final TextEditingController toDateMonthYearController =
      TextEditingController();
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController empIdController = TextEditingController();
  final TextEditingController regulationReasonController =
      TextEditingController();
  final TextEditingController regulationCommentController =
      TextEditingController();
  @override
  void dispose() {
    fromDateMonthYearController.dispose();
    toDateMonthYearController.dispose();
    employeeNameController.dispose();
    empIdController.dispose();
    regulationReasonController.dispose();
    regulationCommentController.dispose();
    super.dispose();
  }

  // Method to clear all form fields
  void _clearFormFields() {
    fromDateMonthYearController.clear();
    toDateMonthYearController.clear();
    regulationReasonController.clear();
    regulationCommentController.clear();
  }

  // Method to validate form
  bool _validateForm() {
    if (fromDateMonthYearController.text.isEmpty) {
      KSnackBar.failure(context, "Please select from date");
      return false;
    }
    if (toDateMonthYearController.text.isEmpty) {
      KSnackBar.failure(context, "Please select to date");
      return false;
    }
    if (regulationReasonController.text.trim().isEmpty) {
      KSnackBar.failure(context, "Please enter regulation reason");
      return false;
    }

    // Check if from date is before to date
    try {
      DateTime fromDate = DateTime.parse(fromDateMonthYearController.text);
      DateTime toDate = DateTime.parse(toDateMonthYearController.text);

      if (fromDate.isAfter(toDate)) {
        KSnackBar.failure(context, "From date cannot be after to date");
        return false;
      }
    } catch (e) {
      KSnackBar.failure(context, "Invalid date format");
      return false;
    }

    return true;
  }

  // Method to handle form submission
  void _submitForm() async {
    if (!_validateForm()) return;

    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final webUserIdString = employeeDetails?['web_user_id'];
    final webUserId = webUserIdString is String
        ? int.tryParse(webUserIdString) ?? 0
        : (webUserIdString ?? 0) as int;

    final entity = LeaveRegulationEntity(
      webUserId: webUserId,
      fromDate: fromDateMonthYearController.text,
      toDate: toDateMonthYearController.text,
      reason: regulationReasonController.text,
      comment: regulationCommentController.text,
    );

    final provider = context.read<LeaveRegulationProvider>();

    try {
      await provider.submitRegulation(entity);
      _clearFormFields();
      KSnackBar.success(context, "Leave regulation submitted successfully!");
      GoRouter.of(context).pop();
    } catch (e) {
      KSnackBar.failure(context, "Failed to submit leave regulation: $e");
    }
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
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
                primary: theme.primaryColor,
                onPrimary: theme.secondaryHeaderColor,
                onSurface:
                    theme.textTheme.headlineLarge?.color ??
                    AppColors.titleColor,
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      }
    }

    // Get employee details from Hive with error handling
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Safe extraction of employee details
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No email";
    final empId = employeeDetails?['empId'] ?? "No Employee ID";

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: KAppBarWithDrawer(
          userName: name,
          cachedNetworkImageUrl: profilePhoto,
          userDesignation: designation,
          showUserInfo: true,
          onDrawerPressed: _openDrawer,
          onNotificationPressed: () {},
        ),
        drawer: KDrawer(
          userName: name,
          userEmail: email,
          profileImageUrl: profilePhoto,
        ),
        bottomNavigationBar: Container(
          height: 60.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: Center(
            child: KAuthFilledBtn(
              backgroundColor: theme.primaryColor,
              height: AppResponsive.responsiveBtnHeight(context),
              width: double.infinity,
              text: "Edit",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                        bottom:
                            MediaQuery.of(context).viewInsets.bottom +
                            20.h, // keyboard aware
                        top: 10.h,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Drag handle
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 2.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: theme.textTheme.bodyLarge?.color,
                                ),
                              ),
                            ),

                            KVerticalSpacer(height: 12.h),

                            // Create Ticket
                            KText(
                              text: "Leave Regulation",
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: theme.textTheme.headlineLarge?.color,
                            ),

                            KVerticalSpacer(height: 10.h),

                            // Employee name
                            KAuthTextFormField(
                              hintText: name,
                              controller: employeeNameController,
                              keyboardType: TextInputType.text,
                              suffixIcon: Icons.perm_identity_outlined,
                              isReadOnly: true,
                            ),
                            KVerticalSpacer(height: 10.h),

                            KAuthTextFormField(
                              maxLines: 1,
                              hintText: empId,
                              controller: empIdController,
                              keyboardType: TextInputType.text,
                              suffixIcon: Icons.card_travel_rounded,
                              isReadOnly: true,
                            ),
                            KVerticalSpacer(height: 10.h),
                            KAuthTextFormField(
                              hintText: "From Date",
                              onTap: () async {
                                selectDate(
                                  context,
                                  fromDateMonthYearController,
                                );
                              },
                              controller: fromDateMonthYearController,
                              keyboardType: TextInputType.datetime,
                              suffixIcon: Icons.date_range,
                            ),
                            KVerticalSpacer(height: 10.h),

                            KAuthTextFormField(
                              hintText: "To Date",
                              onTap: () async {
                                selectDate(context, toDateMonthYearController);
                              },
                              controller: toDateMonthYearController,
                              keyboardType: TextInputType.datetime,
                              suffixIcon: Icons.date_range,
                            ),
                            KVerticalSpacer(height: 10.h),

                            KAuthTextFormField(
                              maxLines: 3,
                              hintText: "Regulation Reason",
                              controller: regulationReasonController,
                              keyboardType: TextInputType.text,
                              suffixIcon: Icons.category_rounded,
                            ),
                            KVerticalSpacer(height: 10.h),

                            KAuthTextFormField(
                              hintText: "Regulation Comment",
                              controller: regulationCommentController,
                              keyboardType: TextInputType.text,
                              suffixIcon: Icons.description,
                            ),
                            KVerticalSpacer(height: 10.h),
                            // Cancel
                            KAuthFilledBtn(
                              height: AppResponsive.responsiveBtnHeight(
                                context,
                              ),
                              width: double.infinity,
                              text: "Cancel",
                              fontSize: 10.sp,
                              textColor: theme.primaryColor,
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              backgroundColor: theme.primaryColor.withOpacity(
                                0.4,
                              ),
                            ),

                            SizedBox(height: 12.h),

                            // Submit
                            KAuthFilledBtn(
                              height: AppResponsive.responsiveBtnHeight(
                                context,
                              ),
                              fontSize: 10.sp,
                              width: double.infinity,
                              text: "Submit",
                              textColor: theme.secondaryHeaderColor,
                              onPressed:
                                  _submitForm, // Updated to use the new submit method
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              fontSize: 11.sp,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tab bar
              KTabBar(
                tabs: [
                  // Leave Balanced
                  Tab(text: "Leave Balance"),
                  // Leave Reports
                  Tab(text: "Leave Reports"),
                  // Request Leave
                  Tab(text: "Leave Requests"),
                ],
              ),

              KVerticalSpacer(height: 20.h),

              Expanded(
                child: TabBarView(
                  children: [
                    // Leave Balance
                    LeaveBalance(),

                    // Leave Reports
                    LeaveReports(attendanceValues: [], months: []),

                    // Leave Request
                    LeaveRequest(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
