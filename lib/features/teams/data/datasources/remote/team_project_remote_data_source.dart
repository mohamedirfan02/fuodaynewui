import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/teams/data/models/team_project_model.dart';

class TeamProjectRemoteDataSource {
  final DioService dioService;

  TeamProjectRemoteDataSource({required this.dioService});

  Future<List<TeamProjectModel>> getHandledProjects(String webUserId) async {
    final response = await dioService.get(
      AppApiEndpointConstants.projects(webUserId),
    );

    final List<dynamic> dataList = response.data['data'] ?? [];

    return dataList
        .map((json) => TeamProjectModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
