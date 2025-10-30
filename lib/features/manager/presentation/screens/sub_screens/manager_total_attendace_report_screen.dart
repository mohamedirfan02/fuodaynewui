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
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:open_filex/open_filex.dart';

class ManagerTotalAttendanceRepotScreen extends StatefulWidget {
  const ManagerTotalAttendanceRepotScreen({super.key});

  @override
  State<ManagerTotalAttendanceRepotScreen> createState() =>
      _ManagerTotalAttendanceRepotScreenState();
}

class _ManagerTotalAttendanceRepotScreenState
    extends State<ManagerTotalAttendanceRepotScreen> {
  // Controller
  final TextEditingController monthYearController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  // Store selected month and year
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

    // ✅ Fetch attendance data once on init
    Future.microtask(() {
      context.roleWiseAttendanceReportProviderRead.fetchAllRoleAttendance(
        webUserId,
      );
    });
  }

  @override
  void dispose() {
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

      // Trigger rebuild to update the table with filtered data
      setState(() {});
    }
  }

  List<Map<String, String>> getFilteredData(List<Map<String, String>> allData) {
    if (selectedMonth == null || selectedYear == null) {
      return allData; // no filter
    }

    return allData.where((row) {
      final dateString = row['Date'] ?? '';
      if (dateString == '-' || dateString.isEmpty) return false;

      try {
        // Try parsing YYYY-MM-DD
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

  // Method to get filename with month/year suffix
  String getFilenameSuffix() {
    if (selectedMonth != null && selectedYear != null) {
      return '_${selectedMonth?.toString().padLeft(2, '0')}_$selectedYear';
    }
    return '_all_months';
  }

  @override
  Widget build(BuildContext context) {
    final attendanceProvider = context.roleWiseAttendanceReportProviderWatch;

    final employees = attendanceProvider.attendanceReport?.hrList ?? [];
    // Total Attendance Provider
    // Dummy Data (for testing)

    // Table Columns
    final columns = [
      'S.No',
      'Date',
      'Name',
      'Emo ID',
      'Checkin',
      'Checkout',
      'Worked Hours',
      'Status',
    ];
    //final List<Map<String, String>> allData = dummydata;
     final now = DateTime.now();
    final tenDaysAgo = now.subtract(const Duration(days: 10));
    // ✅ Filter only the last 10 days’ records
    final recentEmployees = employees.where((e) {
      final dateStr = e.date ?? '';
      if (dateStr.isEmpty) return false;
      final parsedDate = DateTime.tryParse(dateStr);
      if (parsedDate == null) return false;
      return parsedDate.isAfter(tenDaysAgo);
    }).toList();

    // ✅ Convert filtered list to displayable Map format
    final List<Map<String, String>>
    allData = recentEmployees.asMap().entries.map((entry)
    // final List<Map<String, String>> allData = employees.asMap().entries.map((
    //   entry,
    // )
    {
      final i = entry.key + 1;
      final e = entry.value;
      return {
        'S.No': '$i',
        'Date': e.date ?? '',
        'Name': e.name ?? '-',
        'Emp ID': e.empId ?? '',
        'Checkin': e.checkin ?? '',
        'Checkout': e.checkout ?? '',
        //'Worked Hours': e.workedHours ?? '',
        'Status': e.status ?? '',
      };
    }).toList();

    // All Table Data (unfiltered)
    // final List<Map<String, String>> allData =
    //     totalAttendanceProvider.attendanceDetails?.data?.days
    //         ?.asMap()
    //         .entries
    //         .map((entry) {
    //           final index = entry.key + 1;
    //           final day = entry.value;
    //
    //           return {
    //             'S.No': '$index',
    //             'Date': day.date ?? '-',
    //             'Day': day.day ?? '-',
    //             'Log on': day.checkin ?? '-',
    //             'Log off': day.checkout ?? '-',
    //             'Worked hours': day.workedHours ?? '-',
    //             'Status': day.status ?? '-',
    //           };
    //         })
    //         .toList() ??
    //     [];

    // Filtered data for display and download
    final filteredData = getFilteredData(allData);

    // Re-index the filtered data
    final displayData = filteredData.asMap().entries.map((entry) {
      final newIndex = entry.key + 1;
      final row = Map<String, String>.from(entry.value);
      row['S.No'] = '$newIndex';
      return row;
    }).toList();

    return Scaffold(
      appBar: KAppBar(
        title: "All Employee Attendance",
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
            height: 24.h,
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
                            final pdfService = getIt<PdfGeneratorServiceReusableWidget>();
                            // ✅ Step 2: Generate and save PDF
                            final generatedFile = await pdfService.generateAndSavePdf(
                              title:
                              selectedMonth != null && selectedYear != null
                                  ? 'Employee Attendance Report - ${selectedMonth?.toString().padLeft(2, '0')}/$selectedYear'
                                  : 'All Employee Attendance Report',
                              filename:
                              'employee_attendance_report${getFilenameSuffix()}.pdf',
                              columns: List<String>.from(columns),
                              data: List<Map<String, String>>.from(displayData),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("✅ PDF generated successfully!"),
                              ),
                            );
                            // ✅ Step 3: Open the generated file
                            await OpenFilex.open(generatedFile.path);
                          },

                          onExcelTap: () async {
                            final excelService = getIt<ExcelGeneratorService>();
                            final suffix = getFilenameSuffix();

                            // Use filtered data for Excel
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
                    // KText(
                    //   text: "Search",
                    //   fontWeight: FontWeight.w600,
                    //   fontSize: 14.sp,
                    // ),
                    // KVerticalSpacer(height: 12.h),
                    KAuthTextFormField(
                      onTap: () {},
                      hintText: "Search Name",
                      suffixIcon: Icons.search,
                      keyboardType: TextInputType.text,
                      controller: searchController,
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

                    // Show selected filter info and clear option
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
                                    Icons.calendar_today_outlined,
                                    size: 48.sp,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    selectedMonth != null &&
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
    );
  }
}
