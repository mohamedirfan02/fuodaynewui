import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:go_router/go_router.dart';

class TermsOfServiceScreen extends StatefulWidget {
  const TermsOfServiceScreen({super.key});

  @override
  State<TermsOfServiceScreen> createState() => _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Terms of Service",
          style: TextStyle(color: AppColors.secondaryColor),
        ),
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
                      "Fuoday is a Human Resource Management System (HRMS) application developed and maintained by Thikse Software Solutions. "
                          "These Terms of Service govern your access and use of the Fuoday mobile application and related services.",
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                    SizedBox(height: 20.h),

                    _sectionTitle("1. Acceptance of Terms"),
                    _sectionBody(
                      "By creating an account, logging in, or using the Fuoday application, you acknowledge that you have read, understood, and agree to comply with these Terms of Service issued by Thikse Software Solutions.",
                    ),

                    _sectionTitle("2. User Responsibilities"),
                    _sectionBody(
                      "You agree that when using Fuoday, you will:\n"
                          "• Provide accurate and truthful information\n"
                          "• Keep your account credentials confidential\n"
                          "• Not engage in illegal, fraudulent, or harmful activities\n"
                          "• Not attempt to disrupt, hack, or reverse-engineer the platform\n",
                    ),

                    _sectionTitle("3. Account Registration"),
                    _sectionBody(
                      "Users must provide accurate information such as name, email, and profile details during registration. "
                          "You are solely responsible for activities carried out under your account.",
                    ),

                    _sectionTitle("4. Use of Services"),
                    _sectionBody(
                      "Fuoday provides HRMS functionalities which may include:\n"
                          "• Attendance & Time Tracking\n"
                          "• Leave Management\n"
                          "• Employee Profile Management\n"
                          "• Document Uploading\n"
                          "• Notifications and Alerts",
                    ),

                    _sectionTitle("5. Intellectual Property"),
                    _sectionBody(
                      "All software, designs, logos, source code, trademarks, and related assets of Fuoday "
                          "are the exclusive property of Thikse Software Solutions. "
                          "You may not copy, modify, distribute, or use them without prior written consent.",
                    ),

                    _sectionTitle("6. User-Uploaded Content"),
                    _sectionBody(
                      "You are responsible for any files, documents, images, or content uploaded to Fuoday. "
                          "You must not upload content that is illegal, offensive, copyrighted, or harmful.",
                    ),

                    _sectionTitle("7. Data Privacy & Usage"),
                    _sectionBody(
                      "Thikse Software Solutions may collect and use information such as name, email, HR-related data, device information, and in-app usage "
                          "to provide core features, improve performance, and enhance security of Fuoday.",
                    ),

                    _sectionTitle("8. Suspension or Termination"),
                    _sectionBody(
                      "Thikse Software Solutions reserves the right to suspend or terminate user accounts in cases of policy violations, "
                          "misuse of the platform, or any activity deemed harmful to the system or other users.",
                    ),

                    _sectionTitle("9. Limitation of Liability"),
                    _sectionBody(
                      "Thikse Software Solutions is not responsible for any losses, damages, or legal consequences arising from:\n"
                          "• Service interruptions\n"
                          "• Data loss\n"
                          "• Unauthorized access\n"
                          "• User misconduct",
                    ),

                    _sectionTitle("10. Updates to Terms"),
                    _sectionBody(
                      "These Terms may be updated from time to time. Continued use of Fuoday after updates "
                          "constitutes acceptance of the revised terms.",
                    ),

                    _sectionTitle("11. Contact Information"),
                    _sectionBody(
                      "If you have questions or concerns regarding these Terms, you may contact:\n\n"
                          "Thikse Software Solutions\n"
                          "Email: contact@fuoday.in\n"
                          "Website: thikse.in",
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
                            "I agree to the above Terms of Service.",
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),
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
