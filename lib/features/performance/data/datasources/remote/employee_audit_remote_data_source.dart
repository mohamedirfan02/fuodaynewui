import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/performance/data/models/employee_audit_model.dart';

class EmployeeAuditRemoteDataSource {
  final DioService dioService;

  EmployeeAuditRemoteDataSource({required this.dioService});

  Future<EmployeeAuditModel> getEmployeeAudit(int webUserId) async {
    final response = await dioService.get(
      AppApiEndpointConstants.getEmployeeAudit(webUserId),
    );

    final employeeAuditData = response.data['data'];

    return EmployeeAuditModel.fromJson(employeeAuditData);
  }
}
