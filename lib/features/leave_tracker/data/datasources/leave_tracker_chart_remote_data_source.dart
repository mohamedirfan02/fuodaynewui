import 'package:dio/dio.dart';
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/features/leave_tracker/data/models/leave_tracker_chart_model.dart';


class LeaveTrackerChartRemoteDataSource {
  final Dio dio;
  LeaveTrackerChartRemoteDataSource(this.dio);

  Future<List<LeaveTrackerChartModel>> fetchMonthlyLeaveChart(String webUserId) async {
    final response = await dio.get(AppApiEndpointConstants.leaveTracker(webUserId));
    final data = response.data['monthly_graph'] as List<dynamic>;
    return data.map((e) => LeaveTrackerChartModel.fromJson(e)).toList();
  }
}