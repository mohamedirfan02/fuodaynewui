import 'package:fuoday/features/performance/domain/entities/audit_reporting_team_entity.dart';

abstract class AuditReportingTeamRepository {
  Future<List<AuditReportingTeamEntity>> getAuditReportingTeam(int webUserId);
}
