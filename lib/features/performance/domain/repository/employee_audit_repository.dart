import 'package:fuoday/features/performance/domain/entities/employee_audit_entity.dart';

abstract class EmployeeAuditRepository {
  // Web User Id
  Future<EmployeeAuditEntity> getEmployeeAudit(int webUserId);
}
