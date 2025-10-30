class AllLeaveRequestsEntity {
  final String? status;
  final String? message;
  final LeaveSectionEntity? hrSection;
  final LeaveSectionEntity? managerSection;
  final LeaveSectionEntity? teamSection;

  AllLeaveRequestsEntity({
    this.status,
    this.message,
    this.hrSection,
    this.managerSection,
    this.teamSection,
  });

  factory AllLeaveRequestsEntity.fromJson(Map<String, dynamic> json) {
    return AllLeaveRequestsEntity(
      status: json['status'],
      message: json['message'],
      hrSection: json['hr_section'] != null
          ? LeaveSectionEntity.fromJson(json['hr_section'])
          : null,
      managerSection: json['manager_section'] != null
          ? LeaveSectionEntity.fromJson(json['manager_section'])
          : null,
      teamSection: json['team_section'] != null
          ? LeaveSectionEntity.fromJson(json['team_section'])
          : null,
    );
  }
}

class LeaveSectionEntity {
  final int? totalCount;
  final List<LeaveRequestData>? data;

  LeaveSectionEntity({
    this.totalCount,
    this.data,
  });

  factory LeaveSectionEntity.fromJson(Map<String, dynamic> json) {
    return LeaveSectionEntity(
      totalCount: json['total_count'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LeaveRequestData.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class LeaveRequestData {
  final int? id;
  final int? webUserId;
  final String? name;
  final String? empId;
  final DateTime? date;
  final String? type;
  final DateTime? from;
  final DateTime? to;
  final String? reason;
  final String? permissionTiming;
  final String? hrStatus;
  final String? managerStatus;
  final String? status;
  final DateTime? regulationDate;
  final String? regulationReason;

  LeaveRequestData({
    this.id,
    this.webUserId,
    this.name,
    this.empId,
    this.date,
    this.type,
    this.from,
    this.to,
    this.reason,
    this.permissionTiming,
    this.hrStatus,
    this.managerStatus,
    this.status,
    this.regulationDate,
    this.regulationReason,
  });

  factory LeaveRequestData.fromJson(Map<String, dynamic> json) {
    return LeaveRequestData(
      id: json['id'],
      webUserId: json['web_user_id'],
      name: json['name'],
      empId: json['emp_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      type: json['type'],
      from: json['from'] != null ? DateTime.parse(json['from']) : null,
      to: json['to'] != null ? DateTime.parse(json['to']) : null,
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
