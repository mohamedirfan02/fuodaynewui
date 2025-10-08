import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class ComposeEmailScreen extends StatefulWidget {
  const ComposeEmailScreen({super.key});

  @override
  _ComposeEmailScreenState createState() => _ComposeEmailScreenState();
}

class _ComposeEmailScreenState extends State<ComposeEmailScreen> {
  final _toController = TextEditingController();
  final _ccController = TextEditingController();
  final _bccController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  List<File> attachments = [];
  bool isSending = false;

  @override
  void dispose() {
    _toController.dispose();
    _ccController.dispose();
    _bccController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  // Clear all fields
  void clearAllFields() {
    setState(() {
      _toController.clear();
      _ccController.clear();
      _bccController.clear();
      _subjectController.clear();
      _bodyController.clear();
      attachments.clear();
    });
    // Also clear the dropdown
    context.dropDownProviderRead.setValue('emailTemplate', null);
  }

  Future<void> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        attachments = result.paths.map((p) => File(p!)).toList();
      });
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          title: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 30.sp,
              ),
              SizedBox(width: 10.w),
              Text(
                "Success!",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          content: Text(
            "Your email has been sent successfully!",
            style: TextStyle(fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                clearAllFields(); // Clear all fields
              },
              child: Text(
                "OK",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          title: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
                size: 30.sp,
              ),
              SizedBox(width: 10.w),
              Text(
                "Failed!",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          content: Text(
            "Failed to send email:\n$errorMessage",
            style: TextStyle(fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(
                "OK",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> sendMail() async {
    if (_toController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please enter at least one recipient."),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
      return;
    }

    setState(() => isSending = true);

    String username = "mohamed18cs23@gmail.com";
    String password = "kwplddvbsucthgrw";

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, "Flutter Email App")
      ..recipients.addAll(_toController.text.split(","))
      ..ccRecipients.addAll(
        _ccController.text.isEmpty ? [] : _ccController.text.split(","),
      )
      ..bccRecipients.addAll(
        _bccController.text.isEmpty ? [] : _bccController.text.split(","),
      )
      ..subject = _subjectController.text
      ..text = _bodyController.text
      ..html = "<p>${_bodyController.text}</p>";

    for (var file in attachments) {
      message.attachments.add(FileAttachment(file));
    }

    try {
      final sendReport = await send(message, smtpServer);
      print("Send report: $sendReport");

      setState(() => isSending = false);

      // Show success dialog
      showSuccessDialog();

    } on MailerException catch (e) {
      setState(() => isSending = false);

      // Show error dialog
      showErrorDialog(e.toString());

    } catch (e) {
      setState(() => isSending = false);

      // Show generic error dialog
      showErrorDialog("An unexpected error occurred: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Index",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.titleColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            KDropdownTextFormField<String>(
              hintText: "Template",
              value: context.dropDownProviderWatch.getValue('emailTemplate'),
              items: ['Welcome Email', 'Newsletter Email', 'Reminder Email'],
              onChanged: (value) =>
                  context.dropDownProviderRead.setValue('emailTemplate', value),
            ),
            SizedBox(height: 10.h),

            // Replace default TextFields with KAuthTextFormField
            KAuthTextFormField(
              label: "To",
              hintText: "Enter recipient emails (comma separated)",
              controller: _toController,
              floatingLabel: false,
            ),
            SizedBox(height: 10.h),
            KAuthTextFormField(
              label: "Cc (optional)",
              hintText: "Enter CC emails",
              controller: _ccController,
              floatingLabel: false,
            ),
            SizedBox(height: 10.h),
            KAuthTextFormField(
              label: "Bcc (optional)",
              hintText: "Enter BCC emails",
              controller: _bccController,
              floatingLabel: false,
            ),
            SizedBox(height: 10.h),
            KAuthTextFormField(
              label: "Subject",
              hintText: "Enter subject",
              controller: _subjectController,
              floatingLabel: false,
            ),
            SizedBox(height: 10.h),
            KAuthTextFormField(
              label: "Compose email",
              hintText: "Write your message here",
              controller: _bodyController,
              maxLines: 8,
              floatingLabel: false,
            ),
            SizedBox(height: 15.h),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: pickFiles,
              icon: const Icon(Icons.attach_file, color: Colors.white),
              label: const Text(
                "Add Attachments",
                style: TextStyle(color: Colors.white),
              ),
            ),

            SizedBox(height: 10.h),
            if (attachments.isNotEmpty)
              ...attachments.map(
                    (file) => ListTile(
                  leading: const Icon(Icons.insert_drive_file,
                      color: AppColors.primaryColor),
                  title: Text(
                    file.path.split('/').last,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        attachments.remove(file);
                      });
                    },
                  ),
                ),
              ),

            if (isSending)
              Padding(
                padding: EdgeInsets.all(8.h),
                child: Column(
                  children: [
                    const Center(child: CircularProgressIndicator()),
                    SizedBox(height: 8.h),
                    Text(
                      "Sending email...",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),

            KVerticalSpacer(height: 10.h),

            // Cancel Button
            KAuthFilledBtn(
              height: 24.h,
              width: double.infinity,
              text: "Cancel",
              fontSize: 10.sp,
              textColor: AppColors.primaryColor,
              onPressed: () {
                clearAllFields(); // Clear all fields
                GoRouter.of(context).pop();
              },
              backgroundColor: AppColors.primaryColor.withOpacity(0.4),
            ),

            SizedBox(height: 12.h),

            // Submit Button
            KAuthFilledBtn(
              height: 24.h,
              fontSize: 10.sp,
              width: double.infinity,
              text: isSending ? "Sending..." : "Submit",
              textColor: AppColors.secondaryColor,
              onPressed: () {
                if (!isSending) {
                  sendMail();
                }
              },
              backgroundColor: isSending
                  ? AppColors.greyColor
                  : AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}