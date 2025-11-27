class EmployeeAuditFormEntity {
  final int webUserId;
  final String? auditCycleType;
  final String? reviewPeriod;
  final String? auditMonth;
  final String? selfRating;
  final String? technicalSkillsUsed;
  final String? communicationCollaboration;
  final String? crossFunctionalInvolvement;
  final String? taskHighlight;
  final String? personalHighlight;
  final String? areasToImprove;
  final String? initiativeTaken;
  final String? learningsCertifications;
  final String? suggestionsToCompany;
  final String? previousCycleGoals;
  final String? goalAchievement;
  final String? kpiMetrics;
  final String? projectsWorked;
  final String? tasksModulesCompleted;
  final String? performanceEvidences;

  EmployeeAuditFormEntity({
    required this.webUserId,
    this.auditCycleType,
    this.reviewPeriod,
    this.auditMonth,
    this.selfRating,
    this.technicalSkillsUsed,
    this.communicationCollaboration,
    this.crossFunctionalInvolvement,
    this.taskHighlight,
    this.personalHighlight,
    this.areasToImprove,
    this.initiativeTaken,
    this.learningsCertifications,
    this.suggestionsToCompany,
    this.previousCycleGoals,
    this.goalAchievement,
    this.kpiMetrics,
    this.projectsWorked,
    this.tasksModulesCompleted,
    this.performanceEvidences,
  });
}
