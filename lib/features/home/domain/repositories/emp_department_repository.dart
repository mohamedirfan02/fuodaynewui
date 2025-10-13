import '../entities/emp_department_entity.dart';

abstract class EmployeeDepartmentRepository {
  Future<EmployeeDepartmentEntity> getEmployeesByManager(int webUserId);
}
