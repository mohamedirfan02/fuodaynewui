

import 'package:fuoday/features/performance/domain/entities/audit_report_entity.dart';
import 'package:fuoday/features/performance/domain/repository/audit_report_repository.dart';

class GetAuditReportUseCase {
  final AuditReportRepository repository;

  GetAuditReportUseCase(this.repository);

  Future<AuditReportEntity> call(int id) {
    return repository.getEachPersonAuditForm(id);
  }
}
