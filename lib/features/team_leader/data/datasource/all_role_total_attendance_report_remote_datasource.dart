import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/team_leader/data/models/all_role_total_attendance_report_model.dart';

class AllRoleTotalAttendanceReportRemoteDataSource {
  final DioService dioService;

  AllRoleTotalAttendanceReportRemoteDataSource({required this.dioService});

  Future<AllRoleTotalAttendanceReportModel> getAllAttendanceReport(
    int webUserId,
  ) async {
    try {
      final response = await dioService.get(
        AppApiEndpointConstants.getAllAttendance(webUserId),
      );

      AppLoggerHelper.logInfo("✅ Attendance report fetched successfully");

      /// Defensive cast: ensure the map is in correct format
      final data = (response.data is Map)
          ? Map<String, dynamic>.from(response.data)
          : <String, dynamic>{};

      return AllRoleTotalAttendanceReportModel.fromJson(data);
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to fetch attendance report: $e");
      rethrow;
    }
  }
}
