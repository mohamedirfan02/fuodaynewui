import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/attendance/presentation/widgets/attendance_line_chart.dart';
import 'package:fuoday/features/leave_tracker/data/datasources/leave_remote_data_source.dart';
import 'package:fuoday/features/leave_tracker/data/models/leave_report_models.dart';
import 'package:get_it/get_it.dart';

class LeaveReports extends StatelessWidget {
  final List<double> attendanceValues;
  final List<String> months;

  const LeaveReports({
    super.key,
    required this.attendanceValues,
    required this.months,
  });

  String _monthFromInt(int month) {
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return monthNames[month - 1];
  }


  @override
  Widget build(BuildContext context) {
    final leaveRemoteDataSource = GetIt.I<LeaveRemoteDataSource>();
    final webUserId = GetIt.I<HiveStorageService>().employeeDetails?['web_user_id']
            ?.toString() ?? '';

    return FutureBuilder<List<LeaveReportModel>>(
      future: leaveRemoteDataSource.fetchLeaveReport(webUserId),

      // use actual web_user_id
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No leave reports available.'));
        }

        final leaveReports = snapshot.data!;
        final columns = ['S.No', 'Date','From','To', 'Leave Type', 'Reason', 'Status','Permission Timing', 'Regulation Status', 'Regulation Date'];

        final data = leaveReports.asMap().entries.map((entry) {
          final index = entry.key;
          final report = entry.value;
          return {
            'S.No': '${index + 1}',
            'Date': report.date,
            'From': report.from,
            'To': report.to,
            'Leave Type': report.type,
            'Reason': report.reason,
            'Status': report.status,
            'Permission Timing': report.permissionTiming,
            'Regulation Status': report.regulationStatus,
            'Regulation Date': report.regulationDate,
          };
        }).toList();

        // Initialize counts for each month
        final monthCountMap = {
          'Jan': 0.0,
          'Feb': 0.0,
          'Mar': 0.0,
          'Apr': 0.0,
          'May': 0.0,
          'Jun': 0.0,
          'Jul': 0.0,
          'Aug': 0.0,
          'Sep': 0.0,
          'Oct': 0.0,
          'Nov': 0.0,
          'Dec': 0.0,
        };

// Fill counts from report dates
        for (final report in leaveReports) {
          final date = DateTime.tryParse(report.date);
          if (date != null) {
            final month = _monthFromInt(date.month);
            monthCountMap[month] = monthCountMap[month]! + 1;
          }
        }

// Extract chart data
        final months = monthCountMap.keys.toList();
        final attendanceData = monthCountMap.values.toList();

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              KText(
                text: "Monthly Leave",
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),

              KVerticalSpacer(height: 14.h),

              // Chart
              SizedBox(
                height: 340.h,
                child: AttendanceLineChart(
                  attendanceValues: attendanceData,
                  months: months,
                ),
              ),

              KVerticalSpacer(height: 20.h),

              // Data Table
              SizedBox(
                height: 400.h,
                child: KDataTable(columnTitles: columns, rowData: data),
              ),
            ],
          ),
        );
      },
    );
  }
}
