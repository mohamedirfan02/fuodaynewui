

import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/team_tree/data/models/team_tree_model.dart';

abstract class TeamTreeRemoteDataSource {
  Future<List<TeamTreeModel>> getTeamTree(int webUserId);
}

class TeamTreeRemoteDataSourceImpl implements TeamTreeRemoteDataSource {
  final DioService dioService;

  TeamTreeRemoteDataSourceImpl(this.dioService);

  @override
  Future<List<TeamTreeModel>> getTeamTree(int webUserId) async {
    final response = await dioService.get(
      "/web-users/getemployeesbymanagers/$webUserId",
    );

    final data = response.data['data'] as List;
    return data.map((e) => TeamTreeModel.fromJson(e)).toList();
  }
}
