import 'package:fuoday/core/providers/app_internet_checker_provider.dart';
import 'package:fuoday/features/teams/data/datasources/local/team_member_local_data_source.dart';
import 'package:fuoday/features/teams/data/datasources/remote/team_member_remote_data_source.dart';
import 'package:fuoday/features/teams/domain/entities/team_member_entity.dart';
import 'package:fuoday/features/teams/domain/repository/team_member_respository.dart';

class TeamMemberRepositoryImpl implements TeamMemberRepository {
  final TeamMemberRemoteDataSource remoteDataSource;
  final TeamMemberLocalDataSource localDataSource;
  final AppInternetCheckerProvider appInternetCheckerProvider;

  TeamMemberRepositoryImpl({
    required this.appInternetCheckerProvider,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<TeamMemberEntity>> getTeamMembers(String webUserId) async {
    // app internet checker provider
    final isConnected = appInternetCheckerProvider.isNetworkConnected;

    if (isConnected) {
      final models = await remoteDataSource.getAllTeamMembers(webUserId);
      localDataSource.cacheTeamMembers(models);
      return models;
    } else {
      final localData = await localDataSource.getTeamMembersLocalHive();
      return localData;
    }
  }
}
