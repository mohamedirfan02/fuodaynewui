import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_download_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/team_leader/presentation/provider/role_based_users_provider.dart';
import 'package:fuoday/features/team_leader/presentation/widget/total_employee_pdf_generater.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provider/provider.dart';

class ManagerTotalEmployeesScreen extends StatefulWidget {
  const ManagerTotalEmployeesScreen({super.key});

  @override
  State<ManagerTotalEmployeesScreen> createState() =>
      _ManagerTotalEmployeesScreenState();
}

class _ManagerTotalEmployeesScreenState
    extends State<ManagerTotalEmployeesScreen> {
  // Controllers
  final TextEditingController searchController = TextEditingController();
  final TextEditingController empNameController = TextEditingController();
  final TextEditingController empIDController = TextEditingController();

  // Service
  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;
  late final String name;
  late final int webUserId;

  // Filter state
  String searchQuery = '';
  String empNameFilter = '';
  String empIDFilter = '';

  @override
  void initState() {
    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    name = employeeDetails?['name'] ?? "No Name";
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    // Future.microtask(() {
    //   context.read<RoleBasedUsersProvider>().fetchRoleBasedUsers(webUserId);
    // });

    // Add listeners for real-time filtering
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });

    empNameController.addListener(() {
      setState(() {
        empNameFilter = empNameController.text.toLowerCase();
      });
    });

    empIDController.addListener(() {
      setState(() {
        empIDFilter = empIDController.text.toLowerCase();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    empNameController.dispose();
    empIDController.dispose();
    super.dispose();
  }

  // Filter function
  List<Map<String, String>> _filterData(List<Map<String, String>> data) {
    return data.where((row) {
      // Search filter (searches across all fields)
      if (searchQuery.isNotEmpty) {
        bool matchesSearch = row.values.any(
          (value) => value.toLowerCase().contains(searchQuery),
        );
        if (!matchesSearch) return false;
      }

      // Employee Name filter
      if (empNameFilter.isNotEmpty) {
        String name = row['Name']?.toLowerCase() ?? '';
        if (!name.contains(empNameFilter)) return false;
      }

      // Employee ID filter
      if (empIDFilter.isNotEmpty) {
        String empId = row['Employee Id']?.toLowerCase() ?? '';
        if (!empId.contains(empIDFilter)) return false;
      }

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Providers
    final provider = context.watch<RoleBasedUsersProvider>();
    //final employees = provider.roleBasedUsers?.hr ?? [];

    final columns = ['S.No', 'Employee Id', 'Name', 'Email', 'Role'];

    // Original data (before filtering)
    // ✅ Get list and count safely
    final employees = provider.roleBasedUsers?.manager.data ?? [];

    // ✅ Convert to table-friendly map list
    final List<Map<String, String>> originalData = employees
        .asMap()
        .entries
        .map((entry) {
          final i = entry.key + 1;
          final e = entry.value;

          return {
            'S.No': '$i',
            'Employee Id': e.empId?.toString() ?? '',
            'Name': e.empName?.toString() ?? '',
            'Email': e.email?.toString() ?? '',
            'Role': e.role.isNotEmpty
                ? e.role[0].toUpperCase() + e.role.substring(1).toLowerCase()
                : '-',
          };
        })
        .toList();

    // Apply filters
    final List<Map<String, String>> filteredData = _filterData(originalData);
    //App Theme Data
    final theme = Theme.of(context);
    return Scaffold(
      appBar: KAppBar(
        title: "Total Employees",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () {
          GoRouter.of(context).pop();
        },
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
                      // Use filtered data for download
                      final dataToDownload = filteredData;

                      if (dataToDownload.isEmpty) {
                        Navigator.pop(context); // Close bottom sheet
                        KSnackBar.failure(context, "No Data Found");
                        return;
                      }

                      try {
                        // Pdf service
                        final pdfService = getIt<TotalEmpPdfGeneratorService>();

                        // Ensure data is in correct format
                        final formattedData = dataToDownload.map((row) {
                          return {
                            'S.No': row['S.No'] ?? '-',
                            'Employee Id': row['Employee Id'] ?? '-',
                            'Name': row['Name'] ?? '-',
                            'Email': row['Email'] ?? '-',
                            'Role': row['Role'] ?? '-',
                          };
                        }).toList();

                        // Generating PDF
                        final pdfFile = await pdfService.generateAndSavePdf(
                          data: formattedData,
                          columns: columns,
                          title: 'Total Employees Report',
                        );

                        Navigator.pop(context); // Close bottom sheet

                        // Show success message
                        KSnackBar.success(
                          context,
                          "PDF Generated Successfully",
                        );

                        // Open the PDF File
                        await OpenFilex.open(pdfFile.path);
                      } catch (e) {
                        Navigator.pop(context); // Close bottom sheet
                        KSnackBar.failure(
                          context,
                          "Error generating PDF: ${e.toString()}",
                        );
                      }
                    },
                    onExcelTap: () async {
                      // Use filtered data for download
                      final dataToDownload = filteredData;

                      if (dataToDownload.isEmpty) {
                        Navigator.pop(context); // Close bottom sheet
                        KSnackBar.failure(context, "No Data Found");
                        return;
                      }

                      try {
                        // Excel Service
                        final excelService = getIt<ExcelGeneratorService>();

                        // Ensure data is in correct format
                        final formattedData = dataToDownload.map((row) {
                          return {
                            'S.No': row['S.No'] ?? '-',
                            'Employee Id': row['Employee Id'] ?? '-',
                            'Name': row['Name'] ?? '-',
                            'Email': row['Email'] ?? '-',
                            'Role': row['Role'] ?? '-',
                          };
                        }).toList();

                        // Generate Excel
                        final excelFile = await excelService
                            .generateAndSaveExcel(
                              data: formattedData,
                              filename: 'Total Employees Report.xlsx',
                              columns: columns,
                            );

                        Navigator.pop(context); // Close bottom sheet

                        // Show success message
                        KSnackBar.success(
                          context,
                          "Excel Generated Successfully",
                        );

                        // Open the Excel File
                        await OpenFilex.open(excelFile.path);
                      } catch (e) {
                        Navigator.pop(context); // Close bottom sheet
                        KSnackBar.failure(
                          context,
                          "Error generating Excel: ${e.toString()}",
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
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    KText(
                      text: "Search",
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                    KVerticalSpacer(height: 12.h),

                    // Search Text Form Field
                    KAuthTextFormField(
                      controller: searchController,
                      hintText: "Search by any field",
                      keyboardType: TextInputType.text,
                      suffixIcon: Icons.search,
                    ),

                    KVerticalSpacer(height: 12.h),

                    // Filter by text
                    KText(
                      text: "Filter by",
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),

                    KVerticalSpacer(height: 12.h),

                    // Start End Date TextFormField
                    Row(
                      spacing: 20.w,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Employee Name Filter
                        Expanded(
                          child: KAuthTextFormField(
                            controller: empNameController,
                            hintText: "Emp_Name",
                            keyboardType: TextInputType.text,
                            suffixIcon: Icons.filter_alt_outlined,
                          ),
                        ),

                        // Employee ID Filter
                        Expanded(
                          child: KAuthTextFormField(
                            controller: empIDController,
                            hintText: "Emp_ID",
                            keyboardType: TextInputType.text,
                            suffixIcon: Icons.filter_alt_outlined,
                          ),
                        ),
                      ],
                    ),

                    // Clear filters button
                    if (searchQuery.isNotEmpty ||
                        empNameFilter.isNotEmpty ||
                        empIDFilter.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                              empNameController.clear();
                              empIDController.clear();
                              searchQuery = '';
                              empNameFilter = '';
                              empIDFilter = '';
                            });
                          },
                          icon: const Icon(Icons.clear),
                          label: const Text("Clear Filters"),
                        ),
                      ),

                    KVerticalSpacer(height: 20.h),

                    // Results count
                    KText(
                      text:
                          "Showing ${filteredData.length} of ${originalData.length} employees",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: theme
                          .textTheme
                          .bodyLarge
                          ?.color, //AppColors.greyColor,
                    ),

                    KVerticalSpacer(height: 20.h),

                    // Table
                    if (filteredData.isEmpty)
                      Center(
                        child: KText(
                          text: "Data List is Empty",
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      )
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
