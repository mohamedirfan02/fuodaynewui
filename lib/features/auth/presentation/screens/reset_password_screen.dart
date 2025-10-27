import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_linear_gradient_bg.dart';
import 'package:fuoday/commons/widgets/k_svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/providers/reset_password_provider.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthResetPasswordScreen extends StatefulWidget {
  final String email;
  final String otp; // ✅ You need to pass otp from verify_otp screen

  const AuthResetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<AuthResetPasswordScreen> createState() =>
      _AuthResetPasswordScreenState();
}

class _AuthResetPasswordScreenState extends State<AuthResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResetPasswordProvider>(context);

    // 🔹 Reset Password Button Function
    Future<void> _resetPassword() async {
      if (_formKey.currentState!.validate()) {
        FocusScope.of(context).unfocus();

        await provider.resetPassword(
          email: widget.email,
          otp: widget.otp,
          password: passwordController.text.trim(),
          passwordConfirmation: confirmPasswordController.text.trim(),
        );

        if (provider.error != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(provider.error!),
            ),
          );
        } else if (provider.response != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                provider.response!.message ?? "Password reset successful!",
              ),
            ),
          );

          // ✅ Navigate to login screen
          GoRouter.of(context).pushNamed(AppRouteConstants.login);
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: KLinearGradientBg(
        gradientColor: AppColors.employeeGradientColor,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40.h),
              //App Logo
              Image.asset(
                AppAssetsConstants.logo,
                height: 150.h,
                width: 150.w,
                // fit: BoxFit.cover,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.authBgColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.r),
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
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: KText(
                                      text: "Reset Your Password",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  KVerticalSpacer(height: 20.h),

                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 20.h,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.secondaryColor,
                                    ),
                                    child: Column(
                                      children: [
                                        KText(
                                          textAlign: TextAlign.center,
                                          text: "Create New Password",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                        ),
                                        KVerticalSpacer(height: 10.h),
                                        KText(
                                          textAlign: TextAlign.center,
                                          text:
                                              "Enter and confirm your new password to securely update your account.",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                        KVerticalSpacer(height: 20.h),

                                        /// 🔹 New Password Field
                                        KAuthTextFormField(
                                          controller: passwordController,
                                          obscureText: true,
                                          suffixIcon: Icons.lock_outline,
                                          hintText: "NEW PASSWORD",
                                          validator: (v) {
                                            if (v == null || v.isEmpty) {
                                              return "Please enter new password";
                                            }
                                            if (v.length < 6) {
                                              return "Password must be at least 6 characters";
                                            }
                                            return null;
                                          },
                                        ),
                                        KVerticalSpacer(height: 15.h),

                                        /// 🔹 Confirm Password Field
                                        KAuthTextFormField(
                                          controller: confirmPasswordController,
                                          obscureText: true,
                                          suffixIcon: Icons.lock_outline,
                                          hintText: "CONFIRM PASSWORD",
                                          validator: (v) {
                                            if (v == null || v.isEmpty) {
                                              return "Please confirm your password";
                                            }
                                            if (v != passwordController.text) {
                                              return "Passwords do not match";
                                            }
                                            return null;
                                          },
                                        ),
                                        KVerticalSpacer(height: 20.h),

                                        /// 🔹 Reset Button
                                        KAuthFilledBtn(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          fontSize: 10.sp,
                                          text: provider.isLoading
                                              ? "Resetting..."
                                              : "Reset Password",
                                          onPressed: () {
                                            if (!provider.isLoading) {
                                              _resetPassword();
                                            }
                                          },
                                          height: 22.h,
                                          width: double.infinity,
                                        ),
                                        KVerticalSpacer(height: 12.h),

                                        /// Back Button
                                        KAuthFilledBtn(
                                          backgroundColor: AppColors
                                              .primaryColor
                                              .withOpacity(0.4),
                                          fontSize: 10.sp,
                                          text: "Back to Login",
                                          onPressed: () {
                                            GoRouter.of(
                                              context,
                                            ).goNamed(AppRouteConstants.login);
                                          },
                                          height: 22.h,
                                          width: double.infinity,
                                        ),
                                      ],
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
    );
  }
}
