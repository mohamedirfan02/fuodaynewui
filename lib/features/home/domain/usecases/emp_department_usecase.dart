import '../entities/emp_department_entity.dart';
import '../repositories/emp_department_repository.dart';

class GetEmployeesByManagerUseCase {
  final EmployeeDepartmentRepository repository;

  GetEmployeesByManagerUseCase({required this.repository});

  Future<EmployeeDepartmentEntity> call(int webUserId) {
    return repository.getEmployeesByManager(webUserId);
  }
}
