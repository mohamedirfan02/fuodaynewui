import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_download_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_pdf_generater_reusable_widget.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/manager/presentation/provider/update_regulation_status_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:provider/provider.dart';

class ManagerRegulationAprovalScreen extends StatefulWidget {
  const ManagerRegulationAprovalScreen({super.key});

  @override
  State<ManagerRegulationAprovalScreen> createState() =>
      _ManagerRegulationAprovalScreenState();
}

class _ManagerRegulationAprovalScreenState
    extends State<ManagerRegulationAprovalScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedStatus = "Pending";
  String selectedType = "Leave";
  String searchQuery = '';

  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;
  late final String name;
  late final int webUserId;

  //   Track updated statuses locally
  final Map<int, String> _updatedStatuses = {};

  @override
  void initState() {
    super.initState();

    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    name = employeeDetails?['name'] ?? "No Name";
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    // Future.microtask(() {
    //   context.allRegulationsProviderRead.fetchAllRegulations(webUserId);
    // });

    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.trim();
      });
    });
  }

  @override
  void dispose() {
    searchController.removeListener(() {});
    searchController.dispose();
    super.dispose();
  }

  //   Updated method to handle approval/rejection
  Future<void> _updateRegulationStatus(
    int regulationId,
    String newStatus,
    String empName,
  ) async {
    final updateProvider = context.read<UpdateRegulationStatusProvider>();

    try {
      // Show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final module = selectedType.toLowerCase();

      await updateProvider.updateRegulation(
        regulationId,
        newStatus.capitalize(),
        'Manager',
        module,
      );

      if (mounted) Navigator.of(context).pop();

      //   If success, disable buttons and show updated status
      if (updateProvider.updatedRegulation?.status == "Success") {
        setState(() {
          _updatedStatuses[regulationId] = newStatus.capitalize();
        });

        KSnackBar.success(
          context,
          "${empName} marked as ${newStatus.capitalize()}",
        );
      } else {
        KSnackBar.failure(
          context,
          updateProvider.updatedRegulation?.message ??
              "Failed to update regulation status",
        );
      }
    } catch (e) {
      if (mounted) Navigator.of(context).pop();
      KSnackBar.failure(context, "Error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.allRegulationsProviderWatch;

    final filteredList = providerWatch.getFilteredData(
      section: 'manager',
      selectedType: selectedType,
      selectedStatus: selectedStatus,
      searchQuery: searchQuery,
    );

    final columns = selectedType.toLowerCase() == 'attendance'
        ? [
            'S.No',
            'Employee ID',
            'Name',
            'Attendance Date',
            'Check In',
            'Check Out',
            'Regulation Date',
            'Status',
            'Reason',
            'Action',
          ]
        : [
            'S.No',
            'Employee ID',
            'Name',
            'Leave Type',
            'Start Date',
            'End Date',
            'Regulation Date',
            'Status',
            'Reason',
            'Action',
          ];

    final tableData = filteredList.asMap().entries.map((entry) {
      final i = entry.key + 1;
      final e = entry.value;

      //   Get locally updated status (if any)
      final localStatus = _updatedStatuses[e.id];
      final currentStatus = (localStatus ?? e.regulationStatus ?? '')
          .toLowerCase();

      Widget actionWidget;

      if (currentStatus == 'pending') {
        actionWidget = Row(
          children: [
            SizedBox(
              height: 20.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                ),
                onPressed: _updatedStatuses.containsKey(e.id)
                    ? null
                    : () async {
                        await _updateRegulationStatus(
                          e.id ?? 0,
                          'rejected',
                          e.empName ?? 'Employee',
                        );
                      },
                child: Text(
                  "Reject",
                  style: TextStyle(fontSize: 10.sp, color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 6.w),
            SizedBox(
              height: 20.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                ),
                onPressed: _updatedStatuses.containsKey(e.id)
                    ? null
                    : () async {
                        await _updateRegulationStatus(
                          e.id ?? 0,
                          'approved',
                          e.empName ?? 'Employee',
                        );
                      },
                child: Text(
                  "Approve",
                  style: TextStyle(fontSize: 10.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      } else {
        final color = currentStatus == 'approved' ? Colors.green : Colors.red;
        actionWidget = Text(
          currentStatus.capitalize(),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        );
      }

      return {
        'S.No': '$i',
        'Employee ID': e.empId?.toString() ?? '-',
        'Name': e.empName?.toString() ?? '-',
        'Leave Type': e.displayType?.toString() ?? '-',
        'Attendance Date': e.date?.toIso8601String().split("T").first ?? '-',
        'Check In': e.checkin?.toString() ?? '-',
        'Check Out': e.checkout?.toString() ?? '-',
        'Start Date': e.from?.toString() ?? '-',
        'End Date': e.to?.toString() ?? '-',
        'Regulation Date':
            e.regulationDate?.toIso8601String().split("T").first ?? '-',
        'Status': e.regulationStatus?.toString() ?? '-',
        'Reason': e.reason?.toString() ?? '-',
        'Action': actionWidget,
      };
    }).toList();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: KAppBar(
        title: "Regulation Approval Request",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () => GoRouter.of(context).pop(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: "Select Type",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              KVerticalSpacer(height: 8.h),
              KDropdownTextFormField<String>(
                hintText: "Select Type",
                value: selectedType,
                items: ["Leave", "Attendance"],
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      selectedType = v;
                      searchController.clear();
                      searchQuery = '';
                    });
                  }
                },
              ),
              KVerticalSpacer(height: 16.h),
              KText(
                text: "Select Status",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              KVerticalSpacer(height: 8.h),
              KDropdownTextFormField<String>(
                hintText: "Select Status",
                value: selectedStatus,
                items: ["Pending", "Approved", "Rejected"],
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      selectedStatus = v;
                      searchController.clear();
                      searchQuery = '';
                    });
                  }
                },
              ),
              KVerticalSpacer(height: 16.h),

              /// Search Field
              KAuthTextFormField(
                controller: searchController,
                hintText: "Search by Name or Employee ID",
                keyboardType: TextInputType.text,
                suffixIcon: Icons.search,
              ),
              if (searchQuery.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 8.h),
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
                          'Search: "$searchQuery" (${filteredList.length} records)',
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

              KVerticalSpacer(height: 20.h),

              /// Table section
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: providerWatch.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : providerWatch.errorMessage != null
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Text(
                            providerWatch.errorMessage!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : filteredList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 48.sp,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              searchQuery.isNotEmpty
                                  ? "No results found for '$searchQuery'"
                                  : "No Data Found",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : KDataTableRehulationScreen(
                        columnTitles: columns,
                        rowData: tableData,
                      ),
              ),
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),

      /// Download Button
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: KAuthFilledBtn(
          backgroundColor: AppColors.primaryColor,
          height: AppResponsive.responsiveBtnHeight(context),
          width: double.infinity,
          text: "Download",
          fontSize: 12.sp,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              builder: (context) {
                return KDownloadOptionsBottomSheet(
                  onPdfTap: () async {
                    if (filteredList.isEmpty) {
                      KSnackBar.failure(context, "No Data Found");
                      return;
                    }

                    // Convert data for PDF (excluding "Action" column)
                    final pdfData = tableData.map((row) {
                      final data = <String, String>{};
                      row.forEach((key, value) {
                        if (key != 'Action') data[key] = value.toString();
                      });
                      return data;
                    }).toList();

                    // Use PdfGeneratorServiceReusableWidget instead of PdfGeneratorService
                    final pdfService =
                        getIt<PdfGeneratorServiceReusableWidget>();

                    final pdfFile = await pdfService.generateAndSavePdf(
                      title:
                          '${selectedType.toUpperCase()} Request Report ($selectedStatus)',
                      filename:
                          '${selectedType.toLowerCase()}_request_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
                      columns: columns.where((e) => e != 'Action').toList(),
                      data: pdfData,
                      adjustColumnWidth: false,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("  PDF generated successfully!"),
                      ),
                    );

                    GoRouter.of(context).pop();
                    await OpenFilex.open(pdfFile.path);
                  },
                  onExcelTap: () async {
                    if (filteredList.isEmpty) {
                      KSnackBar.failure(context, "No Data Found");
                      return;
                    }

                    // Convert data for Excel (excluding "Action" column)
                    final excelData = tableData.map((row) {
                      final data = <String, String>{};
                      row.forEach((key, value) {
                        if (key != 'Action') data[key] = value.toString();
                      });
                      return data;
                    }).toList();

                    final excelService = getIt<ExcelGeneratorService>();

                    final excelFile = await excelService.generateAndSaveExcel(
                      data: excelData,
                      filename:
                          '${selectedType.toLowerCase()}_request_report_${DateTime.now().millisecondsSinceEpoch}.xlsx',
                      columns: columns.where((e) => e != 'Action').toList(),
                    );

                    GoRouter.of(context).pop();
                    await OpenFilex.open(excelFile.path);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

//   Helper extension for capitalizing
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class KDataTableRehulationScreen extends StatelessWidget {
  final List<String> columnTitles;
  final List<Map<String, dynamic>> rowData;

  const KDataTableRehulationScreen({
    super.key,
    required this.columnTitles,
    required this.rowData,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 16,
      horizontalMargin: 12,
      minWidth: 1500,
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
