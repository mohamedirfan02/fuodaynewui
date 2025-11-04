import 'package:data_table_2/data_table_2.dart';
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
import 'package:fuoday/features/hr/domain/entities/total_payroll_entity.dart';
import 'package:fuoday/features/hr/presentation/widgets/currency_symbol_suppport_pdf_server.dart'
    show PdfGeneratorServiceCurrencySymbolSupportWidget;
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:open_filex/open_filex.dart';

class HRTotalPayrollRepotScreen extends StatefulWidget {
  const HRTotalPayrollRepotScreen({super.key});

  @override
  State<HRTotalPayrollRepotScreen> createState() =>
      _HRTotalPayrollRepotScreenState();
}

class _HRTotalPayrollRepotScreenState extends State<HRTotalPayrollRepotScreen> {
  // Controller
  final TextEditingController monthYearController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  // Store selected month and year
  int? selectedMonth;
  int? selectedYear;
  String searchQuery = ''; //   Added search query state

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

    //   Add search listener
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.trim();
      });
    });

    // //Fetch attendance data once on init
    // Future.microtask(() {
    //   context.totalPayrollProviderRead.fetchTotalPayroll();
    // });
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

      // Trigger rebuild to update the table with filtered data
      setState(() {});
    }
  }

  //   Updated to include search filter
  List<Map<String, String>> getFilteredData(List<Map<String, String>> allData) {
    var filtered = allData;

    // Filter by month/year
    if (selectedMonth != null && selectedYear != null) {
      filtered = filtered.where((row) {
        final dateString = row['Date'] ?? '';
        if (dateString == '-' || dateString.isEmpty) return false;

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

    //   Filter by search query
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

  // Method to get filename with month/year suffix
  String getFilenameSuffix() {
    if (selectedMonth != null && selectedYear != null) {
      return '_${selectedMonth?.toString().padLeft(2, '0')}_$selectedYear';
    }
    return '_all_months';
  }

  @override
  Widget build(BuildContext context) {
    final totoalPayrollProvider = context.totalPayrollProviderWatch;

    final employees = totoalPayrollProvider.totalPayroll?.data ?? [];

    // Table Columns
    final columns = [
      'S.No',
      'Emp ID',
      'Name',
      'Designation',
      'Date of Joining',
      'Total CTC',
      'Latest Payslip Date',
      'Gross',
      'Basic',
      'HRA',
      'Medical Allowance',
      'Other Allowance',
      'HRA Allowance',
      'Basic Pay',
      'Allowance',
      'PF',
      'ESI',
      'Other Tax',
      'Net Pay',
    ];

    final List<Map<String, String>> allData = employees.asMap().entries.map((
      entry,
    ) {
      final i = entry.key + 1;
      final e = entry.value;
      final dateOfJoining = (e.dateOfJoining ?? '').toString().split('T').first;

      //final totalSalary = double.tryParse(e.totalSalary ?? '0') ?? 0;
      //
      // final formattedSalary = NumberFormat(
      //   '#,##,##0.00',
      //   'en_IN',
      // ).format(totalSalary);
      // final totalCTC = double.tryParse(e.totalCtc ?? '0') ?? 0;
      //
      // final formattedTotalCTC = NumberFormat(
      //   '#,##,##0.00',
      //   'en_IN',
      // ).format(totalCTC);
      // final gross = double.tryParse(e.gross.toString() ?? '0') ?? 0;
      //
      // final formattedGross = NumberFormat('#,##,##0.00', 'en_IN').format(gross);
      // // Parse & format all earnings safely
      // String formatEarning(String? value) {
      //   final parsed = double.tryParse(value ?? '0') ?? 0;
      //   return NumberFormat('#,##,##0.00', 'en_IN').format(parsed);
      // }
      final totalSalary = double.tryParse(e.totalSalary ?? '0') ?? 0;
      final formattedSalary = NumberFormat.currency(
        locale: 'en_IN',
        symbol: '₹',
      ).format(totalSalary);

      final totalCTC = double.tryParse(e.totalCtc ?? '0') ?? 0;
      final formattedTotalCTC = NumberFormat.currency(
        locale: 'en_IN',
        symbol: '₹',
      ).format(totalCTC);

      final gross = double.tryParse(e.gross.toString()) ?? 0;
      final formattedGross = NumberFormat.currency(
        locale: 'en_IN',
        symbol: '₹',
      ).format(gross);

      // Helper for all earnings
      String formatEarning(String? value) {
        final parsed = double.tryParse(value ?? '0') ?? 0;
        return NumberFormat.currency(
          locale: 'en_IN',
          symbol: '₹',
        ).format(parsed);
      }

      return {
        'S.No': '$i',
        'Emp ID': e.empId,
        'Name': e.name,
        'Designation': e.designation,
        'Date of Joining': dateOfJoining,
        'Total CTC': formattedTotalCTC,
        'Latest Payslip Date': e.latestPayslipDate,
        'Gross': formattedGross,
        'Basic': formatEarning(e.getEarning('Basic')),
        'HRA': formatEarning(e.getEarning('HRA')),
        'Medical Allowance': formatEarning(e.getEarning('Medical Allowance')),
        'Other Allowance': formatEarning(e.getEarning('Other Allowance')),
        'PF': formatEarning(e.getDeduction('PF')),
        'ESI': formatEarning(e.getDeduction('ESI')),
        'Other Tax': formatEarning(e.getDeduction('Other Tax')),
        'Net Pay': formattedSalary,
      };
    }).toList();

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
      resizeToAvoidBottomInset: true, //   Handle keyboard
      appBar: KAppBar(
        title: "All Employee Payroll Summary",
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
                            final pdfService =
                                getIt<
                                  PdfGeneratorServiceCurrencySymbolSupportWidget
                                >();
                            //   Step 2: Generate and save PDF
                            final generatedFile = await pdfService.generateAndSavePdf(
                              title:
                                  selectedMonth != null && selectedYear != null
                                  ? 'Employee Payroll Report - ${selectedMonth?.toString().padLeft(2, '0')}/$selectedYear'
                                  : 'All Employee Payroll Report',
                              filename:
                                  'employee_payroll_report${getFilenameSuffix()}.pdf',
                              columns: List<String>.from(columns),
                              data: List<Map<String, String>>.from(displayData),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("  PDF generated successfully!"),
                              ),
                            );
                            //   Step 3: Open the generated file
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
                                  filename: 'payroll_report$suffix.xlsx',
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
      body: totoalPayrollProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : totoalPayrollProvider.errorMessage != null
          ? Center(child: Text(totoalPayrollProvider.errorMessage!))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //   Search Field (removed onTap override)
                    KAuthTextFormField(
                      hintText: "Search by Name or Employee ID",
                      suffixIcon: Icons.search,
                      keyboardType: TextInputType.text,
                      controller: searchController,
                    ),

                    //   Show search filter info and clear option
                    if (searchQuery.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
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
                              Icons.search,
                              size: 16.sp,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'Search: "$searchQuery" (${displayData.length} records)',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  searchController.clear();
                                  searchQuery = '';
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

                    // Show selected filter info and clear option
                    if (selectedMonth != null && selectedYear != null)
                      Container(
                        margin: EdgeInsets.only(top: 10.h),
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
                          : KDataTablePayrollScreen(
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

class KDataTablePayrollScreen extends StatelessWidget {
  final List<String> columnTitles;
  final List<Map<String, dynamic>> rowData; // allow String OR Widget

  const KDataTablePayrollScreen({
    super.key,
    required this.columnTitles,
    required this.rowData,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 16,
      horizontalMargin: 12,
      minWidth: 2700,
      headingRowColor: MaterialStateProperty.all(Colors.blueGrey.shade50),
      columns: columnTitles
          .map(
            (title) => DataColumn(
              label: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
          .toList(),
      rows: rowData.map((row) {
        return DataRow(
          cells: columnTitles.map((col) {
            final cellValue = row[col];
            if (cellValue is Widget) {
              return DataCell(cellValue);
            } else {
              return DataCell(Text(cellValue?.toString() ?? '-'));
            }
          }).toList(),
        );
      }).toList(),
    );
  }
}
