// lib/features/team_leader/data/datasource/update_leave_status_remote_data_source.dart

import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/manager/data/model/update_leave_status_model.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:dio/dio.dart';

class UpdateLeaveStatusRemoteDataSource {
  final DioService dioService;

  UpdateLeaveStatusRemoteDataSource({required this.dioService});

  Future<UpdateLeaveStatusModel> updateLeaveStatus(int id, String status,String access) async {
    try {
      final payload = {
        "leave_request_id": id, // ✅ correct key name
        "status": status,
        "access":access,
      };

      AppLoggerHelper.logInfo("📤 Sending data: $payload");

      final response = await dioService.post(
        "https://backend.fuoday.com/api/hrms/leave/updateleave",
        data: payload,
      );

      AppLoggerHelper.logInfo("✅ Update Response: ${response.data}");

      if (response.statusCode == 200) {
        return UpdateLeaveStatusModel.fromJson(response.data);
      } else {
        throw Exception("HTTP ${response.statusCode}: Failed to update leave");
      }
    } on DioException catch (e) {
      AppLoggerHelper.logError("❌ DioException: ${e.response?.data ?? e.message}");
      rethrow;
    } catch (e) {
      AppLoggerHelper.logError("❌ Unknown error in UpdateLeaveStatusRemoteDataSource: $e");
      rethrow;
    }
  }
}
