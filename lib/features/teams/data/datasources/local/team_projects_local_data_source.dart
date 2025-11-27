import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/teams/data/models/team_project_model.dart';

class TeamProjectLocalDataSource {
  final HiveStorageService hiveStorageService;

  TeamProjectLocalDataSource({required this.hiveStorageService});

  Future<void> cacheProjects(List<TeamProjectModel> projects) async {
    final jsonList = projects.map((e) => e.toJson()).toList();
    await hiveStorageService.put(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.teamProject,
      jsonList,
    );
  }

  Future<List<TeamProjectModel>> getProjectsLocalHive() async {
    final data = await hiveStorageService.get<List>(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.teamProject,
      defaultValue: [],
    );

    return (data ?? []).map((e) => TeamProjectModel.fromJson(e)).toList();
  }
}
