import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_download_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/pdf_generator_service.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';

class ManagerFeedsScreen extends StatefulWidget {
  const ManagerFeedsScreen({super.key});

  @override
  State<ManagerFeedsScreen> createState() => _ManagerFeedsScreenState();
}

class _ManagerFeedsScreenState extends State<ManagerFeedsScreen> {
  final TextEditingController monthYearController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  int? selectedMonth;
  int? selectedYear;

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

    Future.microtask(() {
      context.totalAttendanceDetailsProviderRead.fetchAttendanceDetails(
        webUserId,
      );
    });

    // 🔍 Add listener for search functionality
    searchController.addListener(() {
      setState(() {}); // Rebuild whenever search text changes
    });
  }

  @override
  void dispose() {
    monthYearController.dispose();
    searchController.dispose();
    super.dispose();
  }

  //    Filter by month/year and search query
  List<Map<String, String>> getFilteredData(List<Map<String, String>> allData) {
    final query = searchController.text.trim().toLowerCase();

    // Filter by month/year
    List<Map<String, String>> monthFilteredData;
    if (selectedMonth != null && selectedYear != null) {
      monthFilteredData = allData.where((row) {
        final dateString = row['Deadline'] ?? '';
        if (dateString.isEmpty || dateString == '-') return false;
        try {
          final date = DateTime.tryParse(dateString);
          if (date != null) {
            return date.month == selectedMonth && date.year == selectedYear;
          }
        } catch (_) {
          return false;
        }
        return false;
      }).toList();
    } else {
      monthFilteredData = allData;
    }

    // 🔍 Filter by search text (Project, Assigned By, Description)
    if (query.isNotEmpty) {
      return monthFilteredData.where((row) {
        final project = row['Project']?.toLowerCase() ?? '';
        final assignedBy = row['Assigned By']?.toLowerCase() ?? '';
        final description = row['Description']?.toLowerCase() ?? '';
        return project.contains(query) ||
            assignedBy.contains(query) ||
            description.contains(query);
      }).toList();
    }

    return monthFilteredData;
  }

  String getFilenameSuffix() {
    if (selectedMonth != null && selectedYear != null) {
      return '_${selectedMonth?.toString().padLeft(2, '0')}_$selectedYear';
    }
    return '_all_months';
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final totalAttendanceProvider = context.totalAttendanceDetailsProviderWatch;

    //    Dummy Data
    final List<Map<String, String>> dummydata = [
      // {
      //   'S.No': '1',
      //   'Project': '-',
      //   'Assigned By': '-',
      //   'Description': '-',
      //   'Progress': '-',
      //   'Deadline': '-',
      //   'Status': '-',
      // },
      // {
      //   'S.No': '2',
      //   'Project': 'Payroll Integration',
      //   'Assigned By': 'Sarah HR',
      //   'Description': 'Integrate payroll system with leave management.',
      //   'Progress': '100%',
      //   'Deadline': '2025-10-20',
      //   'Status': 'Completed',
      // },
      // {
      //   'S.No': '3',
      //   'Project': 'Recruitment Portal',
      //   'Assigned By': 'Michael Admin',
      //   'Description': 'Develop internal portal for managing job applications.',
      //   'Progress': '60%',
      //   'Deadline': '2025-11-15',
      //   'Status': 'In Progress',
      // },
      // {
      //   'S.No': '4',
      //   'Project': 'Performance Dashboard',
      //   'Assigned By': 'Emily HR',
      //   'Description':
      //       'Create dashboard to visualize employee KPIs and reports.',
      //   'Progress': '30%',
      //   'Deadline': '2025-12-01',
      //   'Status': 'Pending',
      // },
      // {
      //   'S.No': '5',
      //   'Project': 'Onboarding App',
      //   'Assigned By': 'David Lead',
      //   'Description': 'Mobile app to streamline employee onboarding process.',
      //   'Progress': '45%',
      //   'Deadline': '2025-11-25',
      //   'Status': 'In Progress',
      // },
    ];

    final columns = [
      'S.No',
      'Project',
      'Assigned By',
      'Description',
      'Progress',
      'Deadline',
      'Status',
    ];

    final List<Map<String, String>> allData = dummydata;
    final filteredData = getFilteredData(allData);

    // Re-index data for display
    final displayData = filteredData.asMap().entries.map((entry) {
      final newIndex = entry.key + 1;
      final row = Map<String, String>.from(entry.value);
      row['S.No'] = '$newIndex';
      return row;
    }).toList();

    return Scaffold(
      appBar: KAppBar(
        title: "Manager Feeds Tasks",
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
            text: displayData.isEmpty ? "No Data to Download" : "Download",
            onPressed: displayData.isEmpty
                ? () {}
                : () {
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
                            final pdfService = getIt<PdfGeneratorService>();
                            final suffix = getFilenameSuffix();
                            final pdfFile = await pdfService.generateAndSavePdf(
                              data: List<Map<String, String>>.from(displayData),
                              columns: List<String>.from(columns),
                              title:
                                  selectedMonth != null && selectedYear != null
                                  ? 'Manager Tasks - ${selectedMonth?.toString().padLeft(2, '0')}/$selectedYear'
                                  : 'Manager Tasks Report',
                              filename: 'manager_tasks$suffix.pdf',
                            );
                            await OpenFilex.open(pdfFile.path);
                          },
                          onExcelTap: () async {
                            final excelService = getIt<ExcelGeneratorService>();
                            final suffix = getFilenameSuffix();
                            final excelFile = await excelService
                                .generateAndSaveExcel(
                                  data: List<Map<String, String>>.from(
                                    displayData,
                                  ),
                                  columns: List<String>.from(columns),
                                  filename: 'manager_tasks$suffix.xlsx',
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
      body: totalAttendanceProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : totalAttendanceProvider.errorMessage != null
          ? Center(child: Text(totalAttendanceProvider.errorMessage!))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔍 Search Field
                    KAuthTextFormField(
                      hintText:
                          "Search by project, assigned by, or description",
                      suffixIcon: Icons.search,
                      keyboardType: TextInputType.text,
                      controller: searchController,
                    ),
                    KVerticalSpacer(height: 20.h),

                    SizedBox(
                      height: 600.h,
                      child: displayData.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.work_outline,
                                    size: 48.sp,
                                    color: theme
                                        .textTheme
                                        .bodyLarge
                                        ?.color, //AppColors.greyColor,,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    searchController.text.isNotEmpty
                                        ? 'No matching tasks found'
                                        : 'No task data available',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: theme
                                          .textTheme
                                          .bodyLarge
                                          ?.color, //AppColors.greyColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : KDataTable(
                              columnTitles: columns,
                              rowData: displayData,
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
