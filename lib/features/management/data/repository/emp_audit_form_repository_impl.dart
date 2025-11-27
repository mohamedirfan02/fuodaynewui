import 'package:fuoday/features/management/data/datasources/emp_audit_form_datasource.dart';
import 'package:fuoday/features/management/data/models/emp_audit_form_response_models.dart';
import 'package:fuoday/features/management/domain/entities/emp_audit_form_entity.dart';
import 'package:fuoday/features/management/domain/repository/emp_audit_form_repository.dart';

class EmpAuditFormRepositoryImpl implements EmpAuditFormRepository {
  final EmpAuditFormDataSource dataSource;

  EmpAuditFormRepositoryImpl(this.dataSource);

  @override
  Future<EmpAuditFormEntity> getEmployeesByManagers(int webUserId) async {
    try {
      final response = await dataSource.getEmployeesByManagers(webUserId);
      return _mapResponseToEntity(response);
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }

  EmpAuditFormEntity _mapResponseToEntity(EmpAuditFormResponse response) {
    return EmpAuditFormEntity(
      status: response.status,
      message: response.message,
      data: response.data.map((managerData) {
        return ManagerWithEmployeesEntity(
          managerId: managerData.managerId,
          managerName: managerData.managerName,
          employees: managerData.employees.map((empData) {
            return EmployeeAuditEntity(
              id: empData.id,
              empName: empData.empName,
              empId: empData.empId,
              designation: empData.designation,
              department: empData.department,
              doj: empData.doj,
              profilePhoto: empData.profilePhoto,
              status: empData.status,
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}