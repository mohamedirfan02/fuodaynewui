// lib/features/manager/domain/entities/all_regulations_entity.dart

class AllRegulationsEntity {
  final String? status;
  final RegulationSectionEntity? hrSection;
  final RegulationSectionEntity? managerSection;
  final RegulationSectionEntity? teamSection;

  AllRegulationsEntity({
    this.status,
    this.hrSection,
    this.managerSection,
    this.teamSection,
  });
}

class RegulationSectionEntity {
  final int? totalCount;
  final List<RegulationDataEntity>? data;

  RegulationSectionEntity({this.totalCount, this.data});
}

class RegulationDataEntity {
  final int? id;
  final String? empId;
  final String? empName;

  // For attendance type
  final DateTime? date;
  final String? checkin;
  final String? checkout;
  final String? regulationCheckin;
  final String? regulationCheckout;

  // Common fields
  final String? reason;
  final DateTime? regulationDate;
  final String? regulationStatus;
  final String? status;
  final String? type;

  // For leave type
  final String? from;
  final String? to;
  final String? days;
  final String? regulationComment;
  final String? comment;
  final String? displayType;

  // Manager-level fields
  final int? reportingManagerId;
  final String? reportingManagerName;

  // Team-level fields
  final int? teamLeaderId;
  final String? teamLeaderName;

  // Additional manager-specific field
  final String? managerRegulationStatus;

  RegulationDataEntity({
    this.id,
    this.empId,
    this.empName,
    this.date,
    this.checkin,
    this.checkout,
    this.regulationCheckin,
    this.regulationCheckout,
    this.reason,
    this.regulationDate,
    this.regulationStatus,
    this.status,
    this.type,
    this.from,
    this.to,
    this.days,
    this.regulationComment,
    this.comment,
    this.displayType,
    this.reportingManagerId,
    this.reportingManagerName,
    this.teamLeaderId,
    this.teamLeaderName,
    this.managerRegulationStatus,
  });
}
