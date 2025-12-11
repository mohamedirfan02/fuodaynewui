import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/models/file_preview_data.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/core/utils/image_picker.dart';
import 'package:fuoday/features/ats_candidate/widgets/k_ats_file_upload_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:go_router/go_router.dart';

class NewTicketScreen extends StatefulWidget {
  const NewTicketScreen({super.key});

  @override
  State<NewTicketScreen> createState() => _NewTicketScreenState();
}

class _NewTicketScreenState extends State<NewTicketScreen> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController issueController = TextEditingController();

  //File? _pickedImageFile;

  // void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  @override
  void dispose() {
    phoneController.dispose();
    subjectController.dispose();
    issueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    // final hiveService = getIt<HiveStorageService>();
    // final employeeDetails = hiveService.employeeDetails;
    // final name = employeeDetails?['name'] ?? "No Name";
    // final email = employeeDetails?['email'] ?? "No Email";
    // final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    // final currentRoute = AppRouteConstants.atsCandidateInformationScreen;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.cardColor, //ATS Background Color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.atsDrawerGradientColor,
              begin: Alignment.centerLeft, // LEFT → RIGHT
              end: Alignment.centerRight,
              stops: const [0.0, 1.0],
            ),
          ),
        ),
        title: KText(
          text: "New Ticket",
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
          color: theme.secondaryHeaderColor,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.secondaryHeaderColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const KTitleText(title: "Priority Level"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "Select Priority",
                value: context.dropDownProviderRead.getValue("Priority"),
                items: ["High", "Medium", "Low"],
                onChanged: (v) =>
                    context.dropDownProviderRead.setValue("Priority", v),
                validator: (val) => val == null || val.isEmpty
                    ? "Please select Priority"
                    : null,
              ),

              KVerticalSpacer(height: 16.h),
              const KTitleText(title: "Department"),
              KVerticalSpacer(height: 6.h),
              KDropdownTextFormField<String>(
                hintText: "IT / Non-IT / etc.",
                value: context.dropDownProviderRead.getValue("Department"),
                items: ["HR", "IT", "Finance"],
                onChanged: (v) =>
                    context.dropDownProviderRead.setValue("Department", v),
                validator: (val) => val == null || val.isEmpty
                    ? "Please select Department"
                    : null,
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Phone Number",
                controller: phoneController,
                hintText: "999-999-999",
                isRequiredStar: false,
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter Phone number" : null,
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Subject",
                controller: subjectController,
                hintText: "Issue subject",
                isRequiredStar: false,
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter Subject" : null,
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Issue",
                controller: issueController,
                hintText: "Describe your issue",
                isRequiredStar: false,
                validator: (v) => v == null || v.isEmpty ? "Enter Issue" : null,
              ),

              KVerticalSpacer(height: 16.h),
              const KTitleText(title: "Upload Image"),

              // Image container
              KAtsUploadPickerTile(
                backgroundcolor: theme.cardColor, //ATS Background Color
                showOnlyView: context.filePickerProviderWatch.isPicked(
                  "newTicketImage",
                ),
                onViewTap: () {
                  final pickedFile = context.filePickerProviderRead.getFile(
                    "newTicketImage",
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
                  "newTicketImage",
                ),
                onCancelTap: () {
                  context.filePickerProviderRead.removeFile("newTicketImage");
                  KSnackBar.success(context, "File removed successfully");
                },
                uploadOnTap: () async {
                  final key = "newTicketImage";
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
                    context.filePickerProviderWatch.isPicked("newTicketImage")
                    ? Icons.check_circle
                    : Icons.cloud_upload_outlined,
                description:
                    context.filePickerProviderWatch.getFile("newTicketImage") !=
                        null
                    ? "Selected File: ${context.filePickerProviderWatch.getFile("newTicketImage")!.name}"
                    : "Browse file to upload\nSupports .pdf, .doc, .docx",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            Expanded(
              child: KAtsGlowButton(
                //height: AppResponsive.responsiveBtnHeight(context),
                text: "Cancel",
                fontWeight: FontWeight.w600,
                fontSize: 13,
                textColor:
                    theme.textTheme.headlineLarge?.color ??
                    AppColors.titleColor,
                //gradientColors: AppColors.atsButtonGradientColor,
                backgroundColor: theme.secondaryHeaderColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: KAtsGlowButton(
                //height: AppResponsive.responsiveBtnHeight(context),
                text: "New Ticket",
                fontWeight: FontWeight.w600,
                fontSize: 13,
                textColor: theme.secondaryHeaderColor,
                gradientColors: AppColors.atsButtonGradientColor,
                icon: SvgPicture.asset(
                  AppAssetsConstants.addIcon,
                  height: 15,
                  width: 15,
                  fit: BoxFit.contain,
                  //SVG IMAGE COLOR
                  colorFilter: ColorFilter.mode(
                    theme.secondaryHeaderColor,
                    BlendMode.srcIn,
                  ),
                ),
                // backgroundColor: theme.secondaryHeaderColor,
                onPressed: () {
                  /// This is Validation
                  /*final formValid = formKey.currentState!.validate();
                  if (formValid && _pickedImageFile != null) {
                    KSnackBar.success(context, "Form submitted successfully!");
                  } else {
                    KSnackBar.failure(
                      context,
                      "Please fill all required fields.",
                    );
                  }*/
                  showDialog(
                    context: context,
                    builder: (context) {
                      return NewTicketRaisedDialog();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KTitleText extends StatelessWidget {
  final String title;
  const KTitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    return Row(
      children: [
        KText(text: title, fontWeight: FontWeight.w600, fontSize: 12.sp),
      ],
    );
  }
}

class NewTicketRaisedDialog extends StatelessWidget {
  const NewTicketRaisedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon Circle
            Image.asset(AppAssetsConstants.atsIllustrationImg, height: 100.h),

            SizedBox(height: 18.h),

            // Title
            KText(
              text: "New Ticket Raised",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodyLarge?.color,
            ),

            SizedBox(height: 10.h),

            // Sub message
            KText(
              text: "Your ticket has been submitted to the support team.",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 24.h),

            // Gradient Done Button
            SizedBox(
              width: double.infinity,
              child: KAtsGlowButton(
                text: "Done",
                fontWeight: FontWeight.w600,
                fontSize: 14,
                textColor: theme.secondaryHeaderColor,
                gradientColors: AppColors.atsButtonGradientColor,
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog first
                  GoRouter.of(context).goNamed(
                    AppRouteConstants.atsSupportScreen,
                    extra: 1, // Pass 1 for second tab (My Ticket)
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
