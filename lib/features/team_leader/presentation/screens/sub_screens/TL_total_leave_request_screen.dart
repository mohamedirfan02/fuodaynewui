import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_download_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_drop_down_text_form_field.dart';
import 'package:fuoday/commons/widgets/k_pdf_generater_reusable_widget.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/pdf_generator_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';

class TLTotalLeaveRequestScreen extends StatefulWidget {
  const TLTotalLeaveRequestScreen({super.key});

  @override
  State<TLTotalLeaveRequestScreen> createState() =>
      _TLTotalLeaveRequestScreenState();
}

class _TLTotalLeaveRequestScreenState extends State<TLTotalLeaveRequestScreen> {
  final TextEditingController searchController = TextEditingController();

  String selectedStatus = "Approved";

  @override
  void initState() {
    super.initState();
    // Future.microtask(() {
    //   //      Initial API call
    //   context.allLeaveRequestProviderRead.fetchAllLeaveRequests("approved");
    // });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.allLeaveRequestProviderWatch;

    final columns = ['S.No', 'Name', 'Type', 'From', 'To', 'Reason', 'Status'];

    final employees = provider.leaveRequests?.teamSection?.data ?? [];

    final List<Map<String, String>> tableData =
        employees.asMap().entries.map((entry) {
          final i = entry.key + 1;
          final e = entry.value;
          return {
            'S.No': '$i',
            'Name': e.name?.toString() ?? '-',
            'Type': e.type?.toString() ?? '-',
            'From': (e.from ?? '').toString().split(' ').first, //      fixed
            'To': (e.to ?? '').toString().split(' ').first,
            'Reason': e.reason?.toString() ?? '-',
            'Status': e.status?.toString() ?? '-',
          };
        }).toList() ??
        [];
    //      Filter by search
    final filteredData = tableData.where((item) {
      final query = searchController.text.toLowerCase();
      return item['Name']!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: KAppBar(
        title: "Leave Request Details",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () => GoRouter.of(context).pop(),
      ),

      //      Download button
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
            text: "Download",
            onPressed: () async {
              final parentContext = context; //      store parent context

              showModalBottomSheet(
                context: parentContext,
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
                      } else {
                        final pdfService = getIt<PdfGeneratorService>();
                        final pdfFile = await pdfService.generateAndSavePdf(
                          data: filteredData,
                          columns: columns,
                          title: 'Leave Request Report ($selectedStatus)',
                        );
                        GoRouter.of(parentContext).pop();

                        KSnackBar.success(
                          parentContext,
                          "PDF generated successfully!",
                        );

                        await OpenFilex.open(pdfFile.path);
                      }
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
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔽 Dropdown
            KText(
              text: "Select Status",
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
            KVerticalSpacer(height: 12.h),
            KDropdownTextFormField<String>(
              hintText: "Select Status",
              value: selectedStatus,
              items: ["Approved", "Rejected", "Pending"],
              onChanged: (v) {
                if (v != null) {
                  setState(() => selectedStatus = v);
                  //      Clear old data & fetch new API
                  context.allLeaveRequestProviderRead.clearData();
                  context.allLeaveRequestProviderRead.fetchAllLeaveRequests(
                    v.toLowerCase(),
                  );
                }
              },
            ),

            KVerticalSpacer(height: 20.h),

            // 🔽 Dynamic title
            KText(
              text: "$selectedStatus Leaves",
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
            KVerticalSpacer(height: 12.h),

            // 🔽 Search field
            KAuthTextFormField(
              controller: searchController,
              hintText: "Search by Name",
              keyboardType: TextInputType.text,
              suffixIcon: Icons.search,
              onChanged: (_) => setState(() {}),
            ),
            KVerticalSpacer(height: 30.h),

            // 🔽 Data rendering
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (provider.errorMessage != null)
              Center(child: Text(provider.errorMessage!))
            else if (filteredData.isEmpty)
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
