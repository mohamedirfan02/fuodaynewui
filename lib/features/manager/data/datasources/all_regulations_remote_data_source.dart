import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/manager/data/model/all_regulations_model.dart';

class AllRegulationsRemoteDataSource {
  final DioService dioService;

  AllRegulationsRemoteDataSource({required this.dioService});

  Future<AllRegulationsModel> getAllRegulations(int webUserId) async {
    try {
      final response = await dioService.get(
        AppApiEndpointConstants.getAllRegulation(webUserId),
        // "https://backend.fuoday.com/api/hrms/hr/regulations/$webUserId",
      );

      AppLoggerHelper.logInfo("✅ Regulations fetched successfully");

      final data = (response.data is Map)
          ? Map<String, dynamic>.from(response.data)
          : <String, dynamic>{};

      return AllRegulationsModel.fromJson(data);
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to fetch regulations: $e");
      rethrow;
    }
  }
}
