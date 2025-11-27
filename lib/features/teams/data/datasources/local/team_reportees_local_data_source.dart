import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/teams/data/models/team_reportees_model.dart';

class TeamReporteesLocalDataSource {
  final HiveStorageService hiveStorageService;

  TeamReporteesLocalDataSource({required this.hiveStorageService});

  Future<void> cacheReportees(List<TeamReporteesModel> reportees) async {
    final jsonList = reportees.map((e) => e.toJson()).toList();
    await hiveStorageService.put(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.teamReportees,
      jsonList,
    );
  }

  Future<List<TeamReporteesModel>> getReporteesLocalHive() async {
    final data = await hiveStorageService.get<List>(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.teamReportees,
      defaultValue: [],
    );

    return (data ?? []).map((e) => TeamReporteesModel.fromJson(e)).toList();
  }
}
