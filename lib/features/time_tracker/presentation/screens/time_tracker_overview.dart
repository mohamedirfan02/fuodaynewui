import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_data_table.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/features/time_tracker/domain/entities/time_tracker_entity.dart';
import 'package:fuoday/features/time_tracker/presentation/widgets/time_tracker_overview_card.dart';
import 'package:intl/intl.dart';

class TimeTrackerOverview extends StatelessWidget {
  final List<Attendance> data;

  const TimeTrackerOverview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final columns = ['S.No', 'Date', 'Log on', 'Log off', 'Worked hours'];

    final rowData = data.asMap().entries.map((entry) {
      final i = entry.key;
      final attendance = entry.value;
      final dateTime = DateTime.tryParse(attendance.date);
      final dayName = dateTime != null
          ? DateFormat('EEEE').format(dateTime)
          : '-';
      return {
        'S.No': '${i + 1}',
        'Date': attendance.date,
        'Log on': attendance.firstLogin,
        'Log off': attendance.lastLogout,
        'Worked hours': attendance.totalHours,
      };
    }).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 0.2.sh,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TimeTrackerOverviewCard(
                    iconData: Icons.lock_clock,
                    timeTrackerOverviewCardTitle: "Weekly Working",
                    timeTrackerOverviewCardWorkingHours: "48 Hours",
                  ),
                  KHorizontalSpacer(width: 10.w),
                  TimeTrackerOverviewCard(
                    iconData: Icons.calendar_month,
                    timeTrackerOverviewCardTitle: "Work Time Per Day",
                    timeTrackerOverviewCardWorkingHours: "8 Hours",
                  ),
                  KHorizontalSpacer(width: 10.w),
                  TimeTrackerOverviewCard(
                    iconData: Icons.access_time,
                    timeTrackerOverviewCardTitle: "Break Time Per Day",
                    timeTrackerOverviewCardWorkingHours: "1 Hours",
                  ),
                ],
              ),
            ),
          ),

          KVerticalSpacer(height: 20.h),
          KText(
            text: "Time Management",
            fontWeight: FontWeight.w600,
            fontSize: 13.sp,
            //color: AppColors.titleColor,
          ),
          KVerticalSpacer(height: 10.h),
          SizedBox(
            height: 200.h,
            child: KDataTable(columnTitles: columns, rowData: rowData),
          ),
        ],
      ),
    );
  }
}
