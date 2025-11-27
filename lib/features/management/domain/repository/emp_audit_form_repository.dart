import 'package:fuoday/features/management/domain/entities/emp_audit_form_entity.dart';

abstract class EmpAuditFormRepository {
  Future<EmpAuditFormEntity> getEmployeesByManagers(int webUserId);
}