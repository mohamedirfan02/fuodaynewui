//=============================================
// Data Layer: DATA SOURCE
//=============================================
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/team_leader/data/models/all_role_late_arrivals_report_model.dart';

class LateArrivalsRemoteDataSource {
  final DioService dioService;

  LateArrivalsRemoteDataSource({required this.dioService});

  Future<LateArrivalsModel> getAllLateArrivals() async {
    try {
      final response = await dioService.get(
        AppApiEndpointConstants.getAllLateArrivalsReport(),
      );

      return LateArrivalsModel.fromJson(response.data);
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to fetch late arrivals: $e");
      rethrow;
    }
  }
}
