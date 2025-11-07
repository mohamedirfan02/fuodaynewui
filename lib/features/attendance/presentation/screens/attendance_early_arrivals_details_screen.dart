import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_download_options_bottom_sheet.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/excel_generator_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/pdf_generator_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/attendance/presentation/widgets/attendance_message_content.dart';
import 'package:fuoday/features/attendance/presentation/widgets/attendance_punctual_arrival_card.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:provider/provider.dart';

import '../providers/total_early_arrivals_details_provider.dart';

class AttendanceEarlyArrivalsDetailsScreen extends StatefulWidget {
  const AttendanceEarlyArrivalsDetailsScreen({super.key});

  @override
  State<AttendanceEarlyArrivalsDetailsScreen> createState() =>
      _AttendanceEarlyArrivalsDetailsScreenState();
}

class _AttendanceEarlyArrivalsDetailsScreenState
    extends State<AttendanceEarlyArrivalsDetailsScreen> {
  // Controllers
  final TextEditingController searchController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  // Service
  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;
  late final String name;
  late final int webUserId;

  @override
  void initState() {
    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    name = employeeDetails?['name'] ?? "No Name";
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    Future.microtask(() {
      context.totalEarlyArrivalsDetailsProviderRead
          .fetchTotalEarlyArrivalsDetails(webUserId);
    });

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);
    // Providers
    //final provider = context.totalEarlyArrivalsDetailsProviderWatch;
    final provider = context.watch<TotalEarlyArrivalsDetailsProvider>();
    final details = provider.earlyArrivalsDetails;

    // Your card data list
    final List<Map<String, String>> punctualData = [
      {
        'count': '${details?.data?.earlyArrivalsDetails?.length ?? 0}',
        'label': 'Total Early Days',
      },
      {
        'count': '${details?.data?.totalEarlyMinutes ?? "No Early Time"}',
        'label': 'Total Early Minutes',
      },
      {
        'count': '${details?.data?.averageEarlyMinutes ?? "No Early Time"}',
        'label': 'Average Early Minutes',
      },
      {
        'count': '${details?.data?.earlyArrivalPercentage ?? 0}%',
        'label': 'Early Percentage',
      },
    ];

    // Select Date
    Future<void> selectDate(
      BuildContext context,
      TextEditingController controller,
    ) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        initialDatePickerMode: DatePickerMode.day,
        helpText: 'Select Date',
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: AppColors.secondaryColor,
                onSurface: AppColors.titleColor,
              ),
            ),
            child: child!,
          );
        },
      );

      if (picked != null) {
        controller.text = "${picked.day}/${picked.month}/${picked.year}";
      }
    }

    // Dummy Data
    final columns = [
      'S.No',
      'Date',
      'Day',
      'Log on',
      'Log off',
      'Worked hours',
      'Status',
    ];

    final List<Map<String, String>> data =
        (details?.data?.earlyArrivalsDetails ?? []).asMap().entries.map((
          entry,
        ) {
          final index = entry.key + 1;
          final detail = entry.value;

          final dateObj = DateTime.tryParse(detail.date ?? '');
          final dayName = dateObj != null
              ? [
                  "Sunday",
                  "Monday",
                  "Tuesday",
                  "Wednesday",
                  "Thursday",
                  "Friday",
                  "Saturday",
                ][dateObj.weekday % 7]
              : "-";

          return {
            'S.No': '$index',
            'Date': detail.date ?? '-',
            'Day': dayName,
            'Log on': detail.checkinTime ?? '-',
            'Log off': '-',
            'Worked hours': detail.hoursMinutesEarly ?? '-',
            'Status': detail.currentStatus ?? '-',
          };
        }).toList();

    return Scaffold(
      appBar: KAppBar(
        title: "Early Arrival Details",
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
            backgroundColor: AppColors.primaryColor,
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
                      if (data.isEmpty) {
                        KSnackBar.failure(context, "No Data Found");
                      } else {
                        // Pdf service
                        final pdfService = getIt<PdfGeneratorService>();

                        // Generating
                        final pdfFile = await pdfService.generateAndSavePdf(
                          data: data,
                          columns: columns, // 👈 pass the fixed column order
                          title: 'Total Attendance Report',
                        );

                        // Open a PDF File
                        await OpenFilex.open(pdfFile.path);
                      }
                    },
                    onExcelTap: () async {
                      if (data.isEmpty) {
                        KSnackBar.failure(context, "No Data Found");
                      } else {
                        // Excel Service
                        final excelService = getIt<ExcelGeneratorService>();

                        // Implement Excel logic
                        final excelFile = await excelService
                            .generateAndSaveExcel(
                              data: data,
                              filename: 'Total Attendance Report.xlsx',
                              columns: [],
                            );

                        // Open a Excel File
                        await OpenFilex.open(excelFile.path);
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Cards
              provider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // use parent scroll
                      itemCount: punctualData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 cards per row
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: isTablet
                            ? (isLandscape ? 4.8 : 2.5)
                            : 1.2, // adjust for card height/width
                      ),
                      itemBuilder: (context, index) {
                        final item = punctualData[index];
                        return AttendancePunctualArrivalCard(
                          punctualCountOrPercentageText: item['count']!,
                          punctualCountOrPercentageDescriptionText:
                              item['label']!,
                        );
                      },
                    ),

              KVerticalSpacer(height: 10.h),
              // Filter & Search Options
              KText(
                text: "Filter & Search Options",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),

              KVerticalSpacer(height: 12.h),

              // Search Text Form Field
              KAuthTextFormField(
                hintText: "Search by data",
                keyboardType: TextInputType.text,
                suffixIcon: Icons.search,
              ),

              KVerticalSpacer(height: 12.h),

              // Start End Date TextFormField
              Row(
                spacing: 20.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Start Date
                  Expanded(
                    child: KAuthTextFormField(
                      onTap: () {
                        selectDate(context, startDateController);
                      },
                      controller: startDateController,
                      hintText: "Start Date",
                      keyboardType: TextInputType.datetime,
                      suffixIcon: Icons.date_range,
                    ),
                  ),

                  // End Date
                  Expanded(
                    child: KAuthTextFormField(
                      onTap: () async {
                        selectDate(context, endDateController);
                      },
                      controller: endDateController,
                      hintText: "End Date",
                      keyboardType: TextInputType.datetime,
                      suffixIcon: Icons.date_range,
                    ),
                  ),
                ],
              ),

              KVerticalSpacer(height: 40.h),

              // Table
              if (data.isEmpty)
                const Center(child: Text("No Data Found"))
              else
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height *
                      0.5, // take half of screen
                  child: KDataTable(columnTitles: columns, rowData: data),
                ),

              // Message Content
              AttendanceMessageContent(
                messageContentTitle: "Performance: High",
                messageContentSubTitle:
                    "You arrive mostly on time, consider arriving a few minutes early to be better prepared",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
