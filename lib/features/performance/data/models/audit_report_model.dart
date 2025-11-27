
import 'package:fuoday/features/performance/domain/entities/audit_report_entity.dart';

class AuditReportModel extends AuditReportEntity {
  AuditReportModel({
    required super.id,
    required super.webUserId,
    required super.empName,
    required super.empId,
    required super.department,
    required super.dateOfJoining,
    required super.keyTasksCompleted,
    required super.challengesFaced,
    required super.proudContribution,
    required super.trainingSupportNeeded,
    required super.ratingTechnicalKnowledge,
    required super.ratingTeamwork,
    required super.ratingCommunication,
    required super.ratingPunctuality,
    required super.training,
    required super.hike,
    required super.growthPath,
  });

  factory AuditReportModel.fromJson(Map<String, dynamic> json) {
    return AuditReportModel(
      id: json['id'],
      webUserId: json['web_user_id'],
      empName: json['emp_name'] ?? '',
      empId: json['emp_id'] ?? '',
      department: json['department'] ?? '',
      dateOfJoining: json['date_of_joining'] ?? '',
      keyTasksCompleted: json['key_tasks_completed'] ?? '',
      challengesFaced: json['challenges_faced'] ?? '',
      proudContribution: json['proud_contribution'] ?? '',
      trainingSupportNeeded: json['training_support_needed'] ?? '',
      ratingTechnicalKnowledge: json['rating_technical_knowledge'] ?? 0,
      ratingTeamwork: json['rating_teamwork'] ?? 0,
      ratingCommunication: json['rating_communication'] ?? 0,
      ratingPunctuality: json['rating_punctuality'] ?? 0,
      training: json['training'] ?? '',
      hike: json['hike'] ?? '',
      growthPath: json['growth_path'] ?? '',
    );
  }
}
