//=============================================
// Data Layer: MODEL
//=============================================
import 'package:fuoday/features/team_leader/domain/entities/late_arrivals_entity.dart';

class LateArrivalsModel {
  final String status;
  final String message;
  final SectionModel hrSection;
  final SectionModel managerSection;
  final SectionModel teamSection;

  LateArrivalsModel({
    required this.status,
    required this.message,
    required this.hrSection,
    required this.managerSection,
    required this.teamSection,
  });

  factory LateArrivalsModel.fromJson(Map<String, dynamic> json) {
    return LateArrivalsModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      hrSection: SectionModel.fromJson(json['hr_section'] ?? {}),
      managerSection: SectionModel.fromJson(json['manager_section'] ?? {}),
      teamSection: SectionModel.fromJson(json['team_section'] ?? {}),
    );
  }

  LateArrivalsEntity toEntity() => LateArrivalsEntity(
    status: status,
    message: message,
    hrSection: hrSection.toEntity(),
    managerSection: managerSection.toEntity(),
    teamSection: teamSection.toEntity(),
  );
}

class SectionModel {
  final int totalCount;
  final SummaryStatsModel summaryStats;
  final List<EmployeeModel> employees;

  SectionModel({
    required this.totalCount,
    required this.summaryStats,
    required this.employees,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      totalCount: json['total_count'] ?? 0,
      summaryStats: SummaryStatsModel.fromJson(json['summary_stats'] ?? {}),
      employees: (json['employees'] as List<dynamic>? ?? [])
          .map((e) => EmployeeModel.fromJson(e))
          .toList(),
    );
  }

  SectionEntity toEntity() => SectionEntity(
    totalCount: totalCount,
    summaryStats: summaryStats.toEntity(),
    employees: employees.map((e) => e.toEntity()).toList(),
  );
}

class SummaryStatsModel {
  final int totalEmployees;
  final int employeesWithLateArrivals;
  final int totalLateInstances;
  final int totalLateMinutes;

  SummaryStatsModel({
    required this.totalEmployees,
    required this.employeesWithLateArrivals,
    required this.totalLateInstances,
    required this.totalLateMinutes,
  });

  factory SummaryStatsModel.fromJson(Map<String, dynamic> json) {
    return SummaryStatsModel(
      totalEmployees: json['total_employees'] ?? 0,
      employeesWithLateArrivals: json['employees_with_late_arrivals'] ?? 0,
      totalLateInstances: json['total_late_instances'] ?? 0,
      totalLateMinutes: json['total_late_minutes'] ?? 0,
    );
  }

  SummaryStatsEntity toEntity() => SummaryStatsEntity(
    totalEmployees: totalEmployees,
    employeesWithLateArrivals: employeesWithLateArrivals,
    totalLateInstances: totalLateInstances,
    totalLateMinutes: totalLateMinutes,
  );
}

class EmployeeModel {
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
  final List<LateArrivalRecordModel> lateArrivals;

  EmployeeModel({
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

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      employeeId: json['employee_id'] ?? 0,
      employeeName: json['employee_name'] ?? '',
      department: json['department'],
      reportingManagerId: json['reporting_manager_id'],
      reportingManagerName: json['reporting_manager_name'],
      lateCount: json['late_count'] ?? 0,
      totalLateMinutes: json['total_late_minutes'] ?? 0,
      averageLateMinutes:
      (json['average_late_minutes'] as num?)?.toDouble() ?? 0.0,
      lateArrivalPercentage:
      (json['late_arrival_percentage'] as num?)?.toDouble() ?? 0.0,
      recordsUpdated: json['records_updated'] ?? 0,
      lateArrivals: (json['late_arrivals'] as List<dynamic>? ?? [])
          .map((e) => LateArrivalRecordModel.fromJson(e))
          .toList(),
    );
  }

  EmployeeEntity toEntity() => EmployeeEntity(
    employeeId: employeeId,
    employeeName: employeeName,
    department: department,
    reportingManagerId: reportingManagerId,
    reportingManagerName: reportingManagerName,
    lateCount: lateCount,
    totalLateMinutes: totalLateMinutes,
    averageLateMinutes: averageLateMinutes,
    lateArrivalPercentage: lateArrivalPercentage,
    recordsUpdated: recordsUpdated,
    lateArrivals: lateArrivals.map((e) => e.toEntity()).toList(),
  );
}

class LateArrivalRecordModel {
  final String date;
  final String checkinTime;
  final int minutesLate;
  final String hoursMinutesLate;
  final String currentStatus;

  LateArrivalRecordModel({
    required this.date,
    required this.checkinTime,
    required this.minutesLate,
    required this.hoursMinutesLate,
    required this.currentStatus,
  });

  factory LateArrivalRecordModel.fromJson(Map<String, dynamic> json) {
    return LateArrivalRecordModel(
      date: json['date'] ?? '',
      checkinTime: json['checkin_time'] ?? '',
      minutesLate: json['minutes_late'] ?? 0,
      hoursMinutesLate: json['hours_minutes_late'] ?? '',
      currentStatus: json['current_status'] ?? '',
    );
  }

  LateArrivalRecordEntity toEntity() => LateArrivalRecordEntity(
    date: date,
    checkinTime: checkinTime,
    minutesLate: minutesLate,
    hoursMinutesLate: hoursMinutesLate,
    currentStatus: currentStatus,
  );
}
