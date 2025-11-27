import 'package:fuoday/features/manager/domain/entities/update_regulation_status_entity.dart';

class UpdateRegulationStatusModel {
  final String? message;
  final String? status;
  final UpdatedRegulationData? data;

  UpdateRegulationStatusModel({this.message, this.status, this.data});

  factory UpdateRegulationStatusModel.fromJson(Map<String, dynamic> json) {
    return UpdateRegulationStatusModel(
      message: json['message'] as String?,
      status: json['status'] as String?,
      data: json['data'] != null
          ? UpdatedRegulationData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class UpdatedRegulationData {
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

  UpdatedRegulationData({
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

  factory UpdatedRegulationData.fromJson(Map<String, dynamic> json) {
    return UpdatedRegulationData(
      id: json['id'],
      webUserId: json['web_user_id'],
      empName: json['emp_name'],
      empId: json['emp_id'],
      date: json['date'],
      checkin: json['checkin'],
      checkout: json['checkout'],
      workedHours: json['worked_hours'],
      regulationCheckin: json['regulation_checkin'],
      regulationCheckout: json['regulation_checkout'],
      regulationDate: json['regulation_date'],
      regulationStatus: json['regulation_status'],
      reason: json['reason'],
      status: json['status'],
      hrRegulationStatus: json['hr_regulation_status'],
      managerRegulationStatus: json['manager_regulation_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "web_user_id": webUserId,
    "emp_name": empName,
    "emp_id": empId,
    "date": date,
    "checkin": checkin,
    "checkout": checkout,
    "worked_hours": workedHours,
    "regulation_checkin": regulationCheckin,
    "regulation_checkout": regulationCheckout,
    "regulation_date": regulationDate,
    "regulation_status": regulationStatus,
    "reason": reason,
    "status": status,
    "hr_regulation_status": hrRegulationStatus,
    "manager_regulation_status": managerRegulationStatus,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

/// Mapper: Model → Entity
extension UpdateRegulationStatusMapper on UpdateRegulationStatusModel {
  UpdateRegulationStatusEntity toEntity() => UpdateRegulationStatusEntity(
    message: message,
    status: status,
    data: data != null
        ? UpdatedRegulationEntity(
            id: data?.id,
            webUserId: data?.webUserId,
            empName: data?.empName,
            empId: data?.empId,
            date: data?.date,
            checkin: data?.checkin,
            checkout: data?.checkout,
            workedHours: data?.workedHours,
            regulationCheckin: data?.regulationCheckin,
            regulationCheckout: data?.regulationCheckout,
            regulationDate: data?.regulationDate,
            regulationStatus: data?.regulationStatus,
            reason: data?.reason,
            status: data?.status,
            hrRegulationStatus: data?.hrRegulationStatus,
            managerRegulationStatus: data?.managerRegulationStatus,
            createdAt: data?.createdAt,
            updatedAt: data?.updatedAt,
          )
        : null,
  );
}
