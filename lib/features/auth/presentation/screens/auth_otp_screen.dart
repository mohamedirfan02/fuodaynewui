import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_linear_gradient_bg.dart';
import 'package:fuoday/commons/widgets/k_svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/providers/forgot_password_provider.dart';
import 'package:fuoday/features/auth/presentation/providers/verify_otp_provider.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_btn.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class AuthOtpScreen extends StatefulWidget {
  final String email;
  const AuthOtpScreen({super.key, required this.email});

  @override
  State<AuthOtpScreen> createState() => _AuthOtpScreenState();
}

class _AuthOtpScreenState extends State<AuthOtpScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VerifyOtpProvider>(context);
    final provider2 = Provider.of<ForgotPasswordProvider>(context);

    void _resendOtp() async {
      FocusScope.of(context).unfocus();

      await provider2.sendOtp(email: widget.email);

      if (provider.error != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(provider.error!)),
        );
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text("OTP sent successfully!"),
          ),
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: KLinearGradientBg(
        gradientColor: AppColors.employeeGradientColor,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(height: 40.h),

                        // App Logo
                        Image.asset(
                          AppAssetsConstants.logo,
                          height: 150.h,
                          width: 150.w,
                          // fit: BoxFit.cover,
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.authBgColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30.r),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              KVerticalSpacer(height: 30.h),

                              KText(
                                text: "Start Your Experience",
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                              KVerticalSpacer(height: 10.h),
                              KText(
                                text: "Login Now",
                                fontWeight: FontWeight.w500,
                                color: AppColors.subTitleColor,
                                fontSize: 14.sp,
                              ),
                              KVerticalSpacer(height: 20.h),

                              KSvg(
                                svgPath: AppAssetsConstants.otpImg,
                                height: 0.2.sh,
                                boxFit: BoxFit.contain,
                              ),
                              KVerticalSpacer(height: 30.h),

                              KText(
                                text: "Enter Verification Code",
                                fontWeight: FontWeight.w600,
                                color: AppColors.titleColor,
                                fontSize: 16.sp,
                              ),
                              KVerticalSpacer(height: 20.h),

                              KText(
                                text: "We sent a code to ${widget.email}",
                                fontWeight: FontWeight.w400,
                                color: AppColors.titleColor,
                                fontSize: 12.sp,
                              ),
                              KVerticalSpacer(height: 20.h),

                              Pinput(
                                controller: otpController,
                                length: 6,
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                obscureText: true,
                                defaultPinTheme: PinTheme(
                                  width: 56,
                                  height: 56,
                                  textStyle: GoogleFonts.sora(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              KVerticalSpacer(height: 20.h),

                              KAuthFilledBtn(
                                backgroundColor: AppColors.primaryColor,
                                fontSize: 10.sp,
                                isLoading: provider.isLoading,
                                text: provider.isLoading
                                    ? "Verifying..."
                                    : "Verify",
                                onPressed: () {
                                  if (!provider.isLoading) {
                                    // 👇 Wrap async code inside a synchronous closure
                                    () async {
                                      FocusScope.of(context).unfocus();

                                      await provider.verifyOtp(
                                        email: widget.email,
                                        otp: otpController.text,
                                      );
                                      debugPrint(
                                        "Email check :${widget.email} | OPT Check :${otpController.text}",
                                      );

                                      if (provider.error != null &&
                                          context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(provider.error!),
                                          ),
                                        );
                                      } else if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                              "OTP verified successfully!",
                                            ),
                                          ),
                                        );
                                        GoRouter.of(context).pushNamed(
                                          AppRouteConstants.resetPassword,
                                          extra: {
                                            'email': widget.email,
                                            'otp': otpController.text,
                                          },
                                        );
                                      }
                                    }(); // immediately invoke the async function
                                  }
                                },
                                height: 22.h,
                                width: double.infinity,
                              ),

                              KVerticalSpacer(height: 20.h),

                              KText(
                                text: "Don’t receive OTP code?",
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                                color: AppColors.textBtnColor,
                              ),
                              provider2.isLoading
                                  ? CircularProgressIndicator()
                                  : KAuthTextBtn(
                                      onTap: () {
                                        // TODO: resend OTP logic
                                        _resendOtp();
                                        debugPrint("Resend Button OnTaped");
                                      },
                                      text: "Resend code now",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      textAlign: TextAlign.center,
                                      textColor: AppColors.textBtnColor,
                                      showUnderline: true,
                                    ),
                              KVerticalSpacer(height: 20.h),
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
    );
  }
}
