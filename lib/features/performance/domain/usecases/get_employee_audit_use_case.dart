import 'package:fuoday/features/performance/domain/entities/employee_audit_entity.dart';
import 'package:fuoday/features/performance/domain/repository/employee_audit_repository.dart';

class GetEmployeeAuditUseCase {
  final EmployeeAuditRepository employeeAuditRepository;

  GetEmployeeAuditUseCase({required this.employeeAuditRepository});

  Future<EmployeeAuditEntity> call(int webUserId) async {
    return await employeeAuditRepository.getEmployeeAudit(webUserId);
  }
}
