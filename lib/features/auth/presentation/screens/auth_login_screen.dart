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
  bool _rememberMe = false;

  // Controllers
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController recruiterController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Focus Nodes
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    employeeIdController.dispose();
    recruiterController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  /// ✅ Common login handler method
  Future<void> _handleLogin() async {
    // Form Key Validation
    if (!formKey.currentState!.validate()) {
      return;
    }

    final provider = context.employeeAuthLoginProviderRead;
    final isEmployee = context.slidingSegmentProviderRead.isEmployee;

    final role = isEmployee ? "employee" : "recruiter";
    final emailId = isEmployee
        ? employeeIdController.text.trim()
        : recruiterController.text.trim();
    final password = passwordController.text.trim();

    await provider.login(
      role: role,
      emailId: emailId,
      password: password,
    );

    if (provider.authEntity != null) {
      await HiveStorageService().setIsAuthLogged(true);

      try {
        await SecureStorageService().saveToken(
          token: provider.authEntity!.token,
        );

        await HiveStorageService().setUserRole(role);

        final rawWebUserId =
            provider.authEntity?.data.employeeDetails?.webUserId;

        AppLoggerHelper.logInfo(
          '🧩 Raw webUserId: ${provider.authEntity?.data.employeeDetails?.webUserId}',
        );
        AppLoggerHelper.logInfo(
          '🧩 Raw profilePhoto: ${provider.authEntity?.data.employeeDetails?.profilePhoto}',
        );

        await HiveStorageService.setEmployeeDetailsStatic(
          userName: provider.authEntity?.data.name ?? "No User Name",
          role: role,
          empId: provider.authEntity?.data.empId ?? "No EmpId",
          email: emailId,
          designation: provider.authEntity?.data.employeeDetails?.designation ??
              "No Emp Designation",
          profilePhoto:
          provider.authEntity?.data.employeeDetails?.profilePhoto ??
              "No Image Url",
          webUserId: rawWebUserId?.toString() ?? '0',
          logo: provider.authEntity?.data.adminUser.logo ?? "No Image Url",
          checkin: provider.authEntity?.data.employeeDetails?.checkin ??
              (isEmployee ? 'no checkin' : 'checkin'),
          id: provider.authEntity?.data.adminUser.id?.toString() ?? "No ID",
          access: provider.authEntity?.data.employeeDetails?.access ?? "",
        );

        AppLoggerHelper.logInfo(
          '✅ Token saved to SecureStorage: ${provider.authEntity!.token}',
        );
      } catch (e) {
        AppLoggerHelper.logError('⛔ Failed to save token: $e');
      }

      // Navigate based on role
      GoRouter.of(context).pushReplacementNamed(
        isEmployee
            ? AppRouteConstants.employeeBottomNav
            : AppRouteConstants.homeRecruiter,
      );

      KSnackBar.success(context, "Login Successful");
    } else {
      AppLoggerHelper.logError('Login Failed: ${provider.error}');
      KSnackBar.failure(context, "Login Failed Try Again");
    }
  }

  @override
  Widget build(BuildContext context) {
    // App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          /// 🔥 Background Image
          Positioned.fill(
            child: Image.asset(
              AppAssetsConstants.loginBgGradient,
              fit: BoxFit.cover,
            ),
          ),

          /// ⭐ Foreground UI
          SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔥 HEADER SECTION
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 30.h,
                      bottom: 20.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Logo
                        Image.asset(
                          AppAssetsConstants.newFuoDayLogo,
                          height: 20.73.h,
                          width: 86.97.w,
                        ),

                        SizedBox(height: 25.h),

                        /// Title
                        KText(
                          text: "Welcome to Fuoday",
                          fontWeight: FontWeight.w700,
                          fontSize: 23.sp,
                          color: Colors.white,
                        ),

                        SizedBox(height: 5.h),

                        /// Subtitle
                        KText(
                          text:
                          "Access your workspace and continue your journey.",
                          fontWeight: FontWeight.w400,
                          fontSize: 10.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),

                  /// 🔥 BOTTOM FORM CONTAINER
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
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20.h),

                                      /// 🔥 Employee / Recruiter Switch
                                      Container(
                                        width: double.infinity,
                                        height: 60.h,
                                        child: CupertinoSlidingSegmentedControl<
                                            int>(
                                          children: {
                                            0: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 6.h,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.person,
                                                    color: context
                                                        .slidingSegmentProviderWatch
                                                        .isRecruiter
                                                        ? theme.primaryColor
                                                        : theme
                                                        .secondaryHeaderColor,
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  KText(
                                                    text: "Employee",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                    color: context
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
                                                    color: context
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
                                                    color: context
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
                                              context
                                                  .slidingSegmentProviderRead
                                                  .setSelectedIndex(value);
                                            }
                                          },
                                        ),
                                      ),

                                      SizedBox(height: 20.h),

                                      /// 🔥 Email Label
                                      KText(
                                        text: "Email",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                      ),

                                      SizedBox(height: 8.h),

                                      /// 🔥 Employee Email Field
                                      if (context
                                          .slidingSegmentProviderWatch
                                          .isEmployee)
                                        KAuthTextFormField(
                                          validator: (value) =>
                                              AppValidators.validateName(
                                                value,
                                                emptyMessage: "Enter your email",
                                              ),
                                          controller: employeeIdController,
                                          suffixIcon: Icons.mail_outline,
                                          keyboardType: TextInputType.text,
                                          hintText: "EMAIL ID",
                                          onFieldSubmitted: (value) {
                                            // Move focus to password field
                                            FocusScope.of(context)
                                                .requestFocus(
                                                passwordFocusNode);
                                          },
                                        ),

                                      /// 🔥 Recruiter Email Field
                                      if (context
                                          .slidingSegmentProviderWatch
                                          .isRecruiter)
                                        KAuthTextFormField(
                                          validator: (value) =>
                                              AppValidators.validateName(
                                                value,
                                                emptyMessage: "Enter your email",
                                              ),
                                          controller: recruiterController,
                                          suffixIcon: Icons.mail_outline,
                                          keyboardType: TextInputType.text,
                                          hintText: "EMAIL ID",
                                          onFieldSubmitted: (value) {
                                            // Move focus to password field
                                            FocusScope.of(context)
                                                .requestFocus(
                                                passwordFocusNode);
                                          },
                                        ),

                                      SizedBox(height: 20.h),

                                      /// 🔥 Password Label
                                      KText(
                                        text: "Password",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                      ),

                                      SizedBox(height: 8.h),

                                      /// 🔥 Password Field
                                      KAuthPasswordTextField(
                                        validator: (value) =>
                                            AppValidators.validateText(
                                              value,
                                              emptyMessage: "Enter your password",
                                            ),
                                        controller: passwordController,
                                        hintText: "PASSWORD",
                                        focusNode: passwordFocusNode,
                                        onFieldSubmitted: (value) {
                                          // Trigger login when Enter is pressed
                                          _handleLogin();
                                        },
                                      ),

                                      SizedBox(height: 12.h),

                                      /// 🔥 Remember me & Forget Password Row
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 24.w,
                                                height: 24.h,
                                                child: Checkbox(
                                                  value: _rememberMe,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _rememberMe =
                                                          value ?? false;
                                                    });
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                      4.r,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8.w),
                                              KText(
                                                text: "Remember me",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
                                          KAuthTextBtn(
                                            showUnderline: false,
                                            onTap: () {
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
                                        ],
                                      ),

                                      SizedBox(height: 20.h),

                                      /// 🔥 Login Button (Employee/Recruiter)
                                      KAuthFilledBtn(
                                        isLoading: context
                                            .employeeAuthLoginProviderWatch
                                            .isLoading,
                                        fontSize: 14.sp,
                                        text: "Log In",
                                        backgroundColor: theme.primaryColor,
                                        onPressed: _handleLogin,
                                        height: isTablet
                                            ? (isLandscape ? 30.h : 25.h)
                                            : 30.h,
                                        width: double.infinity,
                                      ),

                                      Spacer(),

                                      /// 🔥 Terms and Privacy Text
                                      Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 20.h,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  KText(
                                                    text:
                                                    "By logging you agree to our",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10.sp,
                                                    color: Colors.grey,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      GoRouter.of(
                                                        context,
                                                      ).pushNamed(
                                                        AppRouteConstants
                                                            .termsOfService,
                                                      );
                                                    },
                                                    child: KText(
                                                      text: " Terms of Service",
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 10.sp,
                                                      color: theme.primaryColor,
                                                      textAlign:
                                                      TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  KText(
                                                    text: "and",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10.sp,
                                                    color: Colors.grey,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      GoRouter.of(
                                                        context,
                                                      ).pushNamed(
                                                        AppRouteConstants
                                                            .privacyPolicy,
                                                      );
                                                    },
                                                    child: KText(
                                                      text: " Privacy Policy.",
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 10.sp,
                                                      color: theme.primaryColor,
                                                      textAlign:
                                                      TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
        ],
      ),
    );
  }
}
