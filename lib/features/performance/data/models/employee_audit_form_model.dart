import 'package:fuoday/features/performance/domain/entities/employee_audit_form_entity.dart';

class EmployeeAuditFormModel extends EmployeeAuditFormEntity {
  EmployeeAuditFormModel({
    required super.webUserId,
    super.auditCycleType,
    super.reviewPeriod,
    super.auditMonth,
    super.selfRating,
    super.technicalSkillsUsed,
    super.communicationCollaboration,
    super.crossFunctionalInvolvement,
    super.taskHighlight,
    super.personalHighlight,
    super.areasToImprove,
    super.initiativeTaken,
    super.learningsCertifications,
    super.suggestionsToCompany,
    super.previousCycleGoals,
    super.goalAchievement,
    super.kpiMetrics,
    super.projectsWorked,
    super.tasksModulesCompleted,
    super.performanceEvidences,
  });

  factory EmployeeAuditFormModel.fromJson(Map<String, dynamic> json) {
    return EmployeeAuditFormModel(
      webUserId: json['web_user_id'] ?? 0,
      auditCycleType: json['audit_cycle_type'],
      reviewPeriod: json['review_period'],
      auditMonth: json['audit_month'],
      selfRating: json['self_rating'],
      technicalSkillsUsed: json['technical_skills_used'],
      communicationCollaboration: json['communication_collaboration'],
      crossFunctionalInvolvement: json['cross_functional_involvement'],
      taskHighlight: json['task_highlight'],
      personalHighlight: json['personal_highlight'],
      areasToImprove: json['areas_to_improve'],
      initiativeTaken: json['initiative_taken'],
      learningsCertifications: json['learnings_certifications'],
      suggestionsToCompany: json['suggestions_to_company'],
      previousCycleGoals: json['previous_cycle_goals'],
      goalAchievement: json['goal_achievement'],
      kpiMetrics: json['kpi_metrics'],
      projectsWorked: json['projects_worked'],
      tasksModulesCompleted: json['tasks_modules_completed'],
      performanceEvidences: json['performance_evidences'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'web_user_id': webUserId,
      'audit_cycle_type': auditCycleType,
      'review_period': reviewPeriod,
      'audit_month': auditMonth,
      'self_rating': selfRating,
      'technical_skills_used': technicalSkillsUsed,
      'communication_collaboration': communicationCollaboration,
      'cross_functional_involvement': crossFunctionalInvolvement,
      'task_highlight': taskHighlight,
      'personal_highlight': personalHighlight,
      'areas_to_improve': areasToImprove,
      'initiative_taken': initiativeTaken,
      'learnings_certifications': learningsCertifications,
      'suggestions_to_company': suggestionsToCompany,
      'previous_cycle_goals': previousCycleGoals,
      'goal_achievement': goalAchievement,
      'kpi_metrics': kpiMetrics,
      'projects_worked': projectsWorked,
      'tasks_modules_completed': tasksModulesCompleted,
      'performance_evidences': performanceEvidences,
    };
  }
}
