import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/pdf_generator_service.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/manager/presentation/provider/all_regulations_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:data_table_2/data_table_2.dart';

class TLRegulationAprovalScreen extends StatefulWidget {
  const TLRegulationAprovalScreen({super.key});

  @override
  State<TLRegulationAprovalScreen> createState() =>
      _TLRegulationAprovalScreenState();
}

class _TLRegulationAprovalScreenState extends State<TLRegulationAprovalScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedStatus = "Pending";
  String selectedType = "Leave";
  String searchQuery = '';

  late final provider = getIt<AllRegulationsProvider>();

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

    //  => Fetch regulations once on init
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

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final providerWatch = context.allRegulationsProviderWatch;

    final filteredList = providerWatch.getFilteredData(
      selectedType: selectedType,
      selectedStatus: selectedStatus,
      section: 'team',
      searchQuery: searchQuery,
    );

    // 🔹 Dynamic columns (no Action)
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
          ];

    // 🔹 Build table data (no action widgets)
    final tableData = filteredList.asMap().entries.map((entry) {
      final i = entry.key + 1;
      final e = entry.value;

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
      };
    }).toList();

    return Scaffold(
      //   1: Add resizeToAvoidBottomInset to handle keyboard
      resizeToAvoidBottomInset: true,
      appBar: KAppBar(
        title: "Regulation Approval",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () => GoRouter.of(context).pop(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        //   2: Wrap Column with SingleChildScrollView
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

              ///  => Search Field
              KAuthTextFormField(
                controller: searchController,
                hintText: "Search by Name or Employee ID",
                keyboardType: TextInputType.text,
                suffixIcon: Icons.search,
              ),

              //  => Search result count
              if (searchQuery.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Row(
                    children: [
                      Text(
                        'Found ${filteredList.length} result(s) for "$searchQuery"',
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

              KVerticalSpacer(height: 20.h),

              ///   Changed Expanded to SizedBox with fixed height for table
              SizedBox(
                height:
                    MediaQuery.of(context).size.height *
                    0.4, // 40% of screen height
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
                          mainAxisSize:
                              MainAxisSize.min, //   4: Added mainAxisSize
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

              //   5: Added spacing at bottom to prevent keyboard overlap
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: KAuthFilledBtn(
          backgroundColor: theme.primaryColor,
          height: AppResponsive.responsiveBtnHeight(context),
          width: double.infinity,
          text: "Download Report",
          fontSize: 12.sp,
          onPressed: () async {
            if (filteredList.isEmpty) {
              KSnackBar.failure(context, "No Data Found");
              return;
            }

            final pdfData = tableData.map((row) {
              final data = <String, String>{};
              row.forEach((key, value) {
                data[key] = value.toString();
              });
              return data;
            }).toList();

            final pdfService = getIt<PdfGeneratorService>();
            final pdfFile = await pdfService.generateAndSavePdf(
              data: pdfData,
              columns: columns,
              title:
                  '${selectedType.toUpperCase()} Regulation Report ($selectedStatus)',
            );
            await OpenFilex.open(pdfFile.path);
          },
        ),
      ),
    );
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
