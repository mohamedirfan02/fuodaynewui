
import 'package:fuoday/features/performance/domain/entities/audit_report_entity.dart';

abstract class AuditReportRepository {
  Future<AuditReportEntity> getEachPersonAuditForm(int id);
}
