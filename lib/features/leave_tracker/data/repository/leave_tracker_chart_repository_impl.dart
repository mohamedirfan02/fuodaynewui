import 'package:fuoday/features/leave_tracker/data/datasources/leave_tracker_chart_remote_data_source.dart';
import 'package:fuoday/features/leave_tracker/domain/entities/leave_tracker_chart_entity.dart';
import 'package:fuoday/features/leave_tracker/domain/repository/leave_tracker_chart_repository.dart';

class LeaveTrackerChartRepositoryImpl implements LeaveTrackerChartRepository {
  final LeaveTrackerChartRemoteDataSource remoteDataSource;
  LeaveTrackerChartRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<LeaveTrackerChartEntity>> getMonthlyLeaveChart(String webUserId) {
    return remoteDataSource.fetchMonthlyLeaveChart(webUserId);
  }
}