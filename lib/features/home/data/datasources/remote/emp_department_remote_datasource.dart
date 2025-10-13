import 'package:fuoday/core/service/dio_service.dart';

import '../../model/emp_department_model.dart';

abstract class EmployeeDepartmentDataSource {
  Future<EmployeeDepartmentResponse> getEmployeesByManager(int webUserId);
}

class EmployeeDepartmentDataSourceImpl implements EmployeeDepartmentDataSource {
  final DioService dioService;

  EmployeeDepartmentDataSourceImpl({required this.dioService});

  @override
  Future<EmployeeDepartmentResponse> getEmployeesByManager(
    int webUserId,
  ) async {
    try {
      final endpoint = '/web-users/getemployeesbyadmin/$webUserId';
      final response = await dioService.get(endpoint);

      if (response.statusCode == 200) {
        return EmployeeDepartmentResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Failed to load employees data: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching employees data: $e');
    }
  }
}
