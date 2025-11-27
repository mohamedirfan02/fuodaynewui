import 'package:fuoday/features/performance/domain/entities/employee_audit_form_entity.dart';

abstract class EmployeeAuditFormRepository {
  // Post Employee Audit Form
  Future<void> postEmployeeAuditForm(EmployeeAuditFormEntity employeeAuditFormEntity);
}
