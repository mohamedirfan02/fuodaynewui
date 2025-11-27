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
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';

class ManagerLateArrivalScreen extends StatefulWidget {
  const ManagerLateArrivalScreen({super.key});

  @override
  State<ManagerLateArrivalScreen> createState() =>
      _ManagerLateArrivalScreenState();
}

class _ManagerLateArrivalScreenState extends State<ManagerLateArrivalScreen> {
  // Controllers
  final TextEditingController searchController = TextEditingController();

  // Services
  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;
  late final String name;
  late final int webUserId;

  // Filters
  String? selectedName;

  @override
  void initState() {
    super.initState();

    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    name = employeeDetails?['name'] ?? "No Name";
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    // //   Fetch API data using provider
    // Future.microtask(() {
    //   context.allRoleLateArrivalsReportProviderRead.fetchLateArrivals();
    // });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //   Watch provider for API data
    final lateArrivalProvider = context.allRoleLateArrivalsReportProviderWatch;
    final employees =
        lateArrivalProvider.lateArrivals?.managerSection.employees ?? [];

    //   Convert model data → table data
    final List<Map<String, String>> data = employees.asMap().entries.map((
      entry,
    ) {
      final i = entry.key + 1;
      final e = entry.value;
      return {
        'S.No': i.toString(),
        'Employee': e.employeeName ?? '',
        'Department': e.department ?? '-',
        'Late Days': e.lateCount?.toString() ?? '',
        'Average Late': e.averageLateMinutes?.toString() ?? '',
        'Late': "${e.lateArrivalPercentage?.toString()}%" ?? '',
        'Trend': e.recordsUpdated?.toString() ?? '',
      };
    }).toList();

    // 🆕 Unique names for dropdown
    final uniqueNames = data
        .map((item) => item['Employee'])
        .where((name) => name != null && name!.isNotEmpty)
        .toSet()
        .toList();

    //   Filtered data (Dropdown + Search)
    final List<Map<String, String>> filteredData = data.where((item) {
      final matchesName =
          selectedName == null || item['Employee'] == selectedName;
      final matchesSearch =
          searchController.text.isEmpty ||
          item['Employee']!.toLowerCase().contains(
            searchController.text.toLowerCase(),
          );
      return matchesName && matchesSearch;
    }).toList();

    //   Columns order
    final columns = [
      'S.No',
      'Employee',
      'Department',
      'Late Days',
      'Average Late',
      'Late',
      "Trend",
    ];

    return Scaffold(
      appBar: KAppBar(
        title: "All Employee Late Arrival",
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
            backgroundColor: theme.primaryColor,
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
                        title: selectedName != null
                            ? 'Late Arrival Report - $selectedName'
                            : 'All Employee Late Arrival Report',
                        filename:
                            'late_arrival_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
                        columns: List<String>.from(columns),
                        data: List<Map<String, String>>.from(filteredData),
                        adjustColumnWidth: false,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("  PDF generated successfully!"),
                        ),
                      );
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
                        filename: 'Late Arrival Report.xlsx',
                        columns: columns,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("  PDF generated successfully!"),
                        ),
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
                text: "Search by",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              KVerticalSpacer(height: 12.h),

              //   Dropdown + Clear Button Row
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                        hintText: "Select Employee Name",
                      ),
                      value: selectedName,
                      items: uniqueNames
                          .map(
                            (name) => DropdownMenuItem(
                              value: name,
                              child: Text(name!),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() => selectedName = value);
                      },
                    ),
                  ),

                  // 🆕 Clear dropdown logic
                  if (selectedName != null)
                    IconButton(
                      icon: const Icon(Icons.clear, color: Colors.redAccent),
                      tooltip: "Clear Selection",
                      onPressed: () {
                        setState(() => selectedName = null);
                      },
                    ),
                ],
              ),

              KVerticalSpacer(height: 12.h),

              KText(
                text: "Search",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              KVerticalSpacer(height: 12.h),

              //   Search field with real-time filter
              KAuthTextFormField(
                controller: searchController,
                hintText: "Search by Name",
                keyboardType: TextInputType.text,
                suffixIcon: Icons.search,
                onChanged: (_) => setState(() {}),
              ),

              KVerticalSpacer(height: 40.h),

              //   Data Table
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
