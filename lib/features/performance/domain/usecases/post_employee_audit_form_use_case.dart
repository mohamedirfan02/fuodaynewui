import 'package:fuoday/features/performance/domain/entities/employee_audit_form_entity.dart';
import 'package:fuoday/features/performance/domain/repository/employee_audit_form_repository.dart';

class PostEmployeeAuditFormUseCase {
  final EmployeeAuditFormRepository employeeAuditFormRepository;

  PostEmployeeAuditFormUseCase({required this.employeeAuditFormRepository});

  Future<void> call(EmployeeAuditFormEntity employeeAuditFormEntity) async {
    return await employeeAuditFormRepository.postEmployeeAuditForm(
      employeeAuditFormEntity,
    );
  }
}
