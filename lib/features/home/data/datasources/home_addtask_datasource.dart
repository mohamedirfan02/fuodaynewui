import 'package:dio/dio.dart';
import 'package:fuoday/core/constants/app_api_endpoint_constants.dart';
import 'package:fuoday/features/home/data/model/emp_list_model.dart';
import 'package:fuoday/features/home/data/model/home_addtask_model.dart';

abstract class HomeAddTaskRemoteDataSource {
  Future<void> addTask(HomeAddTaskModel taskModel, String webUserId);
  Future<List<EmployeeModel>> fetchEmployees(String webUserId);
}

class HomeAddTaskRemoteDataSourceImpl implements HomeAddTaskRemoteDataSource {
  final Dio dio;
  HomeAddTaskRemoteDataSourceImpl(this.dio);

  @override
  Future<void> addTask(HomeAddTaskModel model, String webUserId) async {
    final url = AppApiEndpointConstants.assignTask;
    await dio.post(url, data: model.toJson());
  }

  Future<List<EmployeeModel>> fetchEmployees(String webUserId) async {
    final response = await dio.get(AppApiEndpointConstants.allEmployeeList(webUserId));
    final data = response.data['data'] as List;
    return data.map((e) => EmployeeModel.fromJson(e)).toList();
  }

}

// // 6. Repository Impl
// class HomeAddTaskRepositoryImpl implements HomeAddTaskRepository {
//   final HomeAddTaskRemoteDataSource dataSource;
//   HomeAddTaskRepositoryImpl(this.dataSource);
//
//   @override
//   Future<void> addTask(HomeAddTaskEntity task, String webUserId) {
//     final model = HomeAddTaskModel.fromEntity(task);
//     return dataSource.addTask(model, webUserId);
//   }
// }