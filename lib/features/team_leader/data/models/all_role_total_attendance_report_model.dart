// ============================================
// FILE 1: all_role_total_attendance_report_model.dart
// ============================================

import 'package:fuoday/core/helper/app_logger_helper.dart';
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
    try {
      AppLoggerHelper.logInfo("🔄 Parsing AllRoleTotalAttendanceReportModel");

      return AllRoleTotalAttendanceReportModel(
        hrSection: AttendanceGroupModel.fromJson(json['hr_section'] ?? {}),
        managerSection: AttendanceGroupModel.fromJson(
          json['manager_section'] ?? {},
        ),
        teamSection: AttendanceGroupModel.fromJson(json['team_section'] ?? {}),
      );
    } catch (e, stackTrace) {
      AppLoggerHelper.logError(
        "❌ Error parsing AllRoleTotalAttendanceReportModel: $e",
      );
      AppLoggerHelper.logError("Stack trace: $stackTrace");
      rethrow;
    }
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
    try {
      final dataList = json['data'] as List<dynamic>? ?? [];
      AppLoggerHelper.logInfo(
        "🔄 Parsing ${dataList.length} attendance records",
      );

      return AttendanceGroupModel(
        totalCount: json['total_count'] ?? 0,
        data: dataList.map((e) => AttendanceUserModel.fromJson(e)).toList(),
      );
    } catch (e, stackTrace) {
      AppLoggerHelper.logError("❌ Error parsing AttendanceGroupModel: $e");
      AppLoggerHelper.logError("Stack trace: $stackTrace");
      rethrow;
    }
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
    try {
      // Debug log to see the actual data types
      final reportingManagerIdRaw = json['reporting_manager_id'];
      final teamIdRaw = json['team_id'];

      AppLoggerHelper.logInfo(
        "🔍 Parsing user: ${json['name']}, "
        "reporting_manager_id type: ${reportingManagerIdRaw.runtimeType} (value: $reportingManagerIdRaw), "
        "team_id type: ${teamIdRaw.runtimeType} (value: $teamIdRaw)",
      );

      return AttendanceUserModel(
        name: json['name'] ?? '',
        empId: json['emp_id'] ?? '',
        date: json['date'] ?? '',
        checkin: json['checkin'],
        checkout: json['checkout'],
        workedHours: json['worked_hours'],
        status: json['status'] ?? '',
        reportingManagerId: _parseNullableInt(json['reporting_manager_id']),
        reportingManagerName: json['reporting_manager_name'],
        teamId: _parseNullableInt(json['team_id']),
      );
    } catch (e, stackTrace) {
      AppLoggerHelper.logError(
        "❌ Error parsing AttendanceUserModel for ${json['name']}: $e",
      );
      AppLoggerHelper.logError("JSON data: $json");
      AppLoggerHelper.logError("Stack trace: $stackTrace");
      rethrow;
    }
  }

  /// Helper method to safely parse nullable int values
  static int? _parseNullableInt(dynamic value) {
    if (value == null) return null;

    if (value is int) return value;

    if (value is String) {
      final trimmed = value.trim();
      if (trimmed.isEmpty) return null;
      return int.tryParse(trimmed);
    }

    if (value is double) return value.toInt();

    AppLoggerHelper.logWarning(
      "⚠️ Unexpected type for int parsing: ${value.runtimeType} (value: $value)",
    );
    return null;
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
