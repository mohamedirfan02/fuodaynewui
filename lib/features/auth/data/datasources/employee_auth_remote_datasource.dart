import 'package:fuoday/core/constants/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/auth/data/models/employee_auth_model.dart';

class EmployeeAuthRemoteDataSource {
  final DioService dioService;

  EmployeeAuthRemoteDataSource({required this.dioService});

  // Employee Login Post Operation
  Future<EmployeeAuthModel> login({
    required String role,
    required String emailId,
    required String password,
  }) async {
    try {
      final response = await dioService.post(
        AppApiEndpointConstants.login,
        data: {'role': role, 'email': emailId, 'password': password},
      );

      return EmployeeAuthModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // Employee Logout Operation
  Future<void> logOut() async {
    try {
      await dioService.post(AppApiEndpointConstants.logout);
    } catch (e) {
      rethrow;
    }
  }
}
