
import 'package:fuoday/features/performance/domain/entities/audit_reporting_team_entity.dart';

class AuditReportingTeamModel extends AuditReportingTeamEntity {
  AuditReportingTeamModel({
    required int webUserId,
    required String empName,
    required String empId,
    required String status,
  }) : super(
    webUserId: webUserId,
    empName: empName,
    empId: empId,
    status: status,
  );

  factory AuditReportingTeamModel.fromJson(Map<String, dynamic> json) {
    return AuditReportingTeamModel(
      webUserId: json['web_user_id'] ?? 0,
      empName: json['emp_name'] ?? '',
      empId: json['emp_id'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
