import 'package:fuoday/core/providers/app_internet_checker_provider.dart';
import 'package:fuoday/features/teams/data/datasources/local/team_reportees_local_data_source.dart';
import 'package:fuoday/features/teams/data/datasources/remote/team_reportees_remote_data_source.dart';
import 'package:fuoday/features/teams/domain/entities/team_reportees_entity.dart';
import 'package:fuoday/features/teams/domain/repository/team_reportees_repository.dart';

class TeamReporteesRepositoryImpl implements TeamReporteesRepository {
  final TeamReporteesRemoteDataSource remoteDataSource;
  final TeamReporteesLocalDataSource localDataSource;
  final AppInternetCheckerProvider appInternetCheckerProvider;

  TeamReporteesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.appInternetCheckerProvider,
  });

  @override
  Future<List<TeamReporteesEntity>> getReportees(String webUserId) async {
    // app internet checker provider
    final isConnected = appInternetCheckerProvider.isNetworkConnected;

    if (isConnected) {
      final models = await remoteDataSource.getReportees(webUserId);
      localDataSource.cacheReportees(models);
      return models;
    } else {
      final models = await localDataSource.getReporteesLocalHive();
      return models;
    }
  }
}
