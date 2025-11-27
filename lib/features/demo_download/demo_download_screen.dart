import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';

class DemoDownloadScreen extends StatefulWidget {
  const DemoDownloadScreen({super.key});

  @override
  State<DemoDownloadScreen> createState() => _DemoDownloadScreenState();
}

class _DemoDownloadScreenState extends State<DemoDownloadScreen> {
  final TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final downloader = context.appFileDownloaderProviderWatch;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            KText(
              text: "Download any file from URL",
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: AppColors.titleColor,
            ),

            KVerticalSpacer(height: 20.h),

            KAuthTextFormField(
              hintText: "Enter url",
              controller: urlController,
            ),

            KVerticalSpacer(height: 20.h),

            KAuthFilledBtn(
              isLoading: downloader.isDownloading,
              text: "Download From Url",
              onPressed: () {
                final url = urlController.text.trim();
                if (url.isEmpty) return;

                final fileName = Uri.parse(url).pathSegments.last;

                context.appFileDownloaderProviderRead.downloadFile(
                  url: url,
                  fileName: fileName,
                  onCompleted: () {
                    AppLoggerHelper.logInfo("Download complete");
                  },
                  onError: (err) {
                    AppLoggerHelper.logError("Download error: $err");
                  },
                );
              },
            ),

            if (downloader.progress != null)
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: KText(
                  text:
                      "Downloading: ${(downloader.progress! * 100).toStringAsFixed(0)}%",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.titleColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
