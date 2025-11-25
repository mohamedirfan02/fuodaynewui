import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:intl/intl.dart';

class JobInformationScreen extends StatefulWidget {
  const JobInformationScreen({super.key});

  @override
  State<JobInformationScreen> createState() => _JobInformationScreenState();
}

class _JobInformationScreenState extends State<JobInformationScreen> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //   Separate Date Controllers
  final TextEditingController interviewDateController = TextEditingController();
  final TextEditingController openedDateController = TextEditingController();
  final TextEditingController closedDateController = TextEditingController();
  final TextEditingController appliedDateController = TextEditingController();

  //   Separate Controllers for TextFields
  final TextEditingController designationController = TextEditingController();
  final TextEditingController hiringManagerController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController coverLetterController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  //   Separate Date Variables
  DateTime? interviewDate;
  DateTime? openedDate;
  DateTime? closedDate;
  DateTime? appliedDate;

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  @override
  void dispose() {
    interviewDateController.dispose();
    openedDateController.dispose();
    closedDateController.dispose();
    appliedDateController.dispose();

    designationController.dispose();
    hiringManagerController.dispose();
    jobLocationController.dispose();
    coverLetterController.dispose();
    feedbackController.dispose();
    super.dispose();
  }

  PlatformFile? selectedCoverLetterFile;

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
    ValueChanged<DateTime> onPicked,
  ) async {
    //App Theme Data
    final theme = Theme.of(context);
    //  final isDark = theme.brightness == Brightness.dark;
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              surface: theme.secondaryHeaderColor,
              primary: theme.primaryColor,
              onPrimary: theme.secondaryHeaderColor, //AppColors.secondaryColor
              onSurface:
                  theme.textTheme.headlineLarge?.color ??
                  AppColors.titleColor, //AppColors.titleColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(picked);
      onPicked(picked);
    }
  }

  bool _validateDropdown(BuildContext context, String key, String label) {
    final value = context.dropDownProviderRead.getValue(key);
    if (value == null || value.isEmpty) {
      KSnackBar.failure(context, "Please select $label");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "No Name";
    final email = employeeDetails?['email'] ?? "No Email";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final String currentRoute = AppRouteConstants.atsCandidateInformationScreen;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.cardColor, //ATS Background Color
      appBar: AtsKAppBarWithDrawer(
        userName: "",
        cachedNetworkImageUrl: profilePhoto,
        userDesignation: "",
        showUserInfo: true,
        onDrawerPressed: _openDrawer,
        onNotificationPressed: () {},
      ),
      drawer: KAtsDrawer(
        userName: name,
        userEmail: email,
        currentRoute: currentRoute,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: "Job Information",
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                //  color: AppColors.titleColor,
              ),
              SizedBox(height: 10.h),

              // Job Title
              const KTitleText(title: "Job Title"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Select Title",
                value: context.dropDownProviderRead.getValue("Job Title"),
                items: ["Developer", "Designer", "Manager"],
                onChanged: (v) =>
                    context.dropDownProviderRead.setValue("Job Title", v),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Please select Title";
                  return null;
                },
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Designation",
                controller: designationController,
                hintText: "Enter designation",
                isRequiredStar: true,
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter designation" : null,
              ),

              KVerticalSpacer(height: 16.h),
              const KTitleText(title: "Department"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Select Department",
                value: context.dropDownProviderRead.getValue("Department"),
                items: ["HR", "IT", "Finance"],
                onChanged: (v) =>
                    context.dropDownProviderRead.setValue("Department", v),
                validator: (val) {
                  if (val == null || val.isEmpty)
                    return "Please select Department";
                  return null;
                },
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Interview Date",
                controller: interviewDateController,
                hintText: "dd-mm-yyyy",
                isRequiredStar: true,
                onTap: () => _selectDate(
                  context,
                  interviewDateController,
                  (d) => interviewDate = d,
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Select Interview Date" : null,
                suffixIcon: Icons.date_range,
              ),

              KVerticalSpacer(height: 16.h),
              const KTitleText(title: "Experience"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Select Experience",
                value: context.dropDownProviderRead.getValue("Experience"),
                items: ["0-1 Years", "2-4 Years", "5+ Years"],
                onChanged: (v) =>
                    context.dropDownProviderRead.setValue("Experience", v),
                validator: (val) {
                  if (val == null || val.isEmpty)
                    return "Please select Experience";
                  return null;
                },
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Date Opened",
                controller: openedDateController,
                hintText: "dd-mm-yyyy",
                isRequiredStar: true,
                onTap: () => _selectDate(
                  context,
                  openedDateController,
                  (d) => openedDate = d,
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Select Opened Date" : null,
                suffixIcon: Icons.date_range,
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Date Closed",
                controller: closedDateController,
                hintText: "dd-mm-yyyy",
                isRequiredStar: true,
                onTap: () => _selectDate(
                  context,
                  closedDateController,
                  (d) => closedDate = d,
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Select Closed Date" : null,
                suffixIcon: Icons.date_range,
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Date Applied",
                controller: appliedDateController,
                hintText: "dd-mm-yyyy",
                isRequiredStar: true,
                onTap: () => _selectDate(
                  context,
                  appliedDateController,
                  (d) => appliedDate = d,
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Select Applied Date" : null,
                suffixIcon: Icons.date_range,
              ),

              KVerticalSpacer(height: 16.h),
              const KTitleText(title: "Role"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Select Role",
                value: context.dropDownProviderRead.getValue("Role"),
                items: ["Lead", "Support", "Intern"],
                onChanged: (v) =>
                    context.dropDownProviderRead.setValue("Role", v),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Please select Role";
                  return null;
                },
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Hiring Manager",
                controller: hiringManagerController,
                hintText: "Enter Hiring Manager",
                isRequiredStar: true,
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter Hiring Manager" : null,
              ),

              KVerticalSpacer(height: 16.h),
              const KTitleText(title: "Hiring Status"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Select Status",
                value: context.dropDownProviderRead.getValue("Hiring Status"),
                items: ["Open", "Closed", "On Hold"],
                onChanged: (v) =>
                    context.dropDownProviderRead.setValue("Hiring Status", v),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Please select Status";
                  return null;
                },
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Job Location",
                controller: jobLocationController,
                hintText: "Enter Location",
                isRequiredStar: true,
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter Location" : null,
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Cover Letter",
                suffixIcon: selectedCoverLetterFile == null
                    ? Icons.upload_file_outlined
                    : Icons.close,
                controller: coverLetterController,
                hintText: "Upload Cover Letter",
                isRequiredStar: true,
                isReadOnly: true,
                onTap: () async {
                  // If file is already selected, clear it
                  if (selectedCoverLetterFile != null) {
                    setState(() {
                      selectedCoverLetterFile = null;
                      coverLetterController.clear();
                    });

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('File removed')));
                    return;
                  }

                  // Open file picker
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
                      );

                  if (result != null) {
                    PlatformFile file = result.files.first;

                    setState(() {
                      selectedCoverLetterFile = file;
                      coverLetterController.text = file.name;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('File selected: ${file.name}')),
                    );
                  }
                },
                validator: (v) =>
                    v == null || v.isEmpty ? "Upload Cover Letter" : null,
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Feedback",
                controller: feedbackController,
                hintText: "Enter Feedback",
                isRequiredStar: true,
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter Feedback" : null,
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //BACK BUTTON
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.circular(8),
                  border: Border.all(
                    color:
                        theme.textTheme.bodyLarge?.color ??
                        AppColors.greyColor, //BORDER COLOR,
                  ),
                ),
                height: 33.h,
                width: 130.w,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new,
                        color: theme
                            .textTheme
                            .headlineLarge
                            ?.color, //AppColors.titleColor,
                        size: 18,
                      ),
                      KHorizontalSpacer(width: 7.w),
                      KText(
                        text: "Back",
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        //color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //NEXT BUTTON
            KAuthFilledBtn(
              // suffixIcon: const Icon(
              //   Icons.arrow_forward_ios,
              //   color: Colors.white,
              // ),
              borderRadius: BorderRadiusGeometry.circular(8),
              backgroundColor: theme.primaryColor,
              height: AppResponsive.responsiveBtnHeight(context),
              width: 130.w,
              text: "Save",
              fontSize: 12.sp,
              onPressed: () {
                final formValid = formKey.currentState!.validate();
                final dropdownValid = [
                  _validateDropdown(context, "Job Title", "Job Title"),
                  _validateDropdown(context, "Department", "Department"),
                  _validateDropdown(context, "Experience", "Experience"),
                  _validateDropdown(context, "Role", "Role"),
                  _validateDropdown(context, "Hiring Status", "Hiring Status"),
                ].every((v) => v);

                if (formValid && dropdownValid) {
                  KSnackBar.success(context, "Form submitted successfully!");
                } else {
                  KSnackBar.failure(
                    context,
                    "Please fix all errors before continuing.",
                  );
                }
              },
            ),
          ],
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
