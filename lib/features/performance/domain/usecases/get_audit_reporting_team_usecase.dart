

import 'package:fuoday/features/performance/domain/entities/audit_reporting_team_entity.dart';
import 'package:fuoday/features/performance/domain/repository/audit_reporting_team_repository.dart';

class GetAuditReportingTeamUseCase {
  final AuditReportingTeamRepository repository;

  GetAuditReportingTeamUseCase(this.repository);

  Future<List<AuditReportingTeamEntity>> call(int webUserId) {
    return repository.getAuditReportingTeam(webUserId);
  }
}
