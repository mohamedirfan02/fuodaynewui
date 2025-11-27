import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_image_picker_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/core/utils/date_picker.dart';
import 'package:fuoday/core/utils/image_picker.dart';
import 'package:fuoday/core/utils/image_viewer.dart';
import 'package:fuoday/core/validators/app_validators.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/profile/data/datasources/employee_profile_remote_datasource.dart';
import 'package:fuoday/features/profile/data/repositories/employee_profile_repository_impl.dart';
import 'package:fuoday/features/profile/domain/entities/update_profile_entity.dart';
import 'package:fuoday/features/profile/domain/usecases/get_employee_profile_usecase.dart';
import 'package:go_router/go_router.dart';

class ProfilePersonalDetailsScreen extends StatefulWidget {
  const ProfilePersonalDetailsScreen({super.key});

  @override
  State<ProfilePersonalDetailsScreen> createState() =>
      _ProfilePersonalDetailsScreenState();
}

class _ProfilePersonalDetailsScreenState
    extends State<ProfilePersonalDetailsScreen> {
  String getFreshImageUrl(String url) {
    if (url.isEmpty) return url;
    return "$url?ts=${DateTime.now().millisecondsSinceEpoch}";
  }

  // form key
  final formKey = GlobalKey<FormState>();

  late final GetEmployeeProfileUseCase getEmployeeProfileUseCase;
  bool isLoading = true;
  File? _pickedImageFile;

  String formatDateToIso(String date) {
    try {
      final parsed = DateTime.parse(date); // If already in correct format
      return "${parsed.year.toString().padLeft(4, '0')}-${parsed.month.toString().padLeft(2, '0')}-${parsed.day.toString().padLeft(2, '0')}";
    } catch (_) {
      try {
        // Fallback for dd/MM/yyyy or d/M/yyyy input
        final parts = date.split('/');
        if (parts.length == 3) {
          final day = parts[0].padLeft(2, '0');
          final month = parts[1].padLeft(2, '0');
          final year = parts[2];
          return "$year-$month-$day"; // ✅ MySQL-friendly format
        }
      } catch (_) {}
      return date; // Fallback (let server throw error if still wrong)
    }
  }

  // Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    aboutController.dispose();
    dobController.dispose();
    contactController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Set up use case from DI
    getEmployeeProfileUseCase = GetEmployeeProfileUseCase(
      repository: EmployeeProfileRepositoryImpl(
        remoteDataSource: EmployeeProfileRemoteDataSource(dio: getIt()),
      ),
    );

    fetchEmployeeProfile();
  }

  Future<void> fetchEmployeeProfile() async {
    try {
      final webUserId = getIt<HiveStorageService>()
          .employeeDetails?['webUserId']
          .toString();
      final profile = await getEmployeeProfileUseCase.execute(webUserId!);

      setState(() {
        firstNameController.text = profile.firstName;
        lastNameController.text = profile.lastName;
        aboutController.text = profile.about ?? '';
        dobController.text = profile.dob;
        contactController.text = profile.contactNumber;
        addressController.text = profile.address ?? '';
        isLoading = false;
      });
    } catch (e) {
      AppLoggerHelper.logError("Failed to fetch profile: $e");
      KSnackBar.failure(context, "Unable to load profile data");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // Get employee details from Hive with error handling
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Safe extraction of employee details
    var profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    profilePhoto = getFreshImageUrl(profilePhoto);

    return Scaffold(
      appBar: KAppBar(
        title: "Personal Details",
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // profile image
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Profile Image
                      GestureDetector(
                        onTap: () {
                          if (_pickedImageFile != null) {
                            AppImageViewer.show(
                              context: context,
                              imageUrl: _pickedImageFile!.path,
                              isLocalFile: true,
                            );
                          } else {
                            AppImageViewer.show(
                              context: context,
                              imageUrl: profilePhoto,
                            );
                          }
                        },
                        child: CircleAvatar(
                          radius: 45.h,
                          backgroundImage: _pickedImageFile != null
                              ? FileImage(_pickedImageFile!)
                              : NetworkImage(profilePhoto) as ImageProvider,
                        ),
                      ),

                      if (context.profileEditProviderWatch.isEditMode)
                        Positioned(
                          bottom: -10,
                          right: -10,
                          child: GestureDetector(
                            onTap: () async {
                              final appImagePicker = AppImagePicker();

                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16.r),
                                  ),
                                ),
                                builder: (context) {
                                  return KImagePickerOptionsBottomSheet(
                                    onCameraTap: () async {
                                      final image = await appImagePicker
                                          .pickImageFromCamera();
                                      if (image != null) {
                                        setState(() {
                                          _pickedImageFile = image;
                                        });
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    onGalleryTap: () async {
                                      final image = await appImagePicker
                                          .pickImageFromGallery();
                                      if (image != null) {
                                        setState(() {
                                          _pickedImageFile = image;
                                        });
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme
                                    .secondaryHeaderColor, //AppColors.secondaryColor,
                                border: Border.all(
                                  color:
                                      theme.textTheme.bodyLarge?.color ??
                                      AppColors
                                          .greyColor, //AppColors.greyColor,
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                KVerticalSpacer(height: 20.h),

                // First name TextFormField
                KAuthTextFormField(
                  controller: firstNameController,
                  validator: (value) => AppValidators.validateName(
                    value,
                    emptyMessage: "Enter your first name",
                    minLengthMessage:
                        "Pls Enter a valid name atleast 3 characters",
                  ),
                  hintText: "First Name",
                  isReadOnly: context.profileEditProviderWatch.isEditMode
                      ? false
                      : true,
                  suffixIcon: context.profileEditProviderWatch.isEditMode
                      ? Icons.edit
                      : Icons.person_outline,
                ),

                KVerticalSpacer(height: 12.h),

                // Last name text form field
                KAuthTextFormField(
                  isReadOnly: context.profileEditProviderWatch.isEditMode
                      ? false
                      : true,
                  controller: lastNameController,
                  validator: (value) => AppValidators.validateName(
                    value,
                    emptyMessage: "Enter your last name",
                    minLengthMessage:
                        "Pls Enter a valid name atleast 2 characters",
                  ),
                  hintText: "Last Name",
                  suffixIcon: context.profileEditProviderWatch.isEditMode
                      ? Icons.edit
                      : Icons.person_outline,
                ),

                KVerticalSpacer(height: 12.h),

                // About text form field
                KAuthTextFormField(
                  isReadOnly: context.profileEditProviderWatch.isEditMode
                      ? false
                      : true,
                  controller: aboutController,
                  validator: (value) => AppValidators.validateText(
                    value,
                    emptyMessage: "Enter about which is required",
                  ),
                  hintText: "About",
                  suffixIcon: context.profileEditProviderWatch.isEditMode
                      ? Icons.edit
                      : Icons.description_outlined,
                  maxLines: 4,
                ),

                KVerticalSpacer(height: 12.h),

                // Date of Birth
                KAuthTextFormField(
                  isReadOnly: context.profileEditProviderWatch.isEditMode
                      ? false
                      : true,
                  controller: dobController,

                  validator: (value) => AppValidators.validateFullDOB(
                    value,
                    invalidMessage: "Please select your date of birth",
                  ),
                  onTap: () {
                    selectDatePicker(context, dobController);
                  },
                  hintText: "Date of Birth",
                  suffixIcon: context.profileEditProviderWatch.isEditMode
                      ? Icons.edit
                      : Icons.calendar_month_outlined,
                ),

                KVerticalSpacer(height: 12.h),

                // Contact Information
                KAuthTextFormField(
                  isReadOnly: context.profileEditProviderWatch.isEditMode
                      ? false
                      : true,
                  controller: contactController,
                  validator: (value) => AppValidators.validatePhoneNumber(
                    value,
                    emptyMessage: "Enter your PhoneNo, It is required",
                    invalidMessage: "Enter a valid PhoneNo",
                  ),
                  hintText: "Contact Information",
                  suffixIcon: Icons.mail_outline,
                ),

                KVerticalSpacer(height: 12.h),

                // Address
                KAuthTextFormField(
                  isReadOnly: context.profileEditProviderWatch.isEditMode
                      ? false
                      : true,
                  controller: addressController,
                  validator: (value) => AppValidators.validateText(
                    value,
                    emptyMessage: "Enter your address, It is required",
                  ),
                  hintText: "Address",
                  suffixIcon: context.profileEditProviderWatch.isEditMode
                      ? Icons.edit
                      : Icons.location_on_outlined,
                ),

                KVerticalSpacer(height: 30.h),

                // Cancel Btn
                context.profileEditProviderWatch.isEditMode
                    ? KAuthFilledBtn(
                        backgroundColor: theme.primaryColor.withOpacity(0.4),
                        fontSize: 10.sp,
                        text: "Cancel",
                        onPressed: () {
                          context.profileEditProviderRead.cancelEdit();
                        },
                        height: AppResponsive.responsiveBtnHeight(context),
                        width: double.infinity,
                      )
                    : SizedBox(),

                KVerticalSpacer(height: 12.h),

                // Back to Login Btn
                KAuthFilledBtn(
                  backgroundColor: theme.primaryColor,
                  fontSize: 10.sp,
                  text: context.profileEditProviderWatch.isEditMode
                      ? "Submit"
                      : "Edit",
                  onPressed: () async {
                    if (context.profileEditProviderRead.isEditMode) {
                      if (formKey.currentState!.validate()) {
                        final hiveService = getIt<HiveStorageService>();

                        final entity = UpdateProfileEntity(
                          webUserId:
                              hiveService.employeeDetails?['web_user_id']
                                  .toString() ??
                              "",
                          firstName: firstNameController.text.trim(),
                          lastName: lastNameController.text.trim(),
                          about: aboutController.text.trim(),
                          dob: formatDateToIso(dobController.text.trim()),
                          phone: contactController.text.trim(),
                          address: addressController.text.trim(),
                          profileImageFile: _pickedImageFile,
                        );

                        try {
                          await context.profileEditProviderRead.submitUpdate(
                            entity,
                          );
                          KSnackBar.success(
                            context,
                            "Profile updated successfully",
                          );
                        } catch (e) {
                          KSnackBar.failure(context, "Update failed");
                        }
                      } else {
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
