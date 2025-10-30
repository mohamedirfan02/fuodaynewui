import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/team_leader/data/models/all_leave_requests_model.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';

class AllLeaveRequestsRemoteDataSource {
  final DioService dioService;

  AllLeaveRequestsRemoteDataSource({required this.dioService});

  Future<AllLeaveRequestsModel> getAllLeavesByStatus(String status) async {
    try {
      final response = await dioService.get(
        "https://backend.fuoday.com/api/hrms/hr/getallleavesbystatus/$status",
      );

      AppLoggerHelper.logInfo(
          "✅ API Response (${response.statusCode}): ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          return AllLeaveRequestsModel.fromJson(data);
        }

        throw Exception('Unexpected API format: ${data.runtimeType}');
      } else {
        throw Exception('HTTP ${response.statusCode}: Failed to load leaves');
      }
    } catch (e) {
      AppLoggerHelper.logError('❌ DataSource error: $e');
      rethrow;
    }
  }
}
