import 'package:fuoday/features/manager/domain/entities/update_leave_status_entity.dart';

class UpdateLeaveStatusModel {
  final String? message;
  final String? status;
  final String? access;
  final UpdatedLeaveData? data;

  UpdateLeaveStatusModel({
    this.message,
    this.status,
    this.access,
    this.data,
  });

  factory UpdateLeaveStatusModel.fromJson(Map<String, dynamic> json) {
    return UpdateLeaveStatusModel(
      message: json['message'] as String?,
      status: json['status'] as String?,
      data: json['data'] != null
          ? UpdatedLeaveData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data?.toJson(),
  };
}

class UpdatedLeaveData {
  final int? id;
  final String? empName;
  final String? type;
  final String? from;
  final String? to;
  final String? reason;
  final String? status;

  UpdatedLeaveData({
    this.id,
    this.empName,
    this.type,
    this.from,
    this.to,
    this.reason,
    this.status,
  });

  factory UpdatedLeaveData.fromJson(Map<String, dynamic> json) {
    return UpdatedLeaveData(
      id: json['id'],
      empName: json['emp_name'],
      type: json['type'],
      from: json['from'],
      to: json['to'],
      reason: json['reason'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "emp_name": empName,
    "type": type,
    "from": from,
    "to": to,
    "reason": reason,
    "status": status,
  };
}

/// ✅ Add this mapper extension to convert Model → Entity
extension UpdateLeaveStatusMapper on UpdateLeaveStatusModel {
  UpdateLeaveStatusEntity toEntity() => UpdateLeaveStatusEntity(
    message: message,
    status: status,
    data: data != null
        ? UpdatedLeaveEntity(
      id: data?.id,
      empName: data?.empName,
      type: data?.type,
      from: data?.from,
      to: data?.to,
      reason: data?.reason,
      status: data?.status,
    )
        : null,
  );
}
