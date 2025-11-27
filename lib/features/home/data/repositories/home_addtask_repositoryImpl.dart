import 'package:fuoday/features/home/data/datasources/remote/home_add_task_remote_data_source.dart';
import 'package:fuoday/features/home/data/model/emp_list_model.dart';
import 'package:fuoday/features/home/data/model/home_addtask_model.dart';
import 'package:fuoday/features/home/domain/entities/home_addtask_entity.dart';
import 'package:fuoday/features/home/domain/repositories/home_addtask_repository.dart';

class HomeAddTaskRepositoryImpl implements HomeAddTaskRepository {
  final HomeAddTaskRemoteDataSource dataSource;
  HomeAddTaskRepositoryImpl(this.dataSource);

  @override
  Future<void> addTask(HomeAddTaskEntity task, String webUserId) {
    final model = HomeAddTaskModel.fromEntity(task);
    return dataSource.addTask(model, webUserId);
  }

  @override
  Future<List<EmployeeModel>> fetchEmployees(String webUserId) {
    return dataSource.fetchEmployees(webUserId);
  }
}