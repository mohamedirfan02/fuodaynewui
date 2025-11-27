import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import '../models/employee_profile_model.dart';

class EmployeeProfileRemoteDataSource {
  final DioService dio;

  EmployeeProfileRemoteDataSource({required this.dio});

  Future<EmployeeProfileModel> getEmployeeProfile(String webUserId) async {
    try {
      final hiveService = getIt<HiveStorageService>();
      final employeeDetails = hiveService.employeeDetails;
      final response = await dio.get(
        AppApiEndpointConstants.profileData(
          employeeDetails?['web_user_id'] ?? "No Web User Id Found",
        ),
      );

      return EmployeeProfileModel.fromJson(response.data['data']);
    } catch (e) {
      AppLoggerHelper.logError('Failed to fetch profile: $e');
      rethrow;
    }
  }
}
