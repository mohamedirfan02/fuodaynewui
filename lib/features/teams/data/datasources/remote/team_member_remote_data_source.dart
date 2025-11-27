import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/teams/data/models/team_member_model.dart';

class TeamMemberRemoteDataSource {
  final DioService dioService;

  TeamMemberRemoteDataSource({required this.dioService});

  Future<List<TeamMemberModel>> getAllTeamMembers(String webUserId) async {
    final response = await dioService.get(
      AppApiEndpointConstants.teamList(webUserId),
    );
    final List<dynamic> membersJson =
        response.data['data']['team_members'] ?? [];

    return membersJson
        .map((json) => TeamMemberModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
