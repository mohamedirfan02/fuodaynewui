import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/core/utils/image_picker.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';

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

  File? _pickedImageFile;

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

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
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "No Name";
    final email = employeeDetails?['email'] ?? "No Email";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final currentRoute = AppRouteConstants.atsCandidateInformationScreen;

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
                text: "New Ticket",
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                //color: AppColors.titleColor,
              ),
              SizedBox(height: 14.h),

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
                isRequiredStar: true,
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter Phone number" : null,
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Subject",
                controller: subjectController,
                hintText: "Issue subject",
                isRequiredStar: true,
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter Subject" : null,
              ),

              KVerticalSpacer(height: 16.h),
              KAuthTextFormField(
                label: "Issue",
                controller: issueController,
                hintText: "Describe your issue",
                isRequiredStar: true,
                validator: (v) => v == null || v.isEmpty ? "Enter Issue" : null,
              ),

              KVerticalSpacer(height: 16.h),
              const KTitleText(title: "Upload Image"),
              KVerticalSpacer(height: 6.h),

              // Image container
              GestureDetector(
                onTap: _pickedImageFile == null
                    ? () async {
                        final image = await AppImagePicker()
                            .pickImageFromGallery();
                        if (image != null) {
                          setState(() => _pickedImageFile = image);
                        }
                      }
                    : null, // disabled when image exists
                child: Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color:
                        theme.secondaryHeaderColor, //AppColors.secondaryColor
                    border: Border.all(
                      color:
                          theme.textTheme.bodyLarge?.color?.withValues(
                            alpha: 0.3,
                          ) ??
                          AppColors.greyColor, //BORDER COLOR
                      width: 1,
                    ),
                    image: _pickedImageFile != null
                        ? DecorationImage(
                            image: FileImage(_pickedImageFile!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _pickedImageFile == null
                      ? Center(
                          child: Icon(
                            Icons.add_outlined,
                            color: theme.textTheme.bodyLarge?.color,
                          ), //AppColors.greyColor,
                        )
                      : Stack(
                          children: [
                            Positioned(
                              top: 2,
                              right: 2,
                              child: InkWell(
                                onTap: () {
                                  setState(() => _pickedImageFile = null);
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black54,
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.w),
        child: KAuthFilledBtn(
          borderRadius: BorderRadius.circular(8),
          backgroundColor: theme.primaryColor,
          height: AppResponsive.responsiveBtnHeight(context),
          text: "Next",
          fontSize: 12.sp,
          suffixIcon: Icon(
            Icons.arrow_forward_ios_outlined,
            color: theme.secondaryHeaderColor, //AppColors.secondaryColor
          ),
          onPressed: () {
            final formValid = formKey.currentState!.validate();
            if (formValid && _pickedImageFile != null) {
              KSnackBar.success(context, "Form submitted successfully!");
            } else {
              KSnackBar.failure(context, "Please fill all required fields.");
            }
          },
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Row(
      children: [
        KText(text: title, fontWeight: FontWeight.w600, fontSize: 12.sp),
        KText(
          text: " *",
          color: isDark ? AppColors.checkOutColorDark : Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
