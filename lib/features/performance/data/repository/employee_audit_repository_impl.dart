import 'package:fuoday/features/performance/data/datasources/remote/employee_audit_remote_data_source.dart';
import 'package:fuoday/features/performance/domain/entities/employee_audit_entity.dart';
import 'package:fuoday/features/performance/domain/repository/employee_audit_repository.dart';

class EmployeeAuditRepositoryImpl implements EmployeeAuditRepository {
  final EmployeeAuditRemoteDataSource employeeAuditRemoteDataSource;

  EmployeeAuditRepositoryImpl({required this.employeeAuditRemoteDataSource});

  @override
  Future<EmployeeAuditEntity> getEmployeeAudit(int webUserId) async {
    return await employeeAuditRemoteDataSource.getEmployeeAudit(webUserId);
  }
}
