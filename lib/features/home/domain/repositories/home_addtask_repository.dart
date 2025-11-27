import 'package:fuoday/features/home/data/model/emp_list_model.dart';
import 'package:fuoday/features/home/domain/entities/home_addtask_entity.dart';

abstract class HomeAddTaskRepository {
  Future<void> addTask(HomeAddTaskEntity task, String webUserId);
  Future<List<EmployeeModel>> fetchEmployees(String webUserId);
}

