import 'dart:convert';

/// Root Entity representing attendance data grouped by role (HR, Manager, Team)
class AllRoleTotalAttendanceReportEntity {
  final AttendanceGroup hrSection;
  final AttendanceGroup managerSection;
  final AttendanceGroup teamSection;

  AllRoleTotalAttendanceReportEntity({
    required this.hrSection,
    required this.managerSection,
    required this.teamSection,
  });

  /// ✅ Easy accessors for UI or business logic
  List<AttendanceUserEntity> get hrList => hrSection.data;
  List<AttendanceUserEntity> get managerList => managerSection.data;
  List<AttendanceUserEntity> get teamsList => teamSection.data;

  /// ✅ Deserialize (for internal conversions only)
  factory AllRoleTotalAttendanceReportEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return AllRoleTotalAttendanceReportEntity(
      hrSection: AttendanceGroup.fromJson(json['hr_section'] ?? {}),
      managerSection: AttendanceGroup.fromJson(json['manager_section'] ?? {}),
      teamSection: AttendanceGroup.fromJson(json['team_section'] ?? {}),
    );
  }

  /// ✅ Serialize (for caching, debugging)
  Map<String, dynamic> toJson() => {
    'hr_section': hrSection.toJson(),
    'manager_section': managerSection.toJson(),
    'team_section': teamSection.toJson(),
  };

  @override
  String toString() {
    final encoder = const JsonEncoder.withIndent('  ');
    return 'AllRoleTotalAttendanceReportEntity:\n${encoder.convert(toJson())}';
  }
}

/// Represents each attendance group (HR / Manager / Team)
class AttendanceGroup {
  final int totalCount;
  final List<AttendanceUserEntity> data;

  AttendanceGroup({required this.totalCount, required this.data});

  factory AttendanceGroup.fromJson(Map<String, dynamic> json) {
    return AttendanceGroup(
      totalCount: json['total_count'] ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => AttendanceUserEntity.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'total_count': totalCount,
    'data': data.map((e) => e.toJson()).toList(),
  };

  @override
  String toString() =>
      'AttendanceGroup(totalCount: $totalCount, dataCount: ${data.length})';
}

/// Represents a single user's attendance record in domain layer
class AttendanceUserEntity {
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

  AttendanceUserEntity({
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

  factory AttendanceUserEntity.fromJson(Map<String, dynamic> json) {
    return AttendanceUserEntity(
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

  Map<String, dynamic> toJson() => {
    'name': name,
    'emp_id': empId,
    'date': date,
    'checkin': checkin,
    'checkout': checkout,
    'worked_hours': workedHours,
    'status': status,
    'reporting_manager_id': reportingManagerId,
    'reporting_manager_name': reportingManagerName,
    'team_id': teamId,
  };

  @override
  String toString() => 'AttendanceUserEntity(${jsonEncode(toJson())})';
}
