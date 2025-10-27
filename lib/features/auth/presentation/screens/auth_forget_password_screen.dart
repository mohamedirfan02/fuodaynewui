import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_linear_gradient_bg.dart';
import 'package:fuoday/commons/widgets/k_svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/providers/employee_auth_login_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; // 🆕 Provider package import

class AuthForgetPasswordScreen extends StatefulWidget {
  const AuthForgetPasswordScreen({super.key});

  @override
  State<AuthForgetPasswordScreen> createState() =>
      _AuthForgetPasswordScreenState();
}

class _AuthForgetPasswordScreenState extends State<AuthForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // 🆕 added form key for validation

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ForgotPasswordProvider>(
      context,
    ); // 🆕 access provider
    void _sendOtp() async {
      if (_formKey.currentState!.validate()) {
        FocusScope.of(context).unfocus();

        await provider.sendOtp(email: emailController.text);

        if (provider.error != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(provider.error!),
            ),
          );
        } else if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text("OTP sent successfully!"),
            ),
          );
          GoRouter.of(
            context,
          ).pushNamed(AppRouteConstants.otp, extra: emailController.text);
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

              /// App Logo
              // KSvg(
              //   svgPath: AppAssetsConstants.logo,
              //   height: 100.h,
              //   width: 100.w,
              //   boxFit: BoxFit.cover,
              // ),
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
                              // 🆕 wrap UI inside Form
                              key: _formKey, // 🆕 attach validation form key
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 30),
                                    child: KText(
                                      text: "Recover | Reset your password",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  KVerticalSpacer(height: 20.h),

                                  /// Card Container
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
                                      color: AppColors.secondaryColor,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        KText(
                                          textAlign: TextAlign.center,
                                          text: "Forgot Password",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                        ),
                                        KVerticalSpacer(height: 10.h),
                                        KText(
                                          textAlign: TextAlign.center,
                                          text:
                                              "Enter the email you used to create your account so we can send you a link to reset your password.",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                        KVerticalSpacer(height: 20.h),

                                        /// Email Text Field
                                        KAuthTextFormField(
                                          controller: emailController,
                                          suffixIcon: Icons.mail_outline,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          hintText: "EMAIL ADDRESS",
                                          validator: (v) {
                                            // 🆕 added validation
                                            if (v == null || v.isEmpty) {
                                              return "Please enter your email";
                                            }
                                            if (!v.contains('@')) {
                                              return "Enter a valid email";
                                            }
                                            return null;
                                          },
                                        ),
                                        KVerticalSpacer(height: 20.h),

                                        /// Send Button
                                        KAuthFilledBtn(
                                          isLoading: provider.isLoading,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          fontSize: 10.sp,
                                          text: "Send",
                                          onPressed: () {
                                            if (!provider.isLoading) {
                                              _sendOtp(); // async function called inside sync closure
                                            }
                                          },
                                          height: 22.h,
                                          width: double.infinity,
                                        ),
                                        KVerticalSpacer(height: 12.h),

                                        /// Back to Login Button
                                        KAuthFilledBtn(
                                          backgroundColor: AppColors
                                              .primaryColor
                                              .withOpacity(0.4),
                                          fontSize: 10.sp,
                                          text: "Back to Login",
                                          onPressed: () {
                                            GoRouter.of(context).pop();
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
