import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/management/data/models/emp_audit_form_response_models.dart';

abstract class EmpAuditFormDataSource {
  Future<EmpAuditFormResponse> getEmployeesByManagers(int webUserId);
}

class EmpAuditFormDataSourceImpl implements EmpAuditFormDataSource {
  final DioService dioService;

  EmpAuditFormDataSourceImpl({
    required this.dioService,
  });

  @override
  Future<EmpAuditFormResponse> getEmployeesByManagers(int webUserId) async {
    try {
      final endpoint = '/web-users/getemployeesbymanagers/$webUserId';
      final response = await dioService.get(endpoint);

      if (response.statusCode == 200) {
        return EmpAuditFormResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load employees data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching employees data: $e');
    }
  }
}