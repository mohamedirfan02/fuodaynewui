import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:dio/dio.dart';
import 'package:fuoday/features/manager/data/model/update_regulation_status_model.dart';

class UpdateRegulationStatusRemoteDataSource {
  final DioService dioService;

  UpdateRegulationStatusRemoteDataSource({required this.dioService});

  Future<UpdateRegulationStatusModel> updateRegulationStatus(
    int id,
    String status,
    String access,
    String module,
  ) async {
    try {
      final payload = {
        "id": id,
        "status": status,
        "access": access,
        "module": module,
      };

      AppLoggerHelper.logInfo("📤 Sending Regulation Data: $payload");

      final response = await dioService.post(
        "https://backend.fuoday.com/api/hrms/hr/update-regulation-status",
        data: payload,
      );

      AppLoggerHelper.logInfo("✅ Regulation Update Response: ${response.data}");

      if (response.statusCode == 200) {
        return UpdateRegulationStatusModel.fromJson(response.data);
      } else {
        throw Exception(
          "HTTP ${response.statusCode}: Failed to update regulation status",
        );
      }
    } on DioException catch (e) {
      AppLoggerHelper.logError(
        "❌ DioException: ${e.response?.data ?? e.message}",
      );
      rethrow;
    } catch (e) {
      AppLoggerHelper.logError(
        "❌ Unknown error in UpdateRegulationStatusRemoteDataSource: $e",
      );
      rethrow;
    }
  }
}
