import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/service/pdf_generator_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:fuoday/core/di/injection.dart';

class TLRegulationAprovalScreen extends StatefulWidget {
  const TLRegulationAprovalScreen({super.key});

  @override
  State<TLRegulationAprovalScreen> createState() =>
      _TLRegulationAprovalScreenState();
}

class _TLRegulationAprovalScreenState extends State<TLRegulationAprovalScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedType = "Leave";
  String selectedStatus = "Approved";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final List<Map<String, String>> dummydata = [
      {
        'S.No': '1',
        'Employee ID': 'EMP001',
        'Name': 'John Doe',
        'Attendance Date': '2025-10-10',
        'Check In': '09:00 AM',
        'Check Out': '05:00 PM',
        'Regulation Date': '2025-10-11',
        'Status': 'Approved',
        'Reason': 'Family function',
      },
      {
        'S.No': '2',
        'Employee ID': 'EMP002',
        'Name': 'Jane Smith',
        'Attendance Date': '2025-09-05',
        'Check In': '10:00 AM',
        'Check Out': '04:00 PM',
        'Regulation Date': '2025-09-06',
        'Status': 'Pending',
        'Reason': 'Fever and cold',
      },
      {
        'S.No': '3',
        'Employee ID': 'EMP003',
        'Name': 'Michael Johnson',
        'Attendance Date': '2025-10-01',
        'Check In': '08:30 AM',
        'Check Out': '05:15 PM',
        'Regulation Date': '2025-10-02',
        'Status': 'Approved',
        'Reason': 'System issue at office',
      },
      {
        'S.No': '4',
        'Employee ID': 'EMP004',
        'Name': 'Sarah Williams',
        'Attendance Date': '2025-08-22',
        'Check In': '09:10 AM',
        'Check Out': '05:30 PM',
        'Regulation Date': '2025-08-23',
        'Status': 'Rejected',
        'Reason': 'Medical emergency',
      },
      {
        'S.No': '5',
        'Employee ID': 'EMP005',
        'Name': 'David Brown',
        'Attendance Date': '2025-09-15',
        'Check In': '09:20 AM',
        'Check Out': '05:00 PM',
        'Regulation Date': '2025-09-16',
        'Status': 'Pending',
        'Reason': 'Personal work',
      },
      {
        'S.No': '6',
        'Employee ID': 'EMP006',
        'Name': 'Emily Davis',
        'Attendance Date': '2025-09-18',
        'Check In': '09:15 AM',
        'Check Out': '05:10 PM',
        'Regulation Date': '2025-09-19',
        'Status': 'Rejected',
        'Reason': 'Travel issues',
      },
      {
        'S.No': '7',
        'Employee ID': 'EMP007',
        'Name': 'James Wilson',
        'Attendance Date': '2025-08-10',
        'Check In': '09:05 AM',
        'Check Out': '05:25 PM',
        'Regulation Date': '2025-08-11',
        'Status': 'Approved',
        'Reason': 'Project meeting',
      },
      {
        'S.No': '8',
        'Employee ID': 'EMP008',
        'Name': 'Lisa Anderson',
        'Attendance Date': '2025-09-10',
        'Check In': '09:00 AM',
        'Check Out': '05:00 PM',
        'Regulation Date': '2025-09-11',
        'Status': 'Pending',
        'Reason': 'Bad weather',
      },
      {
        'S.No': '8',
        'Employee ID': 'EMP008',
        'Name': 'Lisa Anderson',
        'Attendance Date': '2025-09-10',
        'Check In': '09:00 AM',
        'Check Out': '05:00 PM',
        'Regulation Date': '2025-09-11',
        'Status': 'Pending',
        'Reason': 'Bad weather',
      },
    ];

    final columns = [
      'S.No',
      'Employee ID',
      'Name',
      'Attendance Date',
      'Check In',
      'Check Out',
      'Regulation Date',
      'Status',
      'Reason',
    ];

    // 🔹 Count each status
    final approvedCount = dummydata
        .where((item) => item['Status'] == 'Approved')
        .length;
    final pendingCount = dummydata
        .where((item) => item['Status'] == 'Pending')
        .length;
    final rejectedCount = dummydata
        .where((item) => item['Status'] == 'Rejected')
        .length;

    // 🔹 Show counts in dropdown labels
    final statusItems = [
      'Approved ($approvedCount)',
      'Pending ($pendingCount)',
      'Rejected ($rejectedCount)',
    ];

    // ✅ Extract only status without count
    String getStatusFromDropdown(String value) {
      return value.split(' ').first; // e.g. "Approved (3)" → "Approved"
    }

    // 🔹 Filter by selected type and status
    final filteredByStatus = dummydata
        .where(
          (item) => item['Status'] == getStatusFromDropdown(selectedStatus),
        )
        .toList();

    final filteredData = filteredByStatus.where((item) {
      final query = searchController.text.toLowerCase();
      final empId = item['Employee ID']?.toLowerCase() ?? '';
      final name = item['Name']?.toLowerCase() ?? '';
      return empId.contains(query) || name.contains(query);
    }).toList();

    return Scaffold(
      appBar: KAppBar(
        title: "Regulation Approval",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () => GoRouter.of(context).pop(),
      ),
      bottomNavigationBar: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: KAuthFilledBtn(
          backgroundColor: AppColors.primaryColor,
          height: 24.h,
          width: double.infinity,
          text: "Download",
          onPressed: () async {
            if (filteredData.isEmpty) {
              KSnackBar.failure(context, "No Data Found");
            } else {
              final pdfService = getIt<PdfGeneratorService>();
              final pdfFile = await pdfService.generateAndSavePdf(
                data: filteredData,
                columns: columns,
                title: 'Regulation Report',
              );
              await OpenFilex.open(pdfFile.path);
            }
          },
          fontSize: 11.sp,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Dropdown: Attendance / Leave
            KDropdownTextFormField<String>(
              hintText: "Select Type",
              value: selectedType,
              items: ["Attendance", "Leave"],
              onChanged: (v) {
                setState(() {
                  selectedType = v ?? "Leave";
                });
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Please select type";
                }
                return null;
              },
            ),

            KVerticalSpacer(height: 16.h),

            // 🔹 Dropdown: Status + Counts
            KDropdownTextFormField<String>(
              hintText: "Select Status",
              value: statusItems.firstWhere(
                (item) => item.startsWith(selectedStatus),
                orElse: () => statusItems.first,
              ),
              items: statusItems,
              onChanged: (v) {
                setState(() {
                  selectedStatus = v ?? statusItems.first;
                });
              },
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Please select status";
                }
                return null;
              },
            ),

            KVerticalSpacer(height: 20.h),

            // 🔹 Dynamic title based on selection
            KText(
              text: "${getStatusFromDropdown(selectedStatus)} ${selectedType}s",
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),

            KVerticalSpacer(height: 12.h),

            // 🔹 Search field
            KAuthTextFormField(
              controller: searchController,
              hintText: "Search by Name or Employee ID",
              suffixIcon: Icons.search,
              onChanged: (v) => setState(() {}),
            ),

            KVerticalSpacer(height: 30.h),

            // 🔹 Filtered Table
            if (filteredData.isEmpty)
              const Center(child: Text("No Data Found"))
            else
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: KDataTable(columnTitles: columns, rowData: filteredData),
              ),
          ],
        ),
      ),
    );
  }
}
