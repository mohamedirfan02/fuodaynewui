class AuditReportEntity {
  final int id;
  final int webUserId;
  final String empName;
  final String empId;
  final String department;
  final String dateOfJoining;
  final String keyTasksCompleted;
  final String challengesFaced;
  final String proudContribution;
  final String trainingSupportNeeded;
  final int ratingTechnicalKnowledge;
  final int ratingTeamwork;
  final int ratingCommunication;
  final int ratingPunctuality;
  final String training;
  final String hike;
  final String growthPath;

  AuditReportEntity({
    required this.id,
    required this.webUserId,
    required this.empName,
    required this.empId,
    required this.department,
    required this.dateOfJoining,
    required this.keyTasksCompleted,
    required this.challengesFaced,
    required this.proudContribution,
    required this.trainingSupportNeeded,
    required this.ratingTechnicalKnowledge,
    required this.ratingTeamwork,
    required this.ratingCommunication,
    required this.ratingPunctuality,
    required this.training,
    required this.hike,
    required this.growthPath,
  });
}
