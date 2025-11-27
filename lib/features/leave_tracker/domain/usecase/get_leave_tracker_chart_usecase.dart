import 'package:fuoday/features/leave_tracker/domain/entities/leave_tracker_chart_entity.dart';
import 'package:fuoday/features/leave_tracker/domain/repository/leave_tracker_chart_repository.dart';

class GetLeaveTrackerChartUseCase {
  final LeaveTrackerChartRepository repository;

  GetLeaveTrackerChartUseCase(this.repository);

  Future<List<LeaveTrackerChartEntity>> call(String webUserId) async {
    return repository.getMonthlyLeaveChart(webUserId);
  }
}
