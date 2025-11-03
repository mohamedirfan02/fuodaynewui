class UpdateRegulationStatusEntity {
  final String? message;
  final String? status;
  final UpdatedRegulationEntity? data;

  UpdateRegulationStatusEntity({this.message, this.status, this.data});
}

class UpdatedRegulationEntity {
  final int? id;
  final int? webUserId;
  final String? empName;
  final String? empId;
  final String? date;
  final String? checkin;
  final String? checkout;
  final String? workedHours;
  final String? regulationCheckin;
  final String? regulationCheckout;
  final String? regulationDate;
  final String? regulationStatus;
  final String? reason;
  final String? status;
  final String? hrRegulationStatus;
  final String? managerRegulationStatus;
  final String? createdAt;
  final String? updatedAt;

  UpdatedRegulationEntity({
    this.id,
    this.webUserId,
    this.empName,
    this.empId,
    this.date,
    this.checkin,
    this.checkout,
    this.workedHours,
    this.regulationCheckin,
    this.regulationCheckout,
    this.regulationDate,
    this.regulationStatus,
    this.reason,
    this.status,
    this.hrRegulationStatus,
    this.managerRegulationStatus,
    this.createdAt,
    this.updatedAt,
  });
}
