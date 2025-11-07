import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_download_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_pdf_generater_reusable_widget.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/pdf_generator_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:open_filex/open_filex.dart';

class TLTotalAttendanceRepotScreen extends StatefulWidget {
  const TLTotalAttendanceRepotScreen({super.key});

  @override
  State<TLTotalAttendanceRepotScreen> createState() =>
      _TLTotalAttendanceRepotScreenState();
}

class _TLTotalAttendanceRepotScreenState
    extends State<TLTotalAttendanceRepotScreen> {
  final TextEditingController monthYearController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  int? selectedMonth;
  int? selectedYear;
  String searchQuery = ''; //    Added search query state

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

    //    Fetch attendance data once on init
    // Future.microtask(() {
    //   context.roleWiseAttendanceReportProviderRead.fetchAllRoleAttendance(
    //     webUserId,
    //   );
    // });

    //    Add search listener
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.trim();
      });
    });
  }

  @override
  void dispose() {
    searchController.removeListener(() {});
    monthYearController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> selectMonthYear(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedMonth = picked.month;
      selectedYear = picked.year;
      controller.text = "${picked.month}/${picked.year}";
      setState(() {});
    }
  }

  //    Updated filter to include search
  List<Map<String, String>> getFilteredData(List<Map<String, String>> allData) {
    var filtered = allData;

    // Filter by month/year
    if (selectedMonth != null && selectedYear != null) {
      filtered = filtered.where((row) {
        final dateString = row['Date'] ?? '';
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
    }

    //    Filter by search query
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((row) {
        final name = (row['Name'] ?? '').toLowerCase();
        final empId = (row['Emp ID'] ?? '').toLowerCase();
        return name.contains(query) || empId.contains(query);
      }).toList();
    }

    return filtered;
  }

  String getFilenameSuffix() {
    if (selectedMonth != null && selectedYear != null) {
      return '_${selectedMonth?.toString().padLeft(2, '0')}_$selectedYear';
    }
    return '_all_months';
  }

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = context.roleWiseAttendanceReportProviderWatch;

    final employees = attendanceProvider.attendanceReport?.teamsList ?? [];

    final List<Map<String, String>> allData = employees.asMap().entries.map((
      entry,
    ) {
      final i = entry.key + 1;
      final e = entry.value;
      return {
        'S.No': '$i',
        'Date': e.date?.toString() ?? '-',
        'Name': e.name?.toString() ?? '-',
        'Emp ID': e.empId?.toString() ?? '-',
        'Checkin': e.checkin?.toString() ?? '-',
        'Checkout': e.checkout?.toString() ?? '-',
        'Status': e.status?.toString() ?? '-',
      };
    }).toList();

    final filteredData = getFilteredData(allData);
    final displayData = filteredData.asMap().entries.map((entry) {
      final newIndex = entry.key + 1;
      final row = Map<String, String>.from(entry.value);
      row['S.No'] = '$newIndex';
      return row;
    }).toList();

    final columns = [
      'S.No',
      'Date',
      'Name',
      'Emp ID',
      'Checkin',
      'Checkout',
      'Status',
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true, //    Handle keyboard
      appBar: KAppBar(
        title: "All Employee Attendance",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () => GoRouter.of(context).pop(),
      ),
      body: attendanceProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : attendanceProvider.errorMessage != null
          ? Center(child: Text(attendanceProvider.errorMessage!))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //    Search Field (removed onTap override)
                    KAuthTextFormField(
                      hintText: "Search by Name or Employee ID",
                      suffixIcon: Icons.search,
                      keyboardType: TextInputType.text,
                      controller: searchController,
                    ),

                    //    Search result indicator
                    if (searchQuery.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Row(
                          children: [
                            Text(
                              'Found ${displayData.length} result(s) for "$searchQuery"',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  searchController.clear();
                                  searchQuery = '';
                                });
                              },
                              child: Icon(
                                Icons.clear,
                                size: 16.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                    KVerticalSpacer(height: 10.h),
                    KAuthTextFormField(
                      onTap: () {
                        selectMonthYear(context, monthYearController);
                      },
                      hintText: "Select Month & Year",
                      suffixIcon: Icons.calendar_month_outlined,
                      keyboardType: TextInputType.text,
                      controller: monthYearController,
                    ),
                    KVerticalSpacer(height: 10.h),
                    if (selectedMonth != null && selectedYear != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_alt,
                              size: 16.sp,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Showing: ${selectedMonth?.toString().padLeft(2, '0')}/$selectedYear (${displayData.length} records)',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedMonth = null;
                                  selectedYear = null;
                                  monthYearController.clear();
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Icon(
                                  Icons.clear,
                                  size: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                    searchQuery.isNotEmpty
                                        ? Icons.search_off
                                        : Icons.calendar_today_outlined,
                                    size: 48.sp,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    searchQuery.isNotEmpty
                                        ? 'No results found for "$searchQuery"'
                                        : selectedMonth != null &&
                                              selectedYear != null
                                        ? 'No attendance data found for ${selectedMonth?.toString().padLeft(2, '0')}/$selectedYear'
                                        : 'No attendance data available',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
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
                            final pdfService =
                                PdfGeneratorServiceReusableWidget();

                            //  Generate and save PDF
                            final generatedFile = await pdfService.generateAndSavePdf(
                              title:
                                  selectedMonth != null && selectedYear != null
                                  ? 'Attendance Report - ${selectedMonth?.toString().padLeft(2, '0')}/$selectedYear'
                                  : 'Total Attendance Report',
                              filename:
                                  'attendance_report${getFilenameSuffix()}.pdf',
                              columns: List<String>.from(columns),
                              data: List<Map<String, String>>.from(displayData),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("   PDF generated successfully!"),
                              ),
                            );
                            GoRouter.of(context).pop();
                            //  Open the generated file
                            await OpenFilex.open(generatedFile.path);
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
                                  filename: 'attendance_report$suffix.xlsx',
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
    );
  }
}
