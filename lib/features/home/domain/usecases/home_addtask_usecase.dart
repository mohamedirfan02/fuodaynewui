import 'package:fuoday/features/home/domain/entities/home_addtask_entity.dart';
import 'package:fuoday/features/home/domain/repositories/home_addtask_repository.dart';

class HomeAddTaskUseCase {
  final HomeAddTaskRepository repository;
  HomeAddTaskUseCase(this.repository);


  Future<void> call(HomeAddTaskEntity task, String webUserId) {
    return repository.addTask(task, webUserId);
  }
}