import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/utils/format_timer_to_12Hr.dart';
import 'package:fuoday/features/attendance/presentation/widgets/attendance_history_tile.dart';

class AttendanceHistory extends StatefulWidget {
  const AttendanceHistory({super.key});

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
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

    Future.microtask(() {
      context.totalAttendanceDetailsProviderRead.fetchAttendanceDetails(
        webUserId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Total Attendance Provider
    final totalAttendanceDetailsProvider =
        context.totalAttendanceDetailsProviderWatch;

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

    final dataList =
        totalAttendanceDetailsProvider.attendanceDetails?.data?.days ?? [];

    // Table Data
    final List<Map<String, String>> data = dataList.asMap().entries.map((
      entry,
    ) {
      final index = entry.key + 1;
      final day = entry.value;

      return {
        'S.No': '$index',
        'Date': day.date ?? '-',
        'Day': day.day ?? '-',
        'Log on': day.checkin ?? '-',
        'Log off': day.checkout ?? '-',
        'Worked hours': day.workedHours ?? '-',
        'Status': day.status ?? '-',
      };
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          KVerticalSpacer(height: 20.h),

          // Attendance Tiles
          AttendanceHistoryTile(
            attendanceTitle: "Average Attendance",
            attendanceCount:
                totalAttendanceDetailsProvider
                    .attendanceDetails
                    ?.data
                    ?.averageCheckinTime ??
                "00:00",
          ),

          // Best Attendance Month
          AttendanceHistoryTile(
            attendanceTitle: "Best Month",
            attendanceCount:
                totalAttendanceDetailsProvider
                    .attendanceDetails
                    ?.data
                    ?.bestMonth ??
                "No Data",
          ),

          // Average Check In
          AttendanceHistoryTile(
            attendanceTitle: "Average Check In",
            attendanceCount: formatTimeTo12Hr(
              totalAttendanceDetailsProvider
                      .attendanceDetails
                      ?.data
                      ?.averageCheckinTime ??
                  "00:00:00",
            ),
          ),

          // Average Check Out
          AttendanceHistoryTile(
            attendanceTitle: "Average Check Out",
            attendanceCount: formatTimeTo12Hr(
              totalAttendanceDetailsProvider
                      .attendanceDetails
                      ?.data
                      ?.averageCheckoutTime ??
                  "00:00:00",
            ),
          ),

          KVerticalSpacer(height: 20.h),

          // Data Table
          SizedBox(
            height: 600.h,
            child: KDataTable(columnTitles: columns, rowData: data),
          ),
        ],
      ),
    );
  }
}
