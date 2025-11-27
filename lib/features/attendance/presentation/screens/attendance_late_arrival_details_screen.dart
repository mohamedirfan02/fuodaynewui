import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_download_options_bottom_sheet.dart';
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

class AttendanceLateArrivalDetailsScreen extends StatefulWidget {
  const AttendanceLateArrivalDetailsScreen({super.key});

  @override
  State<AttendanceLateArrivalDetailsScreen> createState() =>
      _AttendanceLateArrivalDetailsScreenState();
}

class _AttendanceLateArrivalDetailsScreenState
    extends State<AttendanceLateArrivalDetailsScreen> {
  // Controllers
  final TextEditingController searchController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  // Filter variables
  DateTime? startDate;
  DateTime? endDate;
  String searchQuery = '';

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

    // Add listeners for real-time filtering
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text.toLowerCase();
      });
    });

    Future.microtask(() {
      context.totalLateArrivalsDetailsProviderRead.fetchLateArrivalDetails(
        webUserId,
      );
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

  // Method to filter data based on search and date range
  List<Map<String, String>> getFilteredData(List<Map<String, String>> allData) {
    List<Map<String, String>> filtered = List.from(allData);

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((row) {
        return row.values.any(
          (value) => value.toLowerCase().contains(searchQuery),
        );
      }).toList();
    }

    // Apply date range filter
    if (startDate != null || endDate != null) {
      filtered = filtered.where((row) {
        final dateString = row['Date'] ?? '';
        if (dateString == '-' || dateString.isEmpty) return false;

        try {
          final recordDate = DateTime.tryParse(dateString);
          if (recordDate == null) return false;

          // Check if date is within range
          if (startDate != null && recordDate.isBefore(startDate!)) {
            return false;
          }
          if (endDate != null && recordDate.isAfter(endDate!)) {
            return false;
          }
          return true;
        } catch (e) {
          return false;
        }
      }).toList();
    }

    return filtered;
  }

  // Method to re-index filtered data
  List<Map<String, String>> reindexData(List<Map<String, String>> data) {
    return data.asMap().entries.map((entry) {
      final newIndex = entry.key + 1;
      final row = Map<String, String>.from(entry.value);
      row['S.No'] = '$newIndex';
      return row;
    }).toList();
  }

  // Method to get filename suffix based on filters
  String getFilenameSuffix() {
    List<String> suffixParts = [];

    if (startDate != null && endDate != null) {
      suffixParts.add(
        '${startDate!.day}-${startDate!.month}-${startDate!.year}_to_${endDate!.day}-${endDate!.month}-${endDate!.year}',
      );
    } else if (startDate != null) {
      suffixParts.add(
        'from_${startDate!.day}-${startDate!.month}-${startDate!.year}',
      );
    } else if (endDate != null) {
      suffixParts.add(
        'until_${endDate!.day}-${endDate!.month}-${endDate!.year}',
      );
    }

    if (searchQuery.isNotEmpty) {
      suffixParts.add('search_${searchQuery.replaceAll(' ', '_')}');
    }

    return suffixParts.isNotEmpty ? '_${suffixParts.join('_')}' : '';
  }

  // Method to clear all filters
  void clearFilters() {
    setState(() {
      searchController.clear();
      startDateController.clear();
      endDateController.clear();
      startDate = null;
      endDate = null;
      searchQuery = '';
    });
  }

  // Check if any filters are active
  bool get hasActiveFilters {
    return searchQuery.isNotEmpty || startDate != null || endDate != null;
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);
    // Providers
    final provider = context.totalLateArrivalsDetailsProviderWatch;
    final details = provider.data;
    final isLoading = provider.isLoading;
    final error = provider.errorMessage;

    // Cards
    final punctualData = [
      {
        'count': '${details?.totalLateArrivals ?? 0}',
        'label': 'Total Late Days',
      },
      {
        'count': '${details?.totalLateMinutes ?? 0} mins',
        'label': 'Total Late Time',
      },
      {
        'count': '${details?.averageLateMinutes ?? 0} mins',
        'label': 'Average Late Time',
      },
      {
        'count': '${details?.lateArrivalPercentage ?? 0}%',
        'label': 'Late Percentage',
      },
    ];

    // Table columns
    final columns = [
      'S.No',
      'Date',
      'Day',
      'Log on',
      'Late Minute',
      'Late Duration',
      'Status',
    ];

    // All table data (unfiltered)
    final allData = (details?.lateArrivalsDetails ?? []).asMap().entries.map((
      entry,
    ) {
      final index = entry.key + 1;
      final record = entry.value;

      final dateObj = DateTime.tryParse(record.date);
      final day = dateObj != null
          ? [
              "Sunday",
              "Monday",
              "Tuesday",
              "Wednesday",
              "Thursday",
              "Friday",
              "Saturday",
            ][dateObj.weekday % 7]
          : '-';

      return {
        'S.No': '$index',
        'Date': record.date,
        'Day': day,
        'Log on': record.checkinTime,
        'Late Minute': record.minutesLate.toString() ?? '-',
        'Late Duration': record.hoursMinutesLate ?? '-',
        'Status': record.currentStatus,
      };
    }).toList();

    // Apply filters and re-index
    final filteredData = getFilteredData(allData);
    final displayData = reindexData(filteredData);
    //App Theme Data
    final theme = Theme.of(context);
    return Scaffold(
      appBar: KAppBar(
        title: "Late Arrival Details",
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
            backgroundColor: theme.primaryColor,
            height: AppResponsive.responsiveBtnHeight(context),
            width: double.infinity,
            text: displayData.isEmpty ? "No Data to Download" : "Download",
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
                      final pdfService = getIt<PdfGeneratorService>();
                      final suffix = getFilenameSuffix();

                      String reportTitle = 'Late Arrival Report';
                      if (hasActiveFilters) {
                        reportTitle += ' (Filtered)';
                      }

                      final pdfFile = await pdfService.generateAndSavePdf(
                        data: displayData,
                        columns: columns,
                        title: reportTitle,
                        filename: 'late_arrival_report$suffix.pdf',
                      );

                      await OpenFilex.open(pdfFile.path);
                    },
                    onExcelTap: () async {
                      final excelService = getIt<ExcelGeneratorService>();
                      final suffix = getFilenameSuffix();

                      final excelFile = await excelService.generateAndSaveExcel(
                        data: displayData,
                        columns: List<String>.from(columns),
                        filename: 'late_arrival_report$suffix.xlsx',
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
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Grid Cards
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: punctualData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: isTablet ? (isLandscape ? 4.8 : 2.5) : 1.2,
                ),
                itemBuilder: (context, index) {
                  final item = punctualData[index];
                  return AttendancePunctualArrivalCard(
                    punctualCountOrPercentageText: item['count']!,
                    punctualCountOrPercentageDescriptionText: item['label']!,
                  );
                },
              ),

              KVerticalSpacer(height: 10.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KText(
                    text: "Filter & Search Options",
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                  if (hasActiveFilters)
                    GestureDetector(
                      onTap: clearFilters,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.clear, size: 12.sp, color: Colors.white),
                            SizedBox(width: 4.w),
                            Text(
                              'Clear All',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              KVerticalSpacer(height: 12.h),

              KAuthTextFormField(
                controller: searchController,
                hintText: "Search by date, day, status, etc...",
                keyboardType: TextInputType.text,
                suffixIcon: Icons.search,
              ),

              KVerticalSpacer(height: 12.h),

              Row(
                spacing: 20.w,
                children: [
                  Expanded(
                    child: KAuthTextFormField(
                      onTap: () =>
                          _selectDate(context, startDateController, true),
                      controller: startDateController,
                      hintText: "Start Date",
                      keyboardType: TextInputType.datetime,
                      suffixIcon: Icons.date_range,
                    ),
                  ),
                  Expanded(
                    child: KAuthTextFormField(
                      onTap: () =>
                          _selectDate(context, endDateController, false),
                      controller: endDateController,
                      hintText: "End Date",
                      keyboardType: TextInputType.datetime,
                      suffixIcon: Icons.date_range,
                    ),
                  ),
                ],
              ),

              // Show active filters info
              if (hasActiveFilters) ...[
                KVerticalSpacer(height: 10.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.filter_alt,
                            size: 16.sp,
                            color: theme.primaryColor,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Active Filters (${displayData.length} of ${allData.length} records):',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      if (searchQuery.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          '• Search: "$searchQuery"',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: theme.primaryColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                      if (startDate != null || endDate != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          '• Date Range: ${startDate != null ? "${startDate!.day}/${startDate!.month}/${startDate!.year}" : "Any"} to ${endDate != null ? "${endDate!.day}/${endDate!.month}/${endDate!.year}" : "Any"}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: theme.primaryColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],

              KVerticalSpacer(height: 40.h),

              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (error != null)
                Center(child: Text(error))
              else if (allData.isEmpty)
                const Center(child: Text('No late arrival records found'))
              else if (displayData.isEmpty && hasActiveFilters)
                Center(
                  child: Column(
                    children: [
                      Icon(Icons.search_off, size: 48.sp, color: Colors.grey),
                      SizedBox(height: 16.h),
                      Text(
                        'No records match your filters',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                      SizedBox(height: 8.h),
                      TextButton(
                        onPressed: clearFilters,
                        child: Text(
                          'Clear filters to show all records',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                SizedBox(
                  height: 600.h,
                  child: KDataTable(
                    columnTitles: columns,
                    rowData: displayData,
                  ),
                ),

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

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
    bool isStartDate,
  ) async {
    //App Theme Data
    final theme = Theme.of(context);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              surface: theme.scaffoldBackgroundColor, // DatePicker background
              surfaceBright: theme.scaffoldBackgroundColor,
              surfaceContainerHighest: theme.scaffoldBackgroundColor,
              primary: theme.primaryColor,
              onPrimary: theme.secondaryHeaderColor, //AppColors.secondaryColor,
              onSurface:
                  theme.textTheme.headlineLarge?.color ??
                  AppColors
                      .titleColor, //AppColors.titleColor,theme.textTheme.headlineLarge?.color,//AppColors.titleColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          // If end date is before start date, clear it
          if (endDate != null && endDate!.isBefore(picked)) {
            endDate = null;
            endDateController.clear();
          }
        } else {
          endDate = picked;
          // If start date is after end date, clear it
          if (startDate != null && startDate!.isAfter(picked)) {
            startDate = null;
            startDateController.clear();
          }
        }
      });
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }
}
