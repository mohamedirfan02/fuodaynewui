import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/teams/data/models/team_member_model.dart';

class TeamMemberLocalDataSource {
  final HiveStorageService hiveStorageService;

  TeamMemberLocalDataSource({required this.hiveStorageService});

  Future<void> cacheTeamMembers(List<TeamMemberModel> members) async {
    final jsonList = members.map((e) => e.toJson()).toList();
    await hiveStorageService.put(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.teamMembersList,
      jsonList,
    );
  }

  Future<List<TeamMemberModel>> getTeamMembersLocalHive() async {
    final data = await hiveStorageService.get<List>(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.teamMembersList,
      defaultValue: [],
    );

    return (data ?? []).map((e) => TeamMemberModel.fromJson(e)).toList();
  }
}
