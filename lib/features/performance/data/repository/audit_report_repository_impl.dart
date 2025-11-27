
import 'package:fuoday/features/performance/data/datasources/remote/audit_report_remote_datasource.dart';
import 'package:fuoday/features/performance/domain/entities/audit_report_entity.dart';
import 'package:fuoday/features/performance/domain/repository/audit_report_repository.dart';

class AuditReportRepositoryImpl implements AuditReportRepository {
  final AuditReportRemoteDataSource remoteDataSource;

  AuditReportRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuditReportEntity> getEachPersonAuditForm(int id) async {
    return await remoteDataSource.getEachPersonAuditForm(id);
  }
}
