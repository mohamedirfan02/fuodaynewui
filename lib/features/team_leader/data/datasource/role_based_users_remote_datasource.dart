import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/team_leader/data/models/role_based_users_model.dart';

class RoleBasedUsersRemoteDataSource {
  final DioService dioService;

  RoleBasedUsersRemoteDataSource({required this.dioService});

  Future<RoleBasedUsersModel> getAllRoleBasedUsers(int webUserId) async {
    try {
      final response = await dioService.get(
        AppApiEndpointConstants.getAllWebUsers(webUserId),
      );
      return RoleBasedUsersModel.fromJson(response.data['data']);
    } catch (e) {
      AppLoggerHelper.logError("Failed to fetch role-based users: $e");
      rethrow;
    }
  }
}
