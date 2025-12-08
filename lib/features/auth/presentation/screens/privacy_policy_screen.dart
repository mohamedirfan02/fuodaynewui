import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy",style: TextStyle(color: AppColors.secondaryColor),),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            /// Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      text: "Welcome to Fuoday",
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    ),
                    SizedBox(height: 12.h),

                    KText(
                      text:
                      "We are committed to protecting your personal information. "
                          "This policy describes how Fuoday collects, uses, and stores user data.",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(height: 20.h),

                    _sectionTitle("1. Information We Collect"),
                    _sectionBody(
                      "• Full Name\n"
                          "• Email Address\n"
                          "• Mobile Number\n"
                          "• Profile Picture\n"
                          "• Device Information\n"
                          "• Files & Documents you upload in the app\n"
                          "• Login Activity & Usage Data",
                    ),

                    _sectionTitle("2. Why We Collect This Data"),
                    _sectionBody(
                      "We collect this data to:\n"
                          "• Create and manage user accounts\n"
                          "• Improve app experience and reliability\n"
                          "• Enable features like profile, attendance, and HRMS tools\n"
                          "• Communicate updates and notifications\n"
                          "• Detect and prevent fraud",
                    ),

                    _sectionTitle("3. Data Storage & Security"),
                    _sectionBody(
                      "Your data is securely stored using encrypted systems like Hive and Secure Storage.\n"
                          "We do not share your data with third parties without your consent.",
                    ),

                    _sectionTitle("4. Permissions We Use"),
                    _sectionBody(
                      "To provide features like camera, media upload, and file access, we request:\n"
                          "• Camera Access\n"
                          "• Storage Access\n"
                          "• Internet Access",
                    ),

                    _sectionTitle("5. Your Rights"),
                    _sectionBody(
                      "You may request to:\n"
                          "• View your data\n"
                          "• Update or correct data\n"
                          "• Delete your account\n"
                          "• Revoke permissions",
                    ),

                    _sectionTitle("6. Contact Us"),
                    _sectionBody(
                      "If you have support or privacy questions, contact:\n"
                          "contact@thikse.in",
                    ),

                    SizedBox(height: 20.h),

                    /// Accept Terms Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _isAccepted,
                          activeColor: AppColors.primaryColor,
                          onChanged: (val) {
                            setState(() {
                              _isAccepted = val ?? false;
                            });
                          },
                        ),
                        Flexible(
                          child: KText(
                            text:
                            "I acknowledge that Fuoday may store and use my information as described above.",
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                onPressed: _isAccepted

                    ? () {
                  GoRouter.of(context).pop();
                }
                    : null,
                child: Text(
                  "Accept & Continue",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h, top: 12.h),
      child: KText(
        text: text,
        fontWeight: FontWeight.w600,
        fontSize: 14.sp,
        color: Colors.black,
      ),
    );
  }

  Widget _sectionBody(String text) {
    return KText(
      text: text,
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: Colors.grey.shade700,
    );
  }
}
