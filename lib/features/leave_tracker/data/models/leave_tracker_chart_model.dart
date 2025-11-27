import 'package:fuoday/features/leave_tracker/domain/entities/leave_tracker_chart_entity.dart';

class LeaveTrackerChartModel extends LeaveTrackerChartEntity {
  LeaveTrackerChartModel({
    required super.month,
    required super.leave,
    required super.days,
  });

  factory LeaveTrackerChartModel.fromJson(Map<String, dynamic> json) {
    return LeaveTrackerChartModel(
      month: json['month'],
      leave: json['leave'],
      days: json['days'],
    );
  }
}