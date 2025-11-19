import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/payslip/presentation/screens/pay_roll.dart';
import 'package:fuoday/features/payslip/presentation/screens/payslip_overview.dart';
import 'package:fuoday/features/payslip/presentation/widgets/pay_slip_download_options.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class PaySlipScreen extends StatelessWidget {
  const PaySlipScreen({super.key});

  Future<void> _downloadAndOpenPayslip(
    BuildContext context,
    int webUserId,
  ) async {
    try {
      final url = AppApiEndpointConstants.downloadPayslip(webUserId);
      debugPrint("Downloading PDF from: $url");

      final response = await DioService().client.post(
        url,
        options: Options(
          responseType: ResponseType.bytes, // Important: get raw PDF bytes
        ),
      );

      if (response.statusCode == 200) {
        final pdfBytes = response.data as Uint8List;

        final dir = await getApplicationDocumentsDirectory();
        final filePath =
            "${dir.path}/payslip_${DateTime.now().millisecondsSinceEpoch}.pdf";

        final file = File(filePath);
        await file.writeAsBytes(pdfBytes);

        debugPrint("Payslip saved at: $filePath");
        await OpenFilex.open(filePath);
      } else {
        debugPrint("Failed to download PDF. Status: ${response.statusCode}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to download payslip PDF')),
        );
      }
    } on DioException catch (e) {
      debugPrint("Dio error: ${e.response?.data ?? e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading PDF: ${e.message}')),
      );
    } catch (e, stackTrace) {
      debugPrint("Unknown error: $e");
      debugPrint("Stack trace: $stackTrace");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 60.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: Center(
            child: KAuthFilledBtn(
              backgroundColor: theme.primaryColor,
              height: AppResponsive.responsiveBtnHeight(context),
              width: double.infinity,
              text: "Download Payslip",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                  ),
                  builder: (context) {
                    return PdfDownloadBottomSheet(
                      onPdfTap: () async {
                        Navigator.pop(context); // Close bottom sheet

                        final employeeDetails =
                            HiveStorageService().employeeDetails;
                        if (employeeDetails != null &&
                            employeeDetails['web_user_id'] != null) {
                          final int webUserId = int.parse(
                            employeeDetails['web_user_id'].toString(),
                          );
                          await _downloadAndOpenPayslip(context, webUserId);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No Web User ID found')),
                          );
                        }
                      },
                    );
                  },
                );
              },
              fontSize: 11.sp,
            ),
          ),
        ),
        appBar: KAppBar(
          title: "PaySlip",
          centerTitle: true,
          leadingIcon: Icons.arrow_back,
          onLeadingIconPress: () {
            GoRouter.of(context).pop();
          },
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              KTabBar(
                tabs: [
                  Tab(text: "PayRoll"),
                  Tab(text: "Overview"),
                ],
              ),
              Expanded(
                child: TabBarView(children: [PayRoll(), PayslipOverview()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
