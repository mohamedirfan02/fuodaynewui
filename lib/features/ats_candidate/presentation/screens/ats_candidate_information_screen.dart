import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../commons/widgets/k_snack_bar.dart';
import '../../../../commons/widgets/k_text.dart';
import '../../../../commons/widgets/k_vertical_spacer.dart';
import '../../../../core/constants/router/app_route_constants.dart';
import '../../../../core/helper/app_logger_helper.dart';
import '../../../../core/models/file_preview_data.dart';
import '../../../../core/themes/app_colors.dart';
import '../../widgets/k_ats_file_upload_btn.dart';
import '../../../ats_index/presentation/widgets/gmail_compose_index.dart';
import '../../../auth/presentation/widgets/k_auth_filled_btn.dart';
import '../../../auth/presentation/widgets/k_auth_text_form_field.dart';

class CandidateInformationScreen extends StatefulWidget {
  const CandidateInformationScreen({super.key});

  @override
  State<CandidateInformationScreen> createState() =>
      _CandidateInformationScreenState();
}

class _CandidateInformationScreenState
    extends State<CandidateInformationScreen> {
  //   Form Key
  final formKey = GlobalKey<FormState>();

  DateTime? assignDate;
  DateTime selectedDeadline = DateTime.now();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //   Added separate controllers for each text field
  final TextEditingController nameController =
      TextEditingController(); //   Added
  final TextEditingController emailController =
      TextEditingController(); //   Added
  final TextEditingController dobController =
      TextEditingController(); //   Added
  final TextEditingController phoneController =
      TextEditingController(); //   Added
  final TextEditingController statusController =
      TextEditingController(); //   Added
  final TextEditingController jobTitleController =
      TextEditingController(); //   Added
  final TextEditingController employerController =
      TextEditingController(); //   Added
  final TextEditingController linkedinController =
      TextEditingController(); //   Added
  final TextEditingController placeController =
      TextEditingController(); //   Added

  // ⚠️ Removed duplicate use of assignedByController
  final TextEditingController assignDateController = TextEditingController();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
  @override
  void dispose() {
    // 🔹 Dispose all TextEditingControllers
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    phoneController.dispose();
    statusController.dispose();
    jobTitleController.dispose();
    employerController.dispose();
    linkedinController.dispose();
    placeController.dispose();
    assignDateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "No Email";
    final String currentRoute = AppRouteConstants.atsCandidateInformationScreen;

    // 🧩 Moved selectDate inside build for inline use
    Future<void> selectDate(
      BuildContext context,
      TextEditingController controller, {
      required bool isDeadline,
      required bool isAssignDate,
    }) async {
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
        controller.text = DateFormat('dd/MM/yyyy').format(picked);

        if (isDeadline) {
          setState(() => selectedDeadline = picked);
        }
        if (isAssignDate) {
          setState(() => assignDate = picked);
        }
      }
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.atsHomepageBg,
        key: _scaffoldKey,
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
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUnfocus, //   Added
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 16.h),
              decoration: BoxDecoration(color: AppColors.atsHomepageBg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: KText(
                      text: "Candidate Information",
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: AppColors.titleColor,
                    ),
                  ),
                  //SizedBox(height: 16.h),

                  //   File Upload Section
                  KAtsUploadPickerTile(
                    backgroundcolor: AppColors.atsHomepageBg,
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
                    showCancel: context.filePickerProviderWatch.isPicked(
                      "resume",
                    ),
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
                        AppLoggerHelper.logInfo(
                          'Picked file: ${pickedFile!.name}',
                        );
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
                        : Icons.upload,
                    description:
                        context.filePickerProviderWatch.getFile("resume") !=
                            null
                        ? "Selected File: ${context.filePickerProviderWatch.getFile("resume")!.name}"
                        : "Browse file to upload\nSupports .pdf, .doc, .docx",
                  ),

                  SizedBox(height: 20.h),

                  //   Text Fields with Validation
                  KAuthTextFormField(
                    label: "Candidate Name",
                    controller: nameController,
                    hintText: "Enter Your Name",
                    isRequiredStar: true,

                    // validator: (value) => value == null || value.trim().isEmpty
                    //     ? "Please enter name"
                    //     : null,
                  ),

                  KVerticalSpacer(height: 16.h),
                  KAuthTextFormField(
                    label: "Email Id",
                    controller: emailController,
                    hintText: "person@gmail.com",
                    isRequiredStar: true,
                    keyboardType: TextInputType.emailAddress,
                    // validator: (value) {
                    //   if (value == null || value.trim().isEmpty) {
                    //     return "Please enter email";
                    //   } else if (!RegExp(
                    //     r'^[^@]+@[^@]+\.[^@]+',
                    //   ).hasMatch(value)) {
                    //     return "Enter valid email";
                    //   }
                    //   return null;
                    //},
                  ),

                  KVerticalSpacer(height: 16.h),
                  KAuthTextFormField(
                    label: "DOB",
                    onTap: () async {
                      await selectDate(
                        context,
                        dobController,
                        isDeadline: false,
                        isAssignDate: true,
                      );
                    },
                    controller: dobController,
                    isRequiredStar: true,
                    hintText: "dd-mm-yyyy",
                    keyboardType: TextInputType.datetime,
                    // suffixIcon: Icons.date_range,
                    // validator: (value) => value == null || value.trim().isEmpty
                    //     ? "Please select DOB"
                    //     : null,
                  ),

                  KVerticalSpacer(height: 16.h),
                  KAuthTextFormField(
                    label: "Phone Number",
                    controller: phoneController,
                    hintText: "999-999-999",
                    keyboardType: TextInputType.phone,
                    isRequiredStar: true,
                    // validator: (value) {
                    //   if (value == null || value.trim().isEmpty) {
                    //     return "Please enter phone number";
                    //   } else if (value.length < 10) {
                    //     return "Enter valid phone number";
                    //   }
                    //   return null;
                    // },
                  ),

                  KVerticalSpacer(height: 16.h),
                  KAuthTextFormField(
                    label: "Employee Status",
                    controller: statusController,
                    hintText: "Select Employment Status",
                    isRequiredStar: true,
                    // validator: (value) => value == null || value.trim().isEmpty
                    //     ? "Please enter status"
                    //     : null,
                  ),

                  KVerticalSpacer(height: 16.h),
                  KAuthTextFormField(
                    label: "Current Job Title",
                    controller: jobTitleController,
                    hintText: "Person Job Title",
                    isRequiredStar: true,
                    // validator: (value) => value == null || value.trim().isEmpty
                    //     ? "Please enter job title"
                    //     : null,
                  ),

                  KVerticalSpacer(height: 16.h),
                  KAuthTextFormField(
                    label: "Current Employer",
                    controller: employerController,
                    hintText: "Current Employer",
                    isRequiredStar: true,
                    // validator: (value) => value == null || value.trim().isEmpty
                    //     ? "Please enter employer"
                    //     : null,
                  ),

                  KVerticalSpacer(height: 16.h),
                  KAuthTextFormField(
                    label: "LinkedIn Profile",
                    controller: linkedinController,
                    hintText: "LinkedIn Link",
                    isRequiredStar: true,
                    // validator: (value) => value == null || value.trim().isEmpty
                    //     ? "Please enter LinkedIn"
                    //     : null,
                  ),

                  KVerticalSpacer(height: 16.h),
                  KAuthTextFormField(
                    label: "Place",
                    controller: placeController,
                    hintText: "Location",
                    isRequiredStar: true,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? "Please enter location"
                        : null,
                  ),

                  //  KVerticalSpacer(height: 60.h),
                ],
              ),
            ),
          ),
        ),

        //   Bottom Sheet with validation check
        bottomNavigationBar: Container(
          height: 60.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: Center(
            child: KAuthFilledBtn(
              suffixIcon: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.white,
              ),
              borderRadius: BorderRadiusGeometry.circular(8),
              backgroundColor: AppColors.primaryColor,
              height: AppResponsive.responsiveBtnHeight(context),
              width: double.infinity,
              text: "Next",
              fontSize: 12.sp,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  AppLoggerHelper.logInfo("  Form is valid");
                  GoRouter.of(
                    context,
                  ).pushNamed(AppRouteConstants.atsJobInformationScreen);
                  // KSnackBar.success(context, "Form is valid. Proceeding...");
                } else {
                  debugPrint("❌ Form has ERROR");
                  KSnackBar.failure(
                    context,
                    "Please correct the errors above .",
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
