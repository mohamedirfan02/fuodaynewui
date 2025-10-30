import 'package:fuoday/features/team_leader/domain/entities/all_leave_requests_entity.dart';

/// 🔹 Model representing the API data for all leave requests
class AllLeaveRequestsModel extends AllLeaveRequestsEntity {
  AllLeaveRequestsModel({
    super.status,
    super.message,
    super.hrSection,
    super.managerSection,
    super.teamSection,
  });

  /// ✅ Now accepts `Map<String, dynamic>` — not `List`
  factory AllLeaveRequestsModel.fromJson(Map<String, dynamic> json) {
    return AllLeaveRequestsModel(
      status: json['status'],
      message: json['message'],
      hrSection: json['hr_section'] != null
          ? LeaveSectionModel.fromJson(json['hr_section'])
          : null,
      managerSection: json['manager_section'] != null
          ? LeaveSectionModel.fromJson(json['manager_section'])
          : null,
      teamSection: json['team_section'] != null
          ? LeaveSectionModel.fromJson(json['team_section'])
          : null,
    );
  }
}

/// 🔹 Model for a section (HR, Manager, Team)
class LeaveSectionModel extends LeaveSectionEntity {
  LeaveSectionModel({
    super.totalCount,
    super.data,
  });

  factory LeaveSectionModel.fromJson(Map<String, dynamic> json) {
    return LeaveSectionModel(
      totalCount: json['total_count'],
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => LeaveRequestDataModel.fromJson(e))
          .toList(),
    );
  }
}

/// 🔹 Model for a single leave record
class LeaveRequestDataModel extends LeaveRequestData {
  LeaveRequestDataModel({
    super.id,
    super.webUserId,
    super.name,
    super.empId,
    super.date,
    super.type,
    super.from,
    super.to,
    super.reason,
    super.permissionTiming,
    super.hrStatus,
    super.managerStatus,
    super.status,
    super.regulationDate,
    super.regulationReason,
  });

  factory LeaveRequestDataModel.fromJson(Map<String, dynamic> json) {
    return LeaveRequestDataModel(
      id: json['id'],
      webUserId: json['web_user_id'],
      name: json['name'],
      empId: json['emp_id'],
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      type: json['type'],
      from: json['from'] != null ? DateTime.tryParse(json['from']) : null,
      to: json['to'] != null ? DateTime.tryParse(json['to']) : null,
      reason: json['reason'],
      permissionTiming: json['permission_timing'],
      hrStatus: json['hr_status'],
      managerStatus: json['manager_status'],
      status: json['status'],
      regulationDate: json['regulation_date'] != null
          ? DateTime.tryParse(json['regulation_date'])
          : null,
      regulationReason: json['regulation_reason'],
    );
  }
}
