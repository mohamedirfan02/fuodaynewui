import 'package:fuoday/core/providers/app_internet_checker_provider.dart';
import 'package:fuoday/features/teams/data/datasources/local/team_projects_local_data_source.dart';
import 'package:fuoday/features/teams/data/datasources/remote/team_project_remote_data_source.dart';
import 'package:fuoday/features/teams/domain/entities/team_project_entity.dart';
import 'package:fuoday/features/teams/domain/repository/team_project_repostiory.dart';

class TeamProjectRepositoryImpl implements TeamProjectRepository {
  final TeamProjectRemoteDataSource remoteDataSource;
  final TeamProjectLocalDataSource localDataSource;
  final AppInternetCheckerProvider appInternetCheckerProvider;

  TeamProjectRepositoryImpl({
    required this.remoteDataSource,
    required this.appInternetCheckerProvider,
    required this.localDataSource,
  });

  @override
  Future<List<TeamProjectEntity>> getTeamProjects(String webUserId) async {
    // app internet checker provider
    final isConnected = appInternetCheckerProvider.isNetworkConnected;

    if (isConnected) {
      final models = await remoteDataSource.getHandledProjects(webUserId);
      localDataSource.cacheProjects(models);
      return models;
    } else {
      final models = await localDataSource.getProjectsLocalHive();
      return models;
    }
  }
}
