import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_upload_picker_tile.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/models/file_preview_data.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/core/utils/file_picker.dart';
import 'package:fuoday/core/utils/month_picker.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/performance/domain/entities/employee_audit_form_entity.dart';
import 'package:go_router/go_router.dart';

class PerformanceAuditForm extends StatefulWidget {
  const PerformanceAuditForm({super.key});

  @override
  State<PerformanceAuditForm> createState() => _PerformanceAuditFormState();
}

class _PerformanceAuditFormState extends State<PerformanceAuditForm> {
  // File Picker Service
  final filePickerService = getIt<AppFilePicker>();

  // Controllers
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController employeeDesignationController =
      TextEditingController();
  final TextEditingController employeeDepartmentController =
      TextEditingController();
  final TextEditingController employeeReportingManagerController =
      TextEditingController();
  final TextEditingController employeeDateOfJoinController =
      TextEditingController();
  final TextEditingController employeeAttendanceController =
      TextEditingController();
  final TextEditingController employeeWorkModeController =
      TextEditingController();
  final TextEditingController employeeTechnicalSkillsController =
      TextEditingController();
  final TextEditingController employeeTaskHighlightsController =
      TextEditingController();
  final TextEditingController employeePersonalHighlightsController =
      TextEditingController();
  final TextEditingController employeeAreasToImproveController =
      TextEditingController();
  final TextEditingController employeeLearningAndCertificateDoneController =
      TextEditingController();
  final TextEditingController employeeSuggestionsToCompanyController =
      TextEditingController();
  final TextEditingController employeePreviousCycleGoalsController =
      TextEditingController();
  final TextEditingController employeeGoalAchievementsController =
      TextEditingController();
  final TextEditingController employeeProjectWorkedOnController =
      TextEditingController();
  final TextEditingController employeeTaskModuleCompletedController =
      TextEditingController();
  final TextEditingController employeeFinalRemarksController =
      TextEditingController();
  final TextEditingController employeeAuditMonthController =
      TextEditingController();
  final TextEditingController employeeProjectWorkedController =
      TextEditingController();
  final TextEditingController employeeInitiativeTakenController =
      TextEditingController();

  // Initialize Controllers With Data
  void _initializeControllersWithData() {
    final provider = context.employeeAuditProviderRead;
    final auditData = provider.audit;

    if (auditData != null) {
      employeeNameController.text = auditData.employeeName?.toString() ?? '';
      employeeIdController.text = auditData.empId?.toString() ?? '';
      employeeDesignationController.text =
          auditData.designation?.toString() ?? '';
      employeeDepartmentController.text =
          auditData.department?.toString() ?? '';
      employeeReportingManagerController.text =
          auditData.reportingManager?.toString() ?? '';
      employeeDateOfJoinController.text =
          auditData.dateOfJoining?.toString() ?? '';
      employeeAttendanceController.text =
          auditData.attendanceSummary?.present?.toString() ?? '';
      employeeWorkModeController.text = auditData.workingMode?.toString() ?? '';
    }
  }

  // Service
  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;
  late final String name;
  late final int webUserId;

  @override
  void initState() {
    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    name = employeeDetails?['name'] ?? "No Name";
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    Future.microtask(() async {
      await context.employeeAuditProviderRead.fetchEmployeeAudit(webUserId);
      // Initialize controllers after data is fetched
      _initializeControllersWithData();
    });
    super.initState();
  }

  @override
  void dispose() {
    employeeNameController.dispose();
    employeeIdController.dispose();
    employeeDesignationController.dispose();
    employeeDepartmentController.dispose();
    employeeReportingManagerController.dispose();
    employeeDateOfJoinController.dispose();
    employeeAttendanceController.dispose();
    employeeWorkModeController.dispose();
    employeeTechnicalSkillsController.dispose();
    employeeTaskHighlightsController.dispose();
    employeePersonalHighlightsController.dispose();
    employeeAreasToImproveController.dispose();
    employeeLearningAndCertificateDoneController.dispose();
    employeeSuggestionsToCompanyController.dispose();
    employeePreviousCycleGoalsController.dispose();
    employeeGoalAchievementsController.dispose();
    employeeProjectWorkedOnController.dispose();
    employeeTaskModuleCompletedController.dispose();
    employeeFinalRemarksController.dispose();
    employeeProjectWorkedController.dispose();
    employeeAuditMonthController.dispose();
    employeeInitiativeTakenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        spacing: 14.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          KText(
            text: "Individual Overview & Performance Identity",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.primaryColor,
          ),

          KVerticalSpacer(height: 6.h),

          // Employee Name
          KAuthTextFormField(
            controller: employeeNameController,
            hintText: "Employee Name",
            keyboardType: TextInputType.name,
            suffixIcon: Icons.person_outline,
            isReadOnly: true,
            label: "Employee Name",
          ),

          // Employee Id
          KAuthTextFormField(
            controller: employeeIdController,
            hintText: "Employee ID",
            suffixIcon: Icons.important_devices,
            isReadOnly: true,
            label: "Employee ID",
          ),

          // Designation
          KAuthTextFormField(
            controller: employeeDesignationController,
            hintText: "Designation",
            suffixIcon: Icons.important_devices,
            isReadOnly: true,
            label: "Designation",
          ),

          // Department
          KAuthTextFormField(
            controller: employeeDepartmentController,
            hintText: "Department",
            suffixIcon: Icons.location_city,
            isReadOnly: true,
            label: "Department",
          ),

          // Reporting Manger
          KAuthTextFormField(
            controller: employeeReportingManagerController,
            hintText: "Reporting Manager",
            suffixIcon: Icons.person_outline,
            isReadOnly: true,
            label: "Reporting Manager",
          ),

          // Date Of Join
          KAuthTextFormField(
            controller: employeeDateOfJoinController,
            hintText: "Date of Joining",
            suffixIcon: Icons.calendar_month_outlined,
            isReadOnly: true,
            label: "Date of Joining",
          ),

          // Attendance
          KAuthTextFormField(
            controller: employeeAttendanceController,
            hintText: "Attendance",
            suffixIcon: Icons.percent,
            isReadOnly: true,
            label: "Attendance",
          ),

          // Work Mode
          KAuthTextFormField(
            controller: employeeWorkModeController,
            hintText: "Work Mode",
            suffixIcon: Icons.work_history_outlined,
            isReadOnly: true,
            label: "Work Mode",
          ),

          KText(
            text: "Review Period",
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),

          // Select Category
          KDropdownTextFormField<String>(
            hintText: "Select Review Period",
            value: context.dropDownProviderWatch.getValue('reviewPeriod'),
            items: ['Q1', 'Q2', 'H1', 'Annual'],
            onChanged: (value) {
              context.dropDownProviderRead.setValue('reviewPeriod', value);
            },
          ),

          KText(
            text: "Audit Cycle Type",
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),

          // Audit Month
          KAuthTextFormField(
            onTap: () {
              selectMonthYearPicker(context, employeeAuditMonthController);
            },
            hintText: "Select Month & Year",
            suffixIcon: Icons.calendar_month_outlined,
            keyboardType: TextInputType.text,
            controller: employeeAuditMonthController,
          ),

          // Audit Cycle Type
          KDropdownTextFormField<String>(
            hintText: "Select Audit Cycle Type",
            value: context.dropDownProviderWatch.getValue('auditCycleType'),
            items: ['Quarterly', '6 Months', 'One Year'],
            onChanged: (value) =>
                context.dropDownProviderRead.setValue('auditCycleType', value),
          ),

          KVerticalSpacer(height: 20.h),

          // Title
          KText(
            text: "Self Evaluation & Professional Insights",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.primaryColor,
          ),

          KVerticalSpacer(height: 6.h),

          // Rating Bar
          RatingBar.builder(
            initialRating: context.ratingProviderWatch.rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {
              context.ratingProviderRead.setRating(rating);
            },
          ),

          // Work Mode
          KAuthTextFormField(
            controller: employeeTechnicalSkillsController,
            hintText: "Technical Skills",
            suffixIcon: Icons.work_history_outlined,
            isReadOnly: false,
            label: "Technical Skills",
          ),

          KVerticalSpacer(height: 20.h),

          // Title
          KText(
            text: "Communication & Collaboration",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.primaryColor,
          ),

          KVerticalSpacer(height: 6.h),

          KText(
            text: "Communication & Collaboration",
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),

          // Daily Standups
          KDropdownTextFormField<String>(
            hintText: "Select Communication & Collaboration",
            value: context.dropDownProviderWatch.getValue(
              'communicationAndCollaboration',
            ),
            items: ['Good', 'Poor', 'Excellent'],
            onChanged: (value) => context.dropDownProviderRead.setValue(
              'communicationAndCollaboration',
              value,
            ),
          ),

          KText(
            text: "Cross-Functional Involvement",
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),

          // Cross Functional Involvement
          KDropdownTextFormField<String>(
            hintText: "Select Cross-Functional Involvement",
            value: context.dropDownProviderWatch.getValue(
              'crossFunctionalInvolvement',
            ),
            items: ['Tech Support', 'BD Support'],
            onChanged: (value) => context.dropDownProviderRead.setValue(
              'crossFunctionalInvolvement',
              value,
            ),
          ),

          // task highlights
          KAuthTextFormField(
            controller: employeeTaskHighlightsController,
            hintText: "eg: Closed 3 sprints",
            suffixIcon: Icons.task_outlined,
            maxLines: 4,
            label: "Task highlights",
          ),

          //Personal Highlights
          KAuthTextFormField(
            controller: employeePersonalHighlightsController,
            hintText: "eg: Deployed CI/CD pipeline",
            suffixIcon: Icons.task_outlined,
            maxLines: 4,
            label: "Personal Highlights",
          ),

          //Areas to Improve
          KAuthTextFormField(
            controller: employeeAreasToImproveController,
            hintText: "eg: Time estimation, spring velocity",
            suffixIcon: Icons.task_outlined,
            maxLines: 4,
            label: "Areas to Improve",
          ),

          // Initiative Taken Text Field
          KAuthTextFormField(
            controller: employeeLearningAndCertificateDoneController,
            hintText: "Initiative taken",
            suffixIcon: Icons.task_outlined,
            maxLines: 2,
            label: "Initiative Taken",
          ),

          //Learning/Certifications Done
          KAuthTextFormField(
            controller: employeeLearningAndCertificateDoneController,
            hintText: "e.g: AWS DevOps Bootcamp(Udemy)",
            suffixIcon: Icons.task_outlined,
            maxLines: 4,
            label: "Learning/Certifications Done",
          ),

          //Learning/Certifications Done
          KAuthTextFormField(
            controller: employeeSuggestionsToCompanyController,
            hintText: "e.g Need Shared test/stage environment",
            suffixIcon: Icons.task_outlined,
            maxLines: 4,
            label: "Suggestions to Company",
          ),

          // Title
          KText(
            text: "Key Result Areas & Goal Evaluation",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.primaryColor,
          ),

          // Previous Cycle Goals
          KAuthTextFormField(
            controller: employeePreviousCycleGoalsController,
            hintText: "e.g ResumeHub deployment by 25th May",
            suffixIcon: Icons.task_outlined,
            maxLines: 4,
            label: "Previous Cycle Goals",
          ),

          //monthly task highlights
          KAuthTextFormField(
            hintText: "eg: 80",
            suffixIcon: Icons.task_outlined,
            label: "Goal Achievement %",
          ),

          // Suggestion to company
          KAuthTextFormField(
            controller: employeeProjectWorkedOnController,
            hintText: "e.g Need Shared test/stage environment",
            suffixIcon: Icons.task_outlined,
            maxLines: 4,
            label: "Projects Worked On",
          ),

          // Tasks/Module Completed
          KAuthTextFormField(
            controller: employeeTaskModuleCompletedController,
            hintText: "e.g Resume Hub, API Refactor",
            suffixIcon: Icons.task_outlined,
            maxLines: 4,
            label: "Tasks/Module Completed",
          ),

          // KPI Metrics
          KUploadPickerTile(
            showOnlyView: context.filePickerProviderWatch.isPicked(
              'kpiMetrics',
            ),
            onViewTap: () {
              final pickedFile = context.filePickerProviderRead.getFile(
                "kpiMetrics",
              );
              if (pickedFile == null) return;

              final filePath = pickedFile.path;
              final fileName = pickedFile.name.toLowerCase();

              if (fileName.endsWith('.pdf')) {
                // Pdf Preview Screen
                GoRouter.of(context).pushNamed(
                  AppRouteConstants.pdfPreview,
                  extra: FilePreviewData(
                    filePath: filePath!,
                    fileName: fileName,
                  ),
                );
              } else if (fileName.endsWith('.png') ||
                  fileName.endsWith('.jpg') ||
                  fileName.endsWith('.jpeg') ||
                  fileName.endsWith('.webp')) {
                // Image Preview Screen
                GoRouter.of(context).pushNamed(
                  AppRouteConstants.imagePreview,
                  extra: FilePreviewData(
                    filePath: filePath!,
                    fileName: fileName,
                  ),
                );
              } else {
                KSnackBar.failure(context, "Unsupported file type");
              }
            },
            showCancel: context.filePickerProviderWatch.isPicked("kpiMetrics"),
            onCancelTap: () {
              context.filePickerProviderRead.removeFile("kpiMetrics");
              KSnackBar.success(context, "File removed successfully");
            },
            uploadOnTap: () async {
              final key = "kpiMetrics";
              final filePicker = context.filePickerProviderRead;
              await filePicker.pickFile(key);

              final pickedFile = filePicker.getFile(key);
              if (filePicker.isPicked(key)) {
                AppLoggerHelper.logInfo('Picked file: ${pickedFile!.name}');
                KSnackBar.success(context, 'Picked file: ${pickedFile.name}');
              } else {
                AppLoggerHelper.logError('No file selected.');
                KSnackBar.failure(context, 'No file selected.');
              }
            },
            uploadPickerTitle: "kpiMetrics",
            uploadPickerIcon:
                context.filePickerProviderWatch.isPicked("kpiMetrics")
                ? Icons.check_circle
                : Icons.upload,
            description:
                context.filePickerProviderWatch.getFile("kpiMetrics") != null
                ? "Selected File: ${context.filePickerProviderWatch.getFile("kpiMetrics")!.name}"
                : "Upload your KPI Metrics",
          ),

          KAuthTextFormField(
            controller: employeeProjectWorkedController,
            hintText: "Project worked",
            suffixIcon: Icons.task_outlined,
            maxLines: 3,
            label: "Project worked",
          ),

          // Performance Evidence
          KUploadPickerTile(
            showOnlyView: context.filePickerProviderWatch.isPicked(
              'performanceEvidence',
            ),
            onViewTap: () {
              final pickedFile = context.filePickerProviderRead.getFile(
                'performanceEvidence',
              );
              if (pickedFile == null) return;

              final filePath = pickedFile.path;
              final fileName = pickedFile.name.toLowerCase();

              if (fileName.endsWith('.pdf')) {
                // Pdf Preview Screen
                GoRouter.of(context).pushNamed(
                  AppRouteConstants.pdfPreview,
                  extra: FilePreviewData(
                    filePath: filePath!,
                    fileName: fileName,
                  ),
                );
              } else if (fileName.endsWith('.png') ||
                  fileName.endsWith('.jpg') ||
                  fileName.endsWith('.jpeg') ||
                  fileName.endsWith('.webp')) {
                // Image Preview Screen
                GoRouter.of(context).pushNamed(
                  AppRouteConstants.imagePreview,
                  extra: FilePreviewData(
                    filePath: filePath!,
                    fileName: fileName,
                  ),
                );
              } else {
                KSnackBar.failure(context, "Unsupported file type");
              }
            },
            showCancel: context.filePickerProviderWatch.isPicked(
              'performanceEvidence',
            ),
            onCancelTap: () {
              context.filePickerProviderRead.removeFile('performanceEvidence');
              KSnackBar.success(context, "File removed successfully");
            },
            uploadOnTap: () async {
              final key = 'performanceEvidence';
              final filePicker = context.filePickerProviderRead;
              await filePicker.pickFile(key);

              final pickedFile = filePicker.getFile(key);
              if (filePicker.isPicked(key)) {
                AppLoggerHelper.logInfo('Picked file: ${pickedFile!.name}');
                KSnackBar.success(context, 'Picked file: ${pickedFile.name}');
              } else {
                AppLoggerHelper.logError('No file selected.');
                KSnackBar.failure(context, 'No file selected.');
              }
            },
            uploadPickerTitle: "Performance Evidence",
            uploadPickerIcon:
                context.filePickerProviderWatch.isPicked('performanceEvidence')
                ? Icons.check_circle
                : Icons.upload,
            description:
                context.filePickerProviderWatch.getFile(
                      'performanceEvidence',
                    ) !=
                    null
                ? "Selected File: ${context.filePickerProviderWatch.getFile("performanceEvidence")!.name}"
                : "Upload your Performance Evidence",
          ),

          KVerticalSpacer(height: 20.h),

          // Submit
          KAuthFilledBtn(
            backgroundColor: AppColors.primaryColor,
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            height: AppResponsive.responsiveBtnHeight(context),
            width: double.infinity,
            text: "Submit",
            onPressed: () async {
              try {
                // Files
                final pickedPerformanceEvidenceFile = context
                    .filePickerProviderRead
                    .getFile('performanceEvidence');
                final pickerKPIMetricsFile = context.filePickerProviderRead
                    .getFile("kpiMetrics");
                final rating = context.ratingProviderRead.rating;

                // Entity
                final entity = EmployeeAuditFormEntity(
                  webUserId: webUserId,
                  auditCycleType: context.dropDownProviderRead.getValue(
                    'auditCycleType',
                  ),
                  reviewPeriod: context.dropDownProviderRead.getValue(
                    'reviewPeriod',
                  ),
                  auditMonth: employeeAuditMonthController.text.trim(),
                  selfRating: rating.toString(),
                  technicalSkillsUsed: employeeTechnicalSkillsController.text
                      .trim(),
                  communicationCollaboration: context.dropDownProviderRead
                      .getValue('communicationAndCollaboration'),
                  crossFunctionalInvolvement: context.dropDownProviderRead
                      .getValue('crossFunctionalInvolvement'),
                  taskHighlight: employeeTaskHighlightsController.text.trim(),
                  personalHighlight: employeePersonalHighlightsController.text
                      .trim(),
                  areasToImprove: employeeAreasToImproveController.text.trim(),
                  initiativeTaken: employeeInitiativeTakenController.text
                      .trim(),
                  learningsCertifications:
                      employeeLearningAndCertificateDoneController.text.trim(),
                  suggestionsToCompany: employeeSuggestionsToCompanyController
                      .text
                      .trim(),
                  previousCycleGoals: employeePreviousCycleGoalsController.text
                      .trim(),
                  goalAchievement: employeeGoalAchievementsController.text
                      .trim(),
                  kpiMetrics:
                      pickerKPIMetricsFile?.name ?? "No KPI Metrics Found",
                  projectsWorked: employeeProjectWorkedController.text.trim(),
                  tasksModulesCompleted: employeeTaskModuleCompletedController
                      .text
                      .trim(),
                  performanceEvidences:
                      pickedPerformanceEvidenceFile?.name ??
                      "NO PERFORMANCE EVIDENCE FOUND",
                );

                // Logging
                AppLoggerHelper.logInfo('Submitting Employee Audit Form...');
                AppLoggerHelper.logInfo(entity.toString());

                // Submit
                await context.employeeAuditFormProviderRead.postAuditForm(
                  entity,
                );

                // ✅ Show success snackbar
                KSnackBar.success(
                  context,
                  'Audit form submitted successfully!',
                );
              } catch (e, stack) {
                AppLoggerHelper.logError('Audit form submission failed: $e');
                AppLoggerHelper.logError(stack.toString());

                // ❌ Show error snackbar
                KSnackBar.failure(
                  context,
                  'Something went wrong. Please try again.',
                );
              }
            },
          ),

          KVerticalSpacer(height: 20.h),
        ],
      ),
    );
  }
}
