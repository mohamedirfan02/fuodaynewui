
import 'package:fuoday/features/performance/data/datasources/remote/audit_reporting_team_remote_datasource.dart';
import 'package:fuoday/features/performance/domain/entities/audit_reporting_team_entity.dart';
import 'package:fuoday/features/performance/domain/repository/audit_reporting_team_repository.dart';

class AuditReportingTeamRepositoryImpl implements AuditReportingTeamRepository {
  final AuditReportingTeamRemoteDataSource remoteDataSource;

  AuditReportingTeamRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<AuditReportingTeamEntity>> getAuditReportingTeam(int webUserId) async {
    return await remoteDataSource.getAuditReportingTeam(webUserId);
  }
}
