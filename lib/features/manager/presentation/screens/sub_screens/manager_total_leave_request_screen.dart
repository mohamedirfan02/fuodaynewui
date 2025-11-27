import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_download_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/pdf_generator_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/manager/presentation/provider/update_leave_status_provider.dart';
import 'package:fuoday/features/manager/presentation/screens/sub_screens/manager_regulation_aproval_screens.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';

class ManagerTotalLeaveRequestScreen extends StatefulWidget {
  const ManagerTotalLeaveRequestScreen({super.key});

  @override
  State<ManagerTotalLeaveRequestScreen> createState() =>
      _ManagerTotalLeaveRequestScreenState();
}

class _ManagerTotalLeaveRequestScreenState
    extends State<ManagerTotalLeaveRequestScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedStatus = "Approved";
  late final updateProvider = getIt<UpdateLeaveStatusProvider>();

  //   Track which leave requests were updated (id → new status)
  final Map<int, String> _updatedStatuses = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.allLeaveRequestProviderRead.fetchAllLeaveRequests("approved");
    });
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
    final isDark = theme.brightness == Brightness.dark;
    final provider = context.allLeaveRequestProviderWatch;

    final columns = ['S.No', 'Name', 'Type', 'From', 'To', 'Reason', 'Status'];
    final employees = provider.leaveRequests?.managerSection?.data ?? [];

    final List<Map<String, dynamic>> tableData = employees.asMap().entries.map((
      entry,
    ) {
      final i = entry.key + 1;
      final e = entry.value;

      final fromDate = (e.from ?? '').toString().split(' ').first;
      final toDate = (e.to ?? '').toString().split(' ').first;

      return {
        'S.No': '$i',
        'id': e.id?.toString() ?? '',
        'Name': e.name?.toString() ?? '',
        'Type': e.type?.toString() ?? '',
        'From': fromDate,
        'To': toDate,
        'Reason': e.reason?.toString() ?? '',
        'Status': e.status ?? 'Pending',
      };
    }).toList();

    // 🔍 Filter by search
    final filteredData = tableData.where((item) {
      final query = searchController.text.toLowerCase();
      return item['Name']!.toString().toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: KAppBar(
        title: "Leave Request Details",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () => GoRouter.of(context).pop(),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: KAuthFilledBtn(
          backgroundColor: theme.primaryColor,
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
                    if (filteredData.isEmpty) {
                      KSnackBar.failure(context, "No Data Found");
                      return;
                    }

                    // Convert data safely for PDF
                    final pdfData = filteredData.map((row) {
                      final newRow = <String, String>{};
                      row.forEach((key, value) {
                        newRow[key] = value is String
                            ? value
                            : value.toString();
                      });
                      return newRow;
                    }).toList();

                    final pdfService = getIt<PdfGeneratorService>();
                    final pdfFile = await pdfService.generateAndSavePdf(
                      data: pdfData,
                      columns: columns,
                      title: selectedStatus != null
                          ? 'Leave Request Report - $selectedStatus'
                          : 'All Leave Request Report',
                      filename:
                          'leave_request_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
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
                    if (filteredData.isEmpty) {
                      KSnackBar.failure(context, "No Data Found");
                      return;
                    }

                    // 🔹 Convert all dynamic values to String before passing to Excel service
                    final excelData = filteredData.map((row) {
                      final newRow = <String, String>{};
                      row.forEach((key, value) {
                        newRow[key] = value is String
                            ? value
                            : value.toString();
                      });
                      return newRow;
                    }).toList();

                    final excelService = getIt<ExcelGeneratorService>();
                    final excelFile = await excelService.generateAndSaveExcel(
                      data: excelData,
                      filename:
                          'leave_request_report_${DateTime.now().millisecondsSinceEpoch}.xlsx',
                      columns: columns,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText(
              text: "Select Status",
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
            KVerticalSpacer(height: 12.h),

            // Dropdown
            KDropdownTextFormField<String>(
              hintText: "Select Status",
              value: selectedStatus,
              items: ["Approved", "Rejected", "Pending"],
              onChanged: (v) {
                if (v != null) {
                  setState(() => selectedStatus = v);
                  context.allLeaveRequestProviderRead.clearData();
                  context.allLeaveRequestProviderRead.fetchAllLeaveRequests(
                    v.toLowerCase(),
                  );
                }
              },
            ),

            KVerticalSpacer(height: 20.h),

            KText(
              text: "$selectedStatus Leaves",
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),

            KVerticalSpacer(height: 12.h),

            // Search bar
            KAuthTextFormField(
              controller: searchController,
              hintText: "Search by Name",
              keyboardType: TextInputType.text,
              suffixIcon: Icons.search,
              onChanged: (value) => setState(() {}),
            ),

            KVerticalSpacer(height: 40.h),

            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (provider.errorMessage != null)
              Center(child: Text(provider.errorMessage!))
            else if (filteredData.isEmpty)
              Center(
                child: Text(
                  "No Data Found",
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              )
            else
              SizedBox(
                height: 400.h,
                child: KDataTable(
                  columnTitles: columns,
                  rowData: filteredData.map((e) {
                    final id = e['id'] ?? 0;
                    final currentStatus =
                        (_updatedStatuses[id] ?? e['Status'] ?? '')
                            .toString()
                            .toLowerCase();

                    //   Dynamic UI Update
                    Widget statusWidget;
                    if (currentStatus == 'pending') {
                      statusWidget = Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? AppColors.checkInColorDark
                                  : AppColors.checkOutColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 3.h,
                              ),
                              minimumSize: Size(40.w, 20.h),
                            ),
                            onPressed: _updatedStatuses.containsKey(id)
                                ? null
                                : () async {
                                    await _updateLeaveStatus(
                                      context,
                                      id,
                                      "Rejected",
                                      e['Name'],
                                    );
                                  },
                            child: Text(
                              "Reject",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: theme
                                    .secondaryHeaderColor, //AppColors.secondaryColor
                              ),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 3.h,
                              ),
                              minimumSize: Size(60.w, 20.h),
                            ),
                            onPressed: _updatedStatuses.containsKey(id)
                                ? null
                                : () async {
                                    await _updateLeaveStatus(
                                      context,
                                      id,
                                      "Approved",
                                      e['Name'],
                                    );
                                  },
                            child: Text(
                              "Approve",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: theme
                                    .secondaryHeaderColor, //AppColors.secondaryColor
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      //   Once updated → show color text only
                      final color = currentStatus == 'approved'
                          ? isDark
                                ? AppColors.checkInColorDark
                                : AppColors.checkInColor
                          : isDark
                          ? AppColors.checkOutColorDark
                          : AppColors.checkOutColor;
                      statusWidget = Text(
                        currentStatus.capitalize(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      );
                    }

                    return {
                      'S.No': e['S.No'],
                      'Name': e['Name'],
                      'Type': e['Type'],
                      'From': e['From'],
                      'To': e['To'],
                      'Reason': e['Reason'],
                      'Status': statusWidget,
                    };
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Update Leave Status Function
  Future<void> _updateLeaveStatus(
    BuildContext context,
    int? id,
    String status,
    String? name,
  ) async {
    if (id == null) return;
    try {
      // Use a dialog context variable to ensure only the dialog is closed
      BuildContext? dialogContext;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          dialogContext = ctx;
          return const Center(child: CircularProgressIndicator());
        },
      );

      await updateProvider.updateLeave(id, status, "Manager");

      //   Close only the loading dialog, not the whole page
      if (dialogContext != null) Navigator.of(dialogContext!).pop();

      if (updateProvider.updatedLeave?.status == "Success") {
        setState(() {
          _updatedStatuses[id] = status;
        });
        KSnackBar.success(context, "$name marked as $status");
      } else {
        KSnackBar.failure(
          context,
          updateProvider.updatedLeave?.message ?? "Update failed",
        );
      }
    } catch (e) {
      //   Close dialog safely if error occurs
      if (Navigator.canPop(context)) Navigator.of(context).pop();
      KSnackBar.failure(context, "Failed to update $name: $e");
    }
  }
}
