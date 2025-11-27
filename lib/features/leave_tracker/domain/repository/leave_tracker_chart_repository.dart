import 'package:fuoday/features/leave_tracker/domain/entities/leave_tracker_chart_entity.dart';

abstract class LeaveTrackerChartRepository {
  Future<List<LeaveTrackerChartEntity>> getMonthlyLeaveChart(String webUserId);
}

