import 'package:fuoday/features/team_leader/domain/entities/all_role_total_attendance_report_entity.dart';

/// Model for All Role Attendance Report (Raw API → Model → Entity)
class AllRoleTotalAttendanceReportModel {
  final AttendanceGroupModel hrSection;
  final AttendanceGroupModel managerSection;
  final AttendanceGroupModel teamSection;

  AllRoleTotalAttendanceReportModel({
    required this.hrSection,
    required this.managerSection,
    required this.teamSection,
  });

  /// Factory constructor to parse API JSON
  factory AllRoleTotalAttendanceReportModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AllRoleTotalAttendanceReportModel(
      hrSection: AttendanceGroupModel.fromJson(json['hr_section'] ?? {}),
      managerSection: AttendanceGroupModel.fromJson(
        json['manager_section'] ?? {},
      ),
      teamSection: AttendanceGroupModel.fromJson(json['team_section'] ?? {}),
    );
  }

  /// Convert model → domain entity
  AllRoleTotalAttendanceReportEntity toEntity() {
    return AllRoleTotalAttendanceReportEntity(
      hrSection: hrSection.toEntity(),
      managerSection: managerSection.toEntity(),
      teamSection: teamSection.toEntity(),
    );
  }
}

/// Represents each attendance group section in the model
class AttendanceGroupModel {
  final int totalCount;
  final List<AttendanceUserModel> data;

  AttendanceGroupModel({required this.totalCount, required this.data});

  factory AttendanceGroupModel.fromJson(Map<String, dynamic> json) {
    return AttendanceGroupModel(
      totalCount: json['total_count'] ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => AttendanceUserModel.fromJson(e))
          .toList(),
    );
  }

  AttendanceGroup toEntity() => AttendanceGroup(
    totalCount: totalCount,
    data: data.map((e) => e.toEntity()).toList(),
  );
}

/// Represents a single attendance user record in model (API layer)
class AttendanceUserModel {
  final String name;
  final String empId;
  final String date;
  final String? checkin;
  final String? checkout;
  final String? workedHours;
  final String status;
  final int? reportingManagerId;
  final String? reportingManagerName;
  final int? teamId;

  AttendanceUserModel({
    required this.name,
    required this.empId,
    required this.date,
    required this.status,
    this.checkin,
    this.checkout,
    this.workedHours,
    this.reportingManagerId,
    this.reportingManagerName,
    this.teamId,
  });

  factory AttendanceUserModel.fromJson(Map<String, dynamic> json) {
    return AttendanceUserModel(
      name: json['name'] ?? '',
      empId: json['emp_id'] ?? '',
      date: json['date'] ?? '',
      checkin: json['checkin'],
      checkout: json['checkout'],
      workedHours: json['worked_hours'],
      status: json['status'] ?? '',
      reportingManagerId: json['reporting_manager_id'],
      reportingManagerName: json['reporting_manager_name'],
      teamId: json['team_id'],
    );
  }

  AttendanceUserEntity toEntity() => AttendanceUserEntity(
    name: name,
    empId: empId,
    date: date,
    checkin: checkin,
    checkout: checkout,
    workedHours: workedHours,
    status: status,
    reportingManagerId: reportingManagerId,
    reportingManagerName: reportingManagerName,
    teamId: teamId,
  );
}
