import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_linear_gradient_bg.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/secure_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/core/validators/app_validators.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_password_text_field.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';

class AuthLoginScreen extends StatefulWidget {
  const AuthLoginScreen({super.key});

  @override
  State<AuthLoginScreen> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends State<AuthLoginScreen> {
  // Form Key
  final formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController recruiterController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    employeeIdController.dispose();
    recruiterController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // Internet Checker Provider
    final internetCheckerProvider = context.appInternetCheckerProviderWatch;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!internetCheckerProvider.isNetworkConnected) {
        KSnackBar.failure(context, "No Internet Connection");
      } else {
        KSnackBar.success(context, "Internet Connection Available");
      }
    });
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);

    //isTablet? (isLandscape ? 30.h : 25.h) : 22.h,

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: KLinearGradientBg(
        gradientColor: isDark
            ? AppColors.employeeGradientColorDark
            : AppColors.employeeGradientColor, //Employee Card
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               // KVerticalSpacer(height: 40.h),

                Image.asset(
                  AppAssetsConstants.logo,
                  height: 180.h,
                  width: 180.w,
                  // fit: BoxFit.cover,
                ),

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.r),
                      ),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 30),
                                    child: KText(
                                      text: "Start Your Experience",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                    ),
                                  ),

                                  KVerticalSpacer(height: 10.h),

                                  KText(
                                    text: "Login Now",
                                    fontWeight: FontWeight.w500,
                                    color: theme
                                        .inputDecorationTheme
                                        .focusedBorder
                                        ?.borderSide
                                        .color, //AppColors.subTitleColor,
                                    fontSize: 14.sp,
                                  ),

                                  KVerticalSpacer(height: 20.h),

                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                    ),
                                    width: double.infinity,
                                    height: 100.h,
                                    child: CupertinoSlidingSegmentedControl<int>(
                                      children: {
                                        0: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8.h,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color:
                                                    context
                                                        .slidingSegmentProviderWatch
                                                        .isRecruiter
                                                    ? theme.primaryColor
                                                    : theme
                                                          .secondaryHeaderColor, //AppColors.secondaryColor,
                                              ),
                                              SizedBox(width: 10.w),
                                              KText(
                                                text: "Employee",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                                color:
                                                    context
                                                        .slidingSegmentProviderWatch
                                                        .isRecruiter
                                                    ? theme.primaryColor
                                                    : theme
                                                          .secondaryHeaderColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                        1: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 6.h,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.person,
                                                color:
                                                    context
                                                        .slidingSegmentProviderWatch
                                                        .isEmployee
                                                    ? theme.primaryColor
                                                    : theme
                                                          .secondaryHeaderColor,
                                              ),
                                              SizedBox(width: 10.w),
                                              KText(
                                                text: "Recruiter",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                                color:
                                                    context
                                                        .slidingSegmentProviderWatch
                                                        .isEmployee
                                                    ? theme.primaryColor
                                                    : theme
                                                          .secondaryHeaderColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      },
                                      backgroundColor:
                                          theme.secondaryHeaderColor,
                                      thumbColor: theme.primaryColor,
                                      groupValue: context
                                          .slidingSegmentProviderRead
                                          .selectedIndex,
                                      onValueChanged: (value) {
                                        if (value != null) {
                                          context.slidingSegmentProviderRead
                                              .setSelectedIndex(value);
                                        }
                                      },
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 20.h,
                                    ),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: theme
                                          .secondaryHeaderColor, //AppColors.secondaryColor
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          textAlign: TextAlign.start,
                                          text: "Hi,\nWelcome back",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                        ),

                                        KVerticalSpacer(height: 20.h),

                                        if (context
                                            .slidingSegmentProviderWatch
                                            .isEmployee)
                                          KAuthTextFormField(
                                            validator: (value) =>
                                                AppValidators.validateName(
                                                  value,
                                                  emptyMessage:
                                                      "Enter your email",
                                                ),
                                            controller: employeeIdController,
                                            suffixIcon: Icons.mail_outline,
                                            keyboardType: TextInputType.text,
                                            hintText: "EMPLOYEE ID",
                                          ),

                                        // Recruiter TextField
                                        if (context
                                            .slidingSegmentProviderWatch
                                            .isRecruiter)
                                          KAuthTextFormField(
                                            validator: (value) =>
                                                AppValidators.validateName(
                                                  value,
                                                  emptyMessage:
                                                      "Enter your email",
                                                ),
                                            controller: recruiterController,
                                            suffixIcon: Icons.mail_outline,
                                            keyboardType: TextInputType.text,
                                            hintText: "RECRUITER ID",
                                          ),

                                        KVerticalSpacer(height: 20.h),

                                        // Password Text Field
                                        KAuthPasswordTextField(
                                          validator: (value) =>
                                              AppValidators.validateText(
                                                value,
                                                emptyMessage:
                                                    "Enter your password",
                                              ),
                                          controller: passwordController,
                                          hintText: "PASSWORD",
                                        ),

                                        KVerticalSpacer(height: 12.h),

                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: KAuthTextBtn(
                                            showUnderline: true,
                                            onTap: () {
                                              // Forget Password
                                              GoRouter.of(context).pushNamed(
                                                AppRouteConstants
                                                    .forgetPassword,
                                              );
                                            },
                                            text: "Forget Password?",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            textAlign: TextAlign.end,
                                            textColor: isDark
                                                ? AppColors.textBtnColorDark
                                                : AppColors.textBtnColor,
                                          ),
                                        ),

                                        KVerticalSpacer(height: 14.h),

                                        if (context
                                            .slidingSegmentProviderWatch
                                            .isEmployee)
                                          KAuthFilledBtn(
                                            isLoading: context
                                                .employeeAuthLoginProviderWatch
                                                .isLoading,
                                            fontSize: 10.sp,
                                            text: "Employee Login",
                                            backgroundColor: theme.primaryColor,
                                            onPressed: () async {
                                              // Internet Checker Provider
                                              if (!internetCheckerProvider
                                                  .isNetworkConnected) {
                                                KSnackBar.failure(
                                                  context,
                                                  "No Internet Connection",
                                                );
                                                return;
                                              }

                                              // Form Key Validation
                                              if (!formKey.currentState!
                                                  .validate()) {
                                                return;
                                              }

                                              final provider = context
                                                  .employeeAuthLoginProviderRead;

                                              final role = "employee";
                                              final emailId =
                                                  employeeIdController.text
                                                      .trim();
                                              final password =
                                                  passwordController.text
                                                      .trim();

                                              await provider.login(
                                                role: role,
                                                emailId: emailId,
                                                password: password,
                                              );

                                              if (provider.authEntity != null) {
                                                await HiveStorageService()
                                                    .setIsAuthLogged(true);

                                                try {
                                                  await SecureStorageService()
                                                      .saveToken(
                                                        token: provider
                                                            .authEntity!
                                                            .token,
                                                      );

                                                  final role =
                                                      "employee"; // 🔥 Store the role permanently
                                                  await HiveStorageService()
                                                      .setUserRole(role);
                                                  final rawWebUserId = provider
                                                      .authEntity
                                                      ?.data
                                                      .employeeDetails
                                                      ?.webUserId;

                                                  AppLoggerHelper.logInfo(
                                                    '🧩 Raw webUserId: ${provider.authEntity?.data.employeeDetails.webUserId}',
                                                  );
                                                  AppLoggerHelper.logInfo(
                                                    '🧩 Raw profilePhoto: ${provider.authEntity?.data.employeeDetails.profilePhoto}',
                                                  );

                                                  await HiveStorageService.setEmployeeDetailsStatic(
                                                    userName:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .name ??
                                                        "No User Name",
                                                    role: role,
                                                    empId:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .empId ??
                                                        "No EmpId",
                                                    email: emailId,
                                                    designation:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .employeeDetails
                                                            ?.designation ??
                                                        "No Emp Designation",
                                                    profilePhoto:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .employeeDetails
                                                            ?.profilePhoto ??
                                                        "No Image Url",
                                                    webUserId:
                                                        rawWebUserId
                                                            ?.toString() ??
                                                        '0',
                                                    logo:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .adminUser
                                                            .logo ??
                                                        "No Image Url",
                                                    checkin:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .employeeDetails
                                                            .checkin ??
                                                        'no checkin',
                                                    id:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .adminUser
                                                            .id
                                                            ?.toString() ?? // Convert int to String if needed
                                                        "No ID",

                                                    access:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .employeeDetails
                                                            .access ??
                                                        "",
                                                  );

                                                  AppLoggerHelper.logInfo(
                                                    '✅ Token saved to SecureStorage: ${provider.authEntity!.token}',
                                                  );
                                                } catch (e) {
                                                  AppLoggerHelper.logError(
                                                    '⛔ Failed to save token: $e',
                                                  );
                                                }

                                                GoRouter.of(
                                                  context,
                                                ).pushReplacementNamed(
                                                  AppRouteConstants
                                                      .employeeBottomNav,
                                                );

                                                //  Success Snack Bar
                                                KSnackBar.success(
                                                  context,
                                                  "Login Successfull",
                                                );
                                              } else {
                                                AppLoggerHelper.logError(
                                                  'Login Failed: ${provider.error}',
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Login Failed: ${provider.error}',
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            height: isTablet
                                                ? (isLandscape ? 30.h : 25.h)
                                                : 22.h,
                                            width: double.infinity,
                                          )
                                        else
                                          KAuthFilledBtn(
                                            isLoading: context
                                                .employeeAuthLoginProviderWatch
                                                .isLoading,
                                            fontSize: 10.sp,
                                            text: "Recruiter Login",
                                            backgroundColor: theme.primaryColor,
                                            onPressed: () async {
                                              if (!formKey.currentState!
                                                  .validate()) {
                                                return;
                                              }

                                              final provider = context
                                                  .employeeAuthLoginProviderRead;

                                              final role = "recruiter";
                                              final emailId =
                                                  recruiterController.text
                                                      .trim();
                                              final password =
                                                  passwordController.text
                                                      .trim();

                                              await provider.login(
                                                role: role,
                                                emailId: emailId,
                                                password: password,
                                              );

                                              if (provider.authEntity != null) {
                                                await HiveStorageService()
                                                    .setIsAuthLogged(true);

                                                try {
                                                  await SecureStorageService()
                                                      .saveToken(
                                                        token: provider
                                                            .authEntity!
                                                            .token,
                                                      );
                                                  final role = "recruiter";
                                                  await HiveStorageService()
                                                      .setUserRole(role);

                                                  final rawWebUserId = provider
                                                      .authEntity
                                                      ?.data
                                                      .employeeDetails
                                                      ?.webUserId;

                                                  AppLoggerHelper.logInfo(
                                                    '🧪 webUserId (raw): $rawWebUserId',
                                                  );

                                                  await HiveStorageService.setEmployeeDetailsStatic(
                                                    userName:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .name ??
                                                        "No User Name",
                                                    role: role,
                                                    empId:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .empId ??
                                                        "No EmpId",
                                                    checkin:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .checkin ??
                                                        "checkin",
                                                    email: emailId,
                                                    designation:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .employeeDetails
                                                            ?.designation ??
                                                        "No Emp Designation",
                                                    profilePhoto:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .employeeDetails
                                                            ?.profilePhoto ??
                                                        "No Image Url",
                                                    webUserId:
                                                        rawWebUserId
                                                            ?.toString() ??
                                                        '0',
                                                    logo:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .adminUser
                                                            .logo ??
                                                        "No Image Url",
                                                    id:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .adminUser
                                                            .id
                                                            ?.toString() ?? // Convert int to String if needed
                                                        "No ID",
                                                    access:
                                                        provider
                                                            .authEntity
                                                            ?.data
                                                            .employeeDetails
                                                            .access ??
                                                        "",
                                                  );

                                                  AppLoggerHelper.logInfo(
                                                    '✅ Token saved to SecureStorage: ${provider.authEntity!.token}',
                                                  );
                                                } catch (e) {
                                                  AppLoggerHelper.logError(
                                                    '⛔ Failed to save token: $e',
                                                  );
                                                }

                                                GoRouter.of(
                                                  context,
                                                ).pushReplacementNamed(
                                                  AppRouteConstants
                                                      .homeRecruiter,
                                                );
                                              } else {
                                                AppLoggerHelper.logError(
                                                  'Login Failed: ${provider.error}',
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Login Failed: ${provider.error}',
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            height: isTablet
                                                ? (isLandscape ? 30.h : 25.h)
                                                : 22.h,
                                            width: double.infinity,
                                          ),

                                        KVerticalSpacer(height: 20),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
