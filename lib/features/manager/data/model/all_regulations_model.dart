import 'package:fuoday/features/manager/domain/entities/all_regulations_entity.dart';

class AllRegulationsModel extends AllRegulationsEntity {
  AllRegulationsModel({
    super.status,
    super.hrSection,
    super.managerSection,
    super.teamSection,
  });

  factory AllRegulationsModel.fromJson(Map<String, dynamic> json) {
    return AllRegulationsModel(
      status: json['status'],
      hrSection: json['hr_section'] != null
          ? RegulationSectionModel.fromJson(json['hr_section'])
          : null,
      managerSection: json['manager_section'] != null
          ? RegulationSectionModel.fromJson(json['manager_section'])
          : null,
      teamSection: json['team_section'] != null
          ? RegulationSectionModel.fromJson(json['team_section'])
          : null,
    );
  }
}

class RegulationSectionModel extends RegulationSectionEntity {
  RegulationSectionModel({super.totalCount, super.data});

  factory RegulationSectionModel.fromJson(Map<String, dynamic> json) {
    return RegulationSectionModel(
      totalCount: json['total_count'] is String
          ? int.tryParse(json['total_count']) ?? 0
          : json['total_count'] ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => RegulationDataModel.fromJson(e))
          .toList(),
    );
  }
}

class RegulationDataModel extends RegulationDataEntity {
  RegulationDataModel({
    super.id,
    super.empId,
    super.empName,
    super.date,
    super.checkin,
    super.checkout,
    super.regulationCheckin,
    super.regulationCheckout,
    super.reason,
    super.regulationDate,
    super.regulationStatus,
    super.status,
    super.type,
    super.from,
    super.to,
    super.days,
    super.regulationComment,
    super.comment,
    super.displayType,
    super.reportingManagerId,
    super.reportingManagerName,
    super.teamLeaderId,
    super.teamLeaderName,
    super.managerRegulationStatus,
  });

  factory RegulationDataModel.fromJson(Map<String, dynamic> json) {
    return RegulationDataModel(
      id: json['id'] is String ? int.tryParse(json['id']) ?? 0 : json['id'],
      empId: json['emp_id']?.toString(),
      empName: json['emp_name']?.toString(),
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      checkin: json['checkin']?.toString(),
      checkout: json['checkout']?.toString(),
      regulationCheckin: json['regulation_checkin']?.toString(),
      regulationCheckout: json['regulation_checkout']?.toString(),
      reason: json['reason']?.toString(),
      regulationDate: json['regulation_date'] != null
          ? DateTime.tryParse(json['regulation_date'])
          : null,
      regulationStatus: json['regulation_status']?.toString(),
      status: json['status']?.toString(),
      type: json['type']?.toString(),
      from: json['from']?.toString(),
      to: json['to']?.toString(),
      days: json['days']?.toString(),
      regulationComment: json['regulation_comment']?.toString(),
      comment: json['comment']?.toString(),
      displayType: json['display_type']?.toString(),
      reportingManagerId: json['reporting_manager_id'] is String
          ? int.tryParse(json['reporting_manager_id']) ?? 0
          : json['reporting_manager_id'],
      reportingManagerName: json['reporting_manager_name']?.toString(),
      teamLeaderId: json['team_leader_id'] is String
          ? int.tryParse(json['team_leader_id']) ?? 0
          : json['team_leader_id'],
      teamLeaderName: json['team_leader_name']?.toString(),
      managerRegulationStatus: json['manager_regulation_status']?.toString(),
    );
  }
}
