import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/models/file_preview_data.dart';

import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/ats_candidate/presentation/provider/draft_provider.dart';
import 'package:fuoday/features/ats_candidate/widgets/k_ats_file_upload_btn.dart';

import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CandidateInformationScreen extends StatefulWidget {
  const CandidateInformationScreen({super.key});

  @override
  State<CandidateInformationScreen> createState() =>
      _CandidateInformationScreenState();
}

class _CandidateInformationScreenState
    extends State<CandidateInformationScreen> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Controllers for text fields (in requested order)
  final TextEditingController candidateNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobIdController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // Total Experience & Relevant Experience are dropdowns (no text controller required)
  final TextEditingController presentOrgController = TextEditingController();
  // Organization Type is dropdown
  final TextEditingController currentLocController = TextEditingController();
  final TextEditingController prefLocController = TextEditingController();
  // Notice Period is dropdown
  final TextEditingController offerInHandController = TextEditingController();
  final TextEditingController lastCTCController = TextEditingController();
  final TextEditingController expCTCController = TextEditingController();
  final TextEditingController eduQualificationController =
      TextEditingController();
  // Acknowledgement is dropdown
  final TextEditingController recruiterNameController = TextEditingController();
  final TextEditingController dispositionController = TextEditingController();
  // Process is dropdown
  // Email status is dropdown
  // Candidate Status is dropdown
  // DV By is dropdown
  final TextEditingController interviewDateController = TextEditingController();
  // Interview Status is dropdown
  final TextEditingController recruiterScoreController =
      TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  @override
  void dispose() {
    candidateNameController.dispose();
    dateController.dispose();
    jobTitleController.dispose();
    jobIdController.dispose();
    mobileController.dispose();
    emailController.dispose();
    presentOrgController.dispose();
    currentLocController.dispose();
    prefLocController.dispose();
    offerInHandController.dispose();
    lastCTCController.dispose();
    expCTCController.dispose();
    eduQualificationController.dispose();
    recruiterNameController.dispose();
    dispositionController.dispose();
    interviewDateController.dispose();
    recruiterScoreController.dispose();
    feedbackController.dispose();
    super.dispose();
  }

  //void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  Future<void> pickDate(TextEditingController ctrl) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2100),
      builder: (context, child) {
        // keep app theme for date picker
        final theme = Theme.of(context);
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: theme.primaryColor,
              onPrimary: theme.secondaryHeaderColor,
              onSurface: theme.textTheme.headlineLarge?.color ?? Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      ctrl.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final hiveService = getIt<HiveStorageService>();
    // final employeeDetails = hiveService.employeeDetails;
    // final name = employeeDetails?['name'] ?? "No Name";
    // final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    // final email = employeeDetails?['email'] ?? "No Email";

    // Helper local variables for dropdown values (read from provider)
    final dd = context.dropDownProviderRead;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.cardColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: KText(
          text: "Candidate Information",
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  KVerticalSpacer(height: 12.h),
              //   File Upload Section
              KAtsUploadPickerTile(
                backgroundcolor: theme.cardColor, //ATS Background Color
                showOnlyView: context.filePickerProviderWatch.isPicked(
                  "resume",
                ),
                onViewTap: () {
                  final pickedFile = context.filePickerProviderRead.getFile(
                    "resume",
                  );
                  if (pickedFile == null) return;
                  final filePath = pickedFile.path;
                  final fileName = pickedFile.name.toLowerCase();

                  if (fileName.endsWith('.pdf')) {
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
                    GoRouter.of(context).pushNamed(
                      AppRouteConstants.imagePreview,
                      extra: FilePreviewData(
                        filePath: filePath!,
                        fileName: fileName,
                      ),
                    );
                  } else if (fileName.endsWith('.doc') ||
                      fileName.endsWith('.docx')) {
                    KSnackBar.success(
                      context,
                      "Word file selected: ${pickedFile.name}",
                    );
                  } else {
                    KSnackBar.failure(context, "Unsupported file type");
                  }
                },
                showCancel: context.filePickerProviderWatch.isPicked("resume"),
                onCancelTap: () {
                  context.filePickerProviderRead.removeFile("resume");
                  KSnackBar.success(context, "File removed successfully");
                },
                uploadOnTap: () async {
                  final key = "resume";
                  final filePicker = context.filePickerProviderRead;
                  await filePicker.pickFile(key);
                  final pickedFile = filePicker.getFile(key);

                  if (filePicker.isPicked(key)) {
                    AppLoggerHelper.logInfo('Picked file: ${pickedFile!.name}');
                    KSnackBar.success(
                      context,
                      'Picked file: ${pickedFile.name}',
                    );
                  } else {
                    AppLoggerHelper.logError('No file selected.');
                    KSnackBar.failure(context, 'No file selected.');
                  }
                },
                uploadPickerTitle: "",
                uploadPickerIcon:
                    context.filePickerProviderWatch.isPicked("resume")
                    ? Icons.check_circle
                    : Icons.cloud_upload_outlined,
                description:
                    context.filePickerProviderWatch.getFile("resume") != null
                    ? "Selected File: ${context.filePickerProviderWatch.getFile("resume")!.name}"
                    : "Browse file to upload\nSupports .pdf, .doc, .docx",
              ),
              KVerticalSpacer(height: 12.h),

              // 1. Candidate Name
              KAuthTextFormField(
                label: "Candidate Name",
                controller: candidateNameController,
                hintText: "Enter candidate name",
                isRequiredStar: true,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? "Please enter name" : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 2. Date (with picker)
              KAuthTextFormField(
                label: "Date",
                controller: dateController,
                hintText: "dd/mm/yyyy",
                isRequiredStar: true,
                onTap: () => pickDate(dateController),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? "Please select date" : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 3. Job Title
              KAuthTextFormField(
                label: "Job Title",
                controller: jobTitleController,
                hintText: "Enter job title",
                isRequiredStar: true,
                validator: (v) => v == null || v.trim().isEmpty
                    ? "Please enter job title"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 4. Job ID
              KAuthTextFormField(
                label: "Job ID",
                controller: jobIdController,
                hintText: "Enter job id",
                isRequiredStar: true,
                validator: (v) => v == null || v.trim().isEmpty
                    ? "Please enter job id"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 5. Mobile Number
              KAuthTextFormField(
                label: "Mobile Number",
                controller: mobileController,
                hintText: "Enter mobile number",
                keyboardType: TextInputType.phone,
                isRequiredStar: true,
                validator: (v) {
                  if (v == null || v.trim().isEmpty)
                    return "Please enter mobile";
                  if (v.trim().length < 10) return "Enter valid mobile number";
                  return null;
                },
              ),
              KVerticalSpacer(height: 12.h),

              // 6. Email ID
              KAuthTextFormField(
                label: "Email ID",
                controller: emailController,
                hintText: "Enter email",
                keyboardType: TextInputType.emailAddress,
                isRequiredStar: true,
                validator: (v) {
                  if (v == null || v.trim().isEmpty)
                    return "Please enter email";
                  final pattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!pattern.hasMatch(v.trim())) return "Enter valid email";
                  return null;
                },
              ),
              KVerticalSpacer(height: 12.h),

              // 7. Total Experience (DROPDOWN)
              const KTitleText(title: "Total Experience"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Select Total Experience",
                items: ["0-1", "1-3", "3-5", "5-8", "8+"],
                value: dd.getValue("TotalExperience"),
                onChanged: (v) => dd.setValue("TotalExperience", v),
                validator: (v) => v == null || v.isEmpty
                    ? "Please select total experience"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 8. Relevant Experience (DROPDOWN)
              const KTitleText(title: "Relevant Experience"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Select Relevant Experience",
                items: ["0-1", "1-3", "3-5", "5+"],
                value: dd.getValue("RelevantExperience"),
                onChanged: (v) => dd.setValue("RelevantExperience", v),
                validator: (v) => v == null || v.isEmpty
                    ? "Please select relevant experience"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 9. Present Organization (text)
              KAuthTextFormField(
                label: "Present Organization",
                controller: presentOrgController,
                hintText: "Enter present organization",
                isRequiredStar: true,
                validator: (v) => v == null || v.trim().isEmpty
                    ? "Please enter organization"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 10. Organization Type (DROPDOWN)
              const KTitleText(title: "Organization Type"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Select Organization Type",
                items: ["Startup", "MNC", "Corporate", "Consulting", "Other"],
                value: dd.getValue("OrganizationType"),
                onChanged: (v) => dd.setValue("OrganizationType", v),
                validator: (v) => v == null || v.isEmpty
                    ? "Please select organization type"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 11. Current location
              KAuthTextFormField(
                label: "Current Location",
                controller: currentLocController,
                hintText: "Enter current location",
                isRequiredStar: true,
                validator: (v) => v == null || v.trim().isEmpty
                    ? "Please enter current location"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 12. Preferred Location
              KAuthTextFormField(
                label: "Preferred Location",
                controller: prefLocController,
                hintText: "Enter preferred location",
                isRequiredStar: true,
                validator: (v) => v == null || v.trim().isEmpty
                    ? "Please enter preferred location"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 13. Notice Period (DROPDOWN)
              const KTitleText(title: "Notice Period"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Select Notice Period",
                items: [
                  "Immediate",
                  "15 Days",
                  "30 Days",
                  "45 Days",
                  "60 Days",
                  "90 Days",
                ],
                value: dd.getValue("NoticePeriod"),
                onChanged: (v) => dd.setValue("NoticePeriod", v),
                validator: (v) => v == null || v.isEmpty
                    ? "Please select notice period"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 14. Offer in Hand
              KAuthTextFormField(
                label: "Offer in Hand",
                controller: offerInHandController,
                hintText: "Enter offer in hand (if any)",
              ),
              KVerticalSpacer(height: 12.h),

              // 15. Last CTC
              KAuthTextFormField(
                label: "Last CTC",
                controller: lastCTCController,
                hintText: "Enter last CTC",
              ),
              KVerticalSpacer(height: 12.h),

              // 16. Exp CTC
              KAuthTextFormField(
                label: "Expected CTC",
                controller: expCTCController,
                hintText: "Enter expected CTC",
              ),
              KVerticalSpacer(height: 12.h),

              // 17. Edu Qualification
              KAuthTextFormField(
                label: "Education Qualification",
                controller: eduQualificationController,
                hintText: "Enter qualification",
                isRequiredStar: true,
                validator: (v) => v == null || v.trim().isEmpty
                    ? "Please enter qualification"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 18. Acknowledgement (DROPDOWN)
              const KTitleText(title: "Acknowledgement"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Acknowledgement",
                items: ["Yes", "No"],
                value: dd.getValue("Acknowledgement"),
                onChanged: (v) => dd.setValue("Acknowledgement", v),
                validator: (v) => v == null || v.isEmpty
                    ? "Please select acknowledgement"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 19. Recruiter Name
              KAuthTextFormField(
                label: "Recruiter Name",
                controller: recruiterNameController,
                hintText: "Enter recruiter name",
                isRequiredStar: true,
                validator: (v) => v == null || v.trim().isEmpty
                    ? "Please enter recruiter name"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 20. Disposition
              KAuthTextFormField(
                label: "Disposition",
                controller: dispositionController,
                hintText: "Enter disposition",
                isRequiredStar: true,
                validator: (v) => v == null || v.trim().isEmpty
                    ? "Please enter disposition"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 21. Process (DROPDOWN)
              const KTitleText(title: "Process"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Process",
                items: [
                  "Screening",
                  "Shortlisted",
                  "Interviewing",
                  "Offered",
                  "Rejected",
                ],
                value: dd.getValue("Process"),
                onChanged: (v) => dd.setValue("Process", v),
                validator: (v) =>
                    v == null || v.isEmpty ? "Please select process" : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 22. Email status (DROPDOWN)
              const KTitleText(title: "Email Status"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Email Status",
                items: ["Sent", "Not Sent", "Failed"],
                value: dd.getValue("EmailStatus"),
                onChanged: (v) => dd.setValue("EmailStatus", v),
                validator: (v) => v == null || v.isEmpty
                    ? "Please select email status"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 23. Candidate Status (DROPDOWN)
              const KTitleText(title: "Candidate Status"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Candidate Status",
                items: ["Active", "Selected", "Rejected", "On Hold"],
                value: dd.getValue("CandidateStatus"),
                onChanged: (v) => dd.setValue("CandidateStatus", v),
                validator: (v) => v == null || v.isEmpty
                    ? "Please select candidate status"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 24. DV By (DROPDOWN)
              const KTitleText(title: "DV By"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "DV By",
                items: ["Recruiter", "Lead", "Client"],
                value: dd.getValue("DVBy"),
                onChanged: (v) => dd.setValue("DVBy", v),
                validator: (v) =>
                    v == null || v.isEmpty ? "Please select DV By" : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 25. Interview Date (picker text)
              KAuthTextFormField(
                label: "Interview Date",
                controller: interviewDateController,
                hintText: "dd/mm/yyyy",
                onTap: () => pickDate(interviewDateController),
                isRequiredStar: true,
                validator: (v) => v == null || v.trim().isEmpty
                    ? "Please select interview date"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 26. Interview Status (DROPDOWN)
              const KTitleText(title: "Interview Status"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Interview Status",
                items: ["Scheduled", "Cleared", "Rejected", "Pending"],
                value: dd.getValue("InterviewStatus"),
                onChanged: (v) => dd.setValue("InterviewStatus", v),
                validator: (v) => v == null || v.isEmpty
                    ? "Please select interview status"
                    : null,
              ),
              KVerticalSpacer(height: 12.h),

              // 27. Recruiter Score
              KAuthTextFormField(
                label: "Recruiter Score",
                controller: recruiterScoreController,
                hintText: "Enter score (e.g., 1-10)",
                keyboardType: TextInputType.number,
              ),
              KVerticalSpacer(height: 12.h),

              // 28. Feedback
              KAuthTextFormField(
                label: "Feedback",
                controller: feedbackController,
                hintText: "Enter feedback",
                maxLines: 3,
              ),

              KVerticalSpacer(height: 20.h),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: 80,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KAtsGlowButton(
                text: "Add To Draft",
                fontWeight: FontWeight.w600,
                fontSize: 13,
                textColor:
                    theme.textTheme.headlineLarge?.color ??
                    AppColors.titleColor, //AppColors.titleColor,
                onPressed: () {
                  Map<String, dynamic> filledValues = {};

                  // Add all text controllers
                  void add(String key, TextEditingController ctrl) {
                    filledValues[key] = ctrl.text
                        .trim(); // always add, even if empty
                  }

                  add("Candidate Name", candidateNameController);
                  add("Date", dateController);
                  add("Job Title", jobTitleController);
                  add("Job ID", jobIdController);
                  add("Mobile", mobileController);
                  add("Email", emailController);
                  add("Present Organization", presentOrgController);
                  add("Current Location", currentLocController);
                  add("Preferred Location", prefLocController);
                  add("Offer in Hand", offerInHandController);
                  add("Last CTC", lastCTCController);
                  add("Expected CTC", expCTCController);
                  add("Education Qualification", eduQualificationController);
                  add("Recruiter Name", recruiterNameController);
                  add("Disposition", dispositionController);
                  add("Interview Date", interviewDateController);
                  add("Recruiter Score", recruiterScoreController);
                  add("Feedback", feedbackController);

                  // Add dropdown values
                  final dd = context.dropDownProviderRead;
                  filledValues["Total Experience"] =
                      dd.getValue("TotalExperience") ?? "";
                  filledValues["Relevant Experience"] =
                      dd.getValue("RelevantExperience") ?? "";
                  filledValues["Organization Type"] =
                      dd.getValue("OrganizationType") ?? "";
                  filledValues["Notice Period"] =
                      dd.getValue("NoticePeriod") ?? "";
                  filledValues["Acknowledgement"] =
                      dd.getValue("Acknowledgement") ?? "";
                  filledValues["Process"] = dd.getValue("Process") ?? "";
                  filledValues["Email Status"] =
                      dd.getValue("EmailStatus") ?? "";
                  filledValues["Candidate Status"] =
                      dd.getValue("CandidateStatus") ?? "";
                  filledValues["DV By"] = dd.getValue("DVBy") ?? "";
                  filledValues["Interview Status"] =
                      dd.getValue("InterviewStatus") ?? "";

                  /// Save only if something is filled
                  final draftProvider = context.read<DraftProvider>();
                  if (filledValues.isNotEmpty) {
                    draftProvider.saveDraft(filledValues);
                    KSnackBar.success(context, "Draft saved successfully");
                    // GoRouter.of(
                    //   context,
                    // ).pushNamed(AppRouteConstants.atsDraftScreen);
                    GoRouter.of(context).pop();
                  } else {
                    KSnackBar.failure(
                      context,
                      "Please fill at least one field",
                    );
                  }
                },

                backgroundColor: theme.secondaryHeaderColor,
              ),
              KAtsGlowButton(
                width: 130,
                text: "Save",
                fontWeight: FontWeight.w600,
                fontSize: 13,
                textColor: theme.secondaryHeaderColor,
                gradientColors: AppColors.atsButtonGradientColor,
                onPressed: () {
                  // ensure dropdown validations enforced too by checking form & provider values
                  final dropdownRequiredKeys = [
                    "TotalExperience",
                    "RelevantExperience",
                    "OrganizationType",
                    "NoticePeriod",
                    "Acknowledgement",
                    "Process",
                    "EmailStatus",
                    "CandidateStatus",
                    "DVBy",
                    "InterviewStatus",
                  ];

                  bool dropdownsValid = true;
                  for (final key in dropdownRequiredKeys) {
                    final val = context.dropDownProviderRead.getValue(key);
                    if (val == null || (val is String && val.isEmpty)) {
                      dropdownsValid = false;
                      break;
                    }
                  }

                  if (formKey.currentState!.validate() && dropdownsValid) {
                    // GoRouter.of(
                    //   context,
                    // ).pushNamed(AppRouteConstants.atsJobInformationScreen);
                    KSnackBar.success(context, "Save Successfully");
                  } else {
                    if (!dropdownsValid) {
                      KSnackBar.failure(
                        context,
                        "Please select all required dropdowns",
                      );
                    } else {
                      KSnackBar.failure(
                        context,
                        "Please fix validation errors above",
                      );
                    }
                  }
                },
                backgroundColor: theme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🔹 Reusable Title Text Widget
class KTitleText extends StatelessWidget {
  final String title;
  const KTitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Row(
      children: [
        KText(
          text: title,
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
          //  color: AppColors.titleColor,
        ),
        KHorizontalSpacer(width: 4.w),
        KText(
          text: " *",
          color: isDark ? AppColors.softRedDark : Colors.red,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
