

import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/performance/data/models/audit_reporting_team_model.dart';

abstract class AuditReportingTeamRemoteDataSource {
  Future<List<AuditReportingTeamModel>> getAuditReportingTeam(int webUserId);
}

class AuditReportingTeamRemoteDataSourceImpl
    implements AuditReportingTeamRemoteDataSource {
  final DioService dioService;

  AuditReportingTeamRemoteDataSourceImpl(this.dioService);

  @override
  Future<List<AuditReportingTeamModel>> getAuditReportingTeam(int webUserId) async {
    final response = await dioService.get(
      '/hrms/performance/getauditreportingteam/$webUserId',
    );

    final List data = response.data['data'] ?? [];
    return data.map((e) => AuditReportingTeamModel.fromJson(e)).toList();
  }
}
