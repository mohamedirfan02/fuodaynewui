import 'package:fuoday/features/management/domain/entities/emp_audit_form_entity.dart';
import 'package:fuoday/features/management/domain/repository/emp_audit_form_repository.dart';

class GetEmployeesByManagersUseCase {
  final EmpAuditFormRepository repository;

  GetEmployeesByManagersUseCase(this.repository);

  Future<EmpAuditFormEntity> call(int webUserId) {
    return repository.getEmployeesByManagers(webUserId);
  }
}