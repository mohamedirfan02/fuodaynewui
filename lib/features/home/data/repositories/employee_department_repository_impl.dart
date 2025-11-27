import '../../domain/entities/emp_department_entity.dart';
import '../../domain/repositories/emp_department_repository.dart';
import '../datasources/remote/emp_department_remote_datasource.dart';

class EmployeeDepartmentRepositoryImpl implements EmployeeDepartmentRepository {
  final EmployeeDepartmentDataSource dataSource;

  EmployeeDepartmentRepositoryImpl({required this.dataSource});

  @override
  Future<EmployeeDepartmentEntity> getEmployeesByManager(int webUserId) async {
    final response = await dataSource.getEmployeesByManager(webUserId);

    return EmployeeDepartmentEntity(
      message: response.message,
      status: response.status,
      data: response.data
          .map(
            (e) => EmployeeModelEntity(
              webUserId: e.webUserId,
              empName: e.empName,
              empId: e.empId,
              department: e.department,
            ),
          )
          .toList(),
      sameDepartment: response.sameDepartment
          .map(
            (e) => EmployeeModelEntity(
              webUserId: e.webUserId,
              empName: e.empName,
              empId: e.empId,
              department: e.department,
            ),
          )
          .toList(),
      userDepartment: response.userDepartment,
    );
  }
}
