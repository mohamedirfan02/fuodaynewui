import 'package:fuoday/features/home/data/model/emp_list_model.dart';
import 'package:fuoday/features/home/domain/repositories/home_addtask_repository.dart';

class FetchEmployeesUseCase {
  final HomeAddTaskRepository repository;
  FetchEmployeesUseCase(this.repository);

  Future<List<EmployeeModel>> call(String webUserId) {
    return repository.fetchEmployees(webUserId);
  }
}
