//=============================================
// Domain Layer: ENTITIES
//=============================================
class LateArrivalsEntity {
  final String status;
  final String message;
  final SectionEntity hrSection;
  final SectionEntity managerSection;
  final SectionEntity teamSection;

  LateArrivalsEntity({
    required this.status,
    required this.message,
    required this.hrSection,
    required this.managerSection,
    required this.teamSection,
  });
}

class SectionEntity {
  final int totalCount;
  final SummaryStatsEntity summaryStats;
  final List<EmployeeEntity> employees;

  SectionEntity({
    required this.totalCount,
    required this.summaryStats,
    required this.employees,
  });
}

class SummaryStatsEntity {
  final int totalEmployees;
  final int employeesWithLateArrivals;
  final int totalLateInstances;
  final int totalLateMinutes;

  SummaryStatsEntity({
    required this.totalEmployees,
    required this.employeesWithLateArrivals,
    required this.totalLateInstances,
    required this.totalLateMinutes,
  });
}

class EmployeeEntity {
  final int employeeId;
  final String employeeName;
  final String? department;
  final String? reportingManagerId;
  final String? reportingManagerName;
  final int lateCount;
  final int totalLateMinutes;
  final double averageLateMinutes;
  final double lateArrivalPercentage;
  final int recordsUpdated;
  final List<LateArrivalRecordEntity> lateArrivals;

  EmployeeEntity({
    required this.employeeId,
    required this.employeeName,
    this.department,
    this.reportingManagerId,
    this.reportingManagerName,
    required this.lateCount,
    required this.totalLateMinutes,
    required this.averageLateMinutes,
    required this.lateArrivalPercentage,
    required this.recordsUpdated,
    required this.lateArrivals,
  });
}

class LateArrivalRecordEntity {
  final String date;
  final String checkinTime;
  final int minutesLate;
  final String hoursMinutesLate;
  final String currentStatus;

  LateArrivalRecordEntity({
    required this.date,
    required this.checkinTime,
    required this.minutesLate,
    required this.hoursMinutesLate,
    required this.currentStatus,
  });
}
