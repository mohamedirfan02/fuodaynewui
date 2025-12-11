import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/models/file_preview_data.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/ats_candidate/widgets/k_ats_file_upload_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';

class AddResponseDialogWidget extends StatefulWidget {
  final String title;
  final String responseLabel;
  final String uploadLabel;
  final String fileKey;
  final Function(String responseText, dynamic pickedFile) onSendTap;

  const AddResponseDialogWidget({
    super.key,
    required this.title,
    required this.responseLabel,
    required this.uploadLabel,
    required this.fileKey,
    required this.onSendTap,
  });

  @override
  State<AddResponseDialogWidget> createState() =>
      _AddResponseDialogWidgetState();
}

class _AddResponseDialogWidgetState extends State<AddResponseDialogWidget> {
  late TextEditingController responseController;

  @override
  void initState() {
    super.initState();
    responseController = TextEditingController();
  }

  @override
  void dispose() {
    responseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title + Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KText(
                    text: widget.title,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Response Label
              KText(
                text: widget.responseLabel,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 8),

              /// Response TextField
              KAuthTextFormField(
                controller: responseController,
                maxLines: 4,
                hintText: 'Write your response here...',
              ),

              const SizedBox(height: 16),

              /// Upload Label
              KText(
                text: widget.uploadLabel,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),

              /// File Upload Tile
              KAtsUploadPickerTile(
                backgroundcolor: theme.cardColor,
                showOnlyView: context.filePickerProviderWatch.isPicked(
                  widget.fileKey,
                ),

                onViewTap: () {
                  final pickedFile = context.filePickerProviderRead.getFile(
                    widget.fileKey,
                  );
                  if (pickedFile == null) return;

                  final filePath = pickedFile.path;
                  final fileName = pickedFile.name.toLowerCase();

                  if (fileName.endsWith('.pdf')) {
                    GoRouter.of(context).pushNamed(
                      "pdf-preview",
                      extra: FilePreviewData(
                        filePath: filePath!,
                        fileName: fileName,
                      ),
                    );
                  } else if (fileName.endsWith('.png') ||
                      fileName.endsWith('.jpg') ||
                      fileName.endsWith('.jpeg') ||
                      fileName.endsWith('.webp')) {
                    GoRouter.of(context).pushNamed(
                      "image-preview",
                      extra: FilePreviewData(
                        filePath: filePath!,
                        fileName: fileName,
                      ),
                    );
                  } else {
                    KSnackBar.failure(context, "Unsupported file type");
                  }
                },

                showCancel: context.filePickerProviderWatch.isPicked(
                  widget.fileKey,
                ),

                onCancelTap: () {
                  context.filePickerProviderRead.removeFile(widget.fileKey);
                  KSnackBar.success(context, "File removed successfully");
                },

                uploadOnTap: () async {
                  final filePicker = context.filePickerProviderRead;
                  await filePicker.pickFile(widget.fileKey);

                  final pickedFile = filePicker.getFile(widget.fileKey);
                  if (pickedFile != null) {
                    KSnackBar.success(
                      context,
                      "Picked file: ${pickedFile.name}",
                    );
                  } else {
                    KSnackBar.failure(context, "No file selected.");
                  }
                },

                uploadPickerTitle: "",
                uploadPickerIcon:
                    context.filePickerProviderWatch.isPicked(widget.fileKey)
                    ? Icons.check_circle
                    : Icons.cloud_upload_outlined,

                description:
                    context.filePickerProviderWatch.getFile(widget.fileKey) !=
                        null
                    ? "Selected File: ${context.filePickerProviderWatch.getFile(widget.fileKey)!.name}"
                    : "Browse file to upload\nSupports .pdf, .doc, .docx",
              ),

              SizedBox(height: 24.h),

              /// Buttons Row
              Row(
                children: [
                  Expanded(
                    child: KAtsGlowButton(
                      text: "Cancel",
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      textColor:
                          theme.textTheme.headlineLarge?.color ??
                          AppColors.titleColor,
                      backgroundColor: theme.secondaryHeaderColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: KAtsGlowButton(
                      text: "Send",
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      textColor: theme.secondaryHeaderColor,
                      gradientColors: AppColors.atsButtonGradientColor,
                      onPressed: () {
                        final file = context.filePickerProviderRead.getFile(
                          widget.fileKey,
                        );

                        widget.onSendTap(responseController.text.trim(), file);

                        Navigator.pop(context);

                        showDialog(
                          context: Navigator.of(
                            context,
                            rootNavigator: true,
                          ).context,
                          barrierDismissible: false,
                          builder: (_) => const ResponseSuccessDialog(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponseSuccessDialog extends StatelessWidget {
  const ResponseSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success Icon Circle
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green,
                size: 40.w,
              ),
            ),

            SizedBox(height: 18.h),

            // Title
            KText(
              text: "Response Send",
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: theme.textTheme.bodyLarge?.color,
            ),

            SizedBox(height: 10.h),

            // Sub message
            KText(
              text: "Successfully Sent. We’ll reach you soon.",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 24.h),

            // Gradient Done Button
            SizedBox(
              width: double.infinity,
              child: KAtsGlowButton(
                text: "Done",
                fontWeight: FontWeight.w600,
                fontSize: 14,
                textColor: Colors.white,
                gradientColors: AppColors.atsButtonGradientColor,
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
