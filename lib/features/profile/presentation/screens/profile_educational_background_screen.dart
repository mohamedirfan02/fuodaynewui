import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/core/utils/month_picker.dart';
import 'package:fuoday/core/validators/app_validators.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/profile/domain/usecases/employee_education_usecase.dart';
import 'package:go_router/go_router.dart';

class ProfileEducationalBackgroundScreen extends StatefulWidget {
  const ProfileEducationalBackgroundScreen({super.key});

  @override
  State<ProfileEducationalBackgroundScreen> createState() =>
      _ProfileEducationalBackgroundScreenState();
}

class _ProfileEducationalBackgroundScreenState
    extends State<ProfileEducationalBackgroundScreen> {
  late final GetEducationUseCase getEducationUseCase;
  late final GetSkillsUseCase getSkillsUseCase;

  // form key
  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController highestQualificationController =
      TextEditingController();
  final TextEditingController universityOrClgController =
      TextEditingController();
  final TextEditingController yearOfPassController = TextEditingController();
  final TextEditingController skillSetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    getEducationUseCase = getIt<GetEducationUseCase>();
    getSkillsUseCase = getIt<GetSkillsUseCase>();

    final webUserId = employeeDetails?['web_user_id'].toString();
    loadProfileData(webUserId!);
  }

  void loadProfileData(String webUserId) async {
    try {
      final educationList = await getEducationUseCase(webUserId);
      final skillsList = await getSkillsUseCase(webUserId);

      if (educationList.isNotEmpty) {
        highestQualificationController.text = educationList[0].qualification;
        universityOrClgController.text = educationList[0].university;
        yearOfPassController.text = educationList[0].yearOfPassing;
      }

      if (skillsList.isNotEmpty) {
        skillSetController.text = skillsList.map((e) => e.skill).join(', ');
      }
    } catch (e) {
      KSnackBar.failure(context, 'Failed to load data');
    }
  }

  @override
  void dispose() {
    highestQualificationController.dispose();
    universityOrClgController.dispose();
    yearOfPassController.dispose();
    skillSetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: "Educational Background",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () {
          GoRouter.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              spacing: 14.h,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Highest Qualification
                KAuthTextFormField(
                  validator: (value) => AppValidators.validateText(value),
                  controller: highestQualificationController,
                  label: "Highest Qualification",
                  hintText: "Highest Qualification",
                  suffixIcon: context.profileEditProviderWatch.isEditMode
                      ? Icons.edit
                      : Icons.school_outlined,
                ),

                // University Clg
                KAuthTextFormField(
                  controller: universityOrClgController,
                  validator: (value) => AppValidators.validateText(value),
                  label: "University / Clg",
                  hintText: "University / Clg",
                  suffixIcon: context.profileEditProviderWatch.isEditMode
                      ? Icons.edit
                      : Icons.school_outlined,
                ),

                // Year of Pass Text Form Field
                KAuthTextFormField(
                  controller: yearOfPassController,
                  validator: (value) => AppValidators.validateFullDOB(value),
                  onTap: () =>
                      selectMonthYearPicker(context, yearOfPassController),
                  label: "Year of Pass",
                  hintText: "Year of Pass",
                  suffixIcon: context.profileEditProviderWatch.isEditMode
                      ? Icons.edit
                      : Icons.calendar_month_outlined,
                ),

                // Skill Set Controller
                KAuthTextFormField(
                  controller: skillSetController,
                  validator: (value) => AppValidators.validateText(value),
                  label: "Skill set",
                  hintText: "Skill set",
                  suffixIcon: context.profileEditProviderWatch.isEditMode
                      ? Icons.edit
                      : Icons.description_outlined,
                ),

                KVerticalSpacer(height: 16.h),

                // Cancel Btn
                context.profileEditProviderWatch.isEditMode
                    ? KAuthFilledBtn(
                        backgroundColor: AppColors.primaryColor.withOpacity(
                          0.4,
                        ),
                        fontSize: 10.sp,
                        text: "Cancel",
                        onPressed: () {
                          context.profileEditProviderRead.cancelEdit();
                        },
                        height: AppResponsive.responsiveBtnHeight(context),
                        width: double.infinity,
                      )
                    : SizedBox(),

                // Back to Login Btn
                KAuthFilledBtn(
                  backgroundColor: AppColors.primaryColor,
                  fontSize: 10.sp,
                  text: context.profileEditProviderWatch.isEditMode
                      ? "Submit"
                      : "Edit",
                  onPressed: () {
                    if (context.profileEditProviderRead.isEditMode) {
                      if (formKey.currentState!.validate()) {
                        AppLoggerHelper.logInfo("Form is Valid");

                        KSnackBar.success(context, "Form is Valid");
                      } else {
                        AppLoggerHelper.logError("Form is InValid");

                        KSnackBar.failure(context, "Form is Invalid");
                      }
                    } else {
                      context.profileEditProviderRead.toggleEditMode();
                    }
                  },
                  height: AppResponsive.responsiveBtnHeight(context),
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
