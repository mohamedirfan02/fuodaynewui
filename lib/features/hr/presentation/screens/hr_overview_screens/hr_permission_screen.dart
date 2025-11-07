import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_download_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_pdf_generater_reusable_widget.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/pdf_generator_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/hr/presentation/provider/hr_overview_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provider/provider.dart';

class HRPermissionsScreen extends StatefulWidget {
  const HRPermissionsScreen({super.key});

  @override
  State<HRPermissionsScreen> createState() => _HRPermissionsScreenState();
}

class _HRPermissionsScreenState extends State<HRPermissionsScreen> {
  final TextEditingController searchController = TextEditingController();

  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;
  late final String name;
  late final int webUserId;

  @override
  void initState() {
    super.initState();

    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    name = employeeDetails?['name'] ?? "No Name";
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final permissions =
        context.watch<HROverviewProvider>().hrOverview?.permissions ?? [];

    // Convert model → table data
    final List<Map<String, String>> data = permissions.asMap().entries.map((
      entry,
    ) {
      final i = entry.key + 1;
      final e = entry.value;
      return {
        'S.No': i.toString(),
        'Date': e.date.toString() ?? '',
        'Emp ID': e.empId?.toString() ?? '',
        'Name': e.empName.toString() ?? '',
        'Designation': '',
        'Type': e.type.toString() ?? '',
        'To': e.to?.toString() ?? '',
        'Reason': e.reason.toString() ?? '',
        'Day': e.days?.toString() ?? '',
        'Regulation': e.regulationDate?.toString() ?? '',
        'Status': e.status?.toString() ?? '',
      };
    }).toList();

    // Filter only by search
    final List<Map<String, String>> filteredData = data.where((item) {
      return searchController.text.isEmpty ||
          item['Name']!.toLowerCase().contains(
            searchController.text.toLowerCase(),
          );
    }).toList();

    final columns = [
      'S.No',
      'Date',
      'Emp ID',
      'Name',
      'Designation',
      'Type',
      "To",
      "Reason",
      "Day",
      "Regulation",
      "Status",
    ];

    return Scaffold(
      appBar: KAppBar(
        title: "HR Permissions",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () => GoRouter.of(context).pop(),
      ),
      bottomNavigationBar: Container(
        height: 60.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Center(
          child: KAuthFilledBtn(
            backgroundColor: AppColors.primaryColor,
            height: AppResponsive.responsiveBtnHeight(context),
            width: double.infinity,
            text: "Download",
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                builder: (context) {
                  return KDownloadOptionsBottomSheet(
                    onPdfTap: () async {
                      if (filteredData.isEmpty) {
                        KSnackBar.failure(context, "No Data Found");
                        return;
                      }

                      final pdfService =
                          getIt<PdfGeneratorServiceReusableWidget>();

                      final generatedFile = await pdfService.generateAndSavePdf(
                        title: 'All Employee Permissions Report',
                        filename:
                            'permissions_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
                        columns: columns,
                        data: filteredData,
                        adjustColumnWidth: false,
                      );

                      KSnackBar.success(context, "PDF Generated Successfully");
                      GoRouter.of(context).pop();

                      await OpenFilex.open(generatedFile.path);
                    },
                    onExcelTap: () async {
                      if (filteredData.isEmpty) {
                        KSnackBar.failure(context, "No Data Found");
                        return;
                      }

                      final excelService = getIt<ExcelGeneratorService>();
                      final excelFile = await excelService.generateAndSaveExcel(
                        data: filteredData,
                        filename: 'Permissions_Report.xlsx',
                        columns: columns,
                      );
                      KSnackBar.success(
                        context,
                        "Excel generated successfully!",
                      );

                      await OpenFilex.open(excelFile.path);
                    },
                  );
                },
              );
            },
            fontSize: 11.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: "Search",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              KVerticalSpacer(height: 12.h),

              // Search field
              KAuthTextFormField(
                controller: searchController,
                hintText: "Search by Name",
                keyboardType: TextInputType.text,
                suffixIcon: Icons.search,
                onChanged: (_) => setState(() {}),
              ),

              KVerticalSpacer(height: 40.h),

              // Data Table
              if (filteredData.isEmpty)
                const Center(child: Text("No Data Found"))
              else
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: KDataTable(
                    columnTitles: columns,
                    rowData: filteredData,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
