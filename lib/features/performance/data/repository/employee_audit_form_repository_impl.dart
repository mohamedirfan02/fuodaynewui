import 'package:fuoday/features/performance/data/models/employee_audit_form_model.dart';
import 'package:fuoday/features/performance/data/datasources/remote/employee_audit_form_remote_data_source.dart';
import 'package:fuoday/features/performance/domain/entities/employee_audit_form_entity.dart';
import 'package:fuoday/features/performance/domain/repository/employee_audit_form_repository.dart';

class EmployeeAuditFormRepositoryImpl implements EmployeeAuditFormRepository {
  final EmployeeAuditFormRemoteDataSource employeeAuditFormRemoteDataSource;

  EmployeeAuditFormRepositoryImpl({
    required this.employeeAuditFormRemoteDataSource,
  });

  @override
  Future<void> postEmployeeAuditForm(EmployeeAuditFormEntity entity) async {
    final model = EmployeeAuditFormModel(
      webUserId: entity.webUserId,
      auditCycleType: entity.auditCycleType,
      reviewPeriod: entity.reviewPeriod,
      auditMonth: entity.auditMonth,
      selfRating: entity.selfRating,
      technicalSkillsUsed: entity.technicalSkillsUsed,
      communicationCollaboration: entity.communicationCollaboration,
      crossFunctionalInvolvement: entity.crossFunctionalInvolvement,
      taskHighlight: entity.taskHighlight,
      personalHighlight: entity.personalHighlight,
      areasToImprove: entity.areasToImprove,
      initiativeTaken: entity.initiativeTaken,
      learningsCertifications: entity.learningsCertifications,
      suggestionsToCompany: entity.suggestionsToCompany,
      previousCycleGoals: entity.previousCycleGoals,
      goalAchievement: entity.goalAchievement,
      kpiMetrics: entity.kpiMetrics,
      projectsWorked: entity.projectsWorked,
      tasksModulesCompleted: entity.tasksModulesCompleted,
      performanceEvidences: entity.performanceEvidences,
    );

    return await employeeAuditFormRemoteDataSource.postEmployeeAuditForm(model);
  }
}
