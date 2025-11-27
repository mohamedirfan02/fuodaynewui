import 'package:fuoday/features/attendance/domain/entities/total_absent_details_entity.dart';

class TotalAbsentDetailsModel extends TotalAbsentDetailsEntity {
  TotalAbsentDetailsModel({
    super.message,
    super.status,
    AbsentDataModel? data,
  }) : super(data: data);

  factory TotalAbsentDetailsModel.fromJson(Map<String, dynamic> json) {
    return TotalAbsentDetailsModel(
      message: json['message'],
      status: json['status'],
      data: json['data'] != null
          ? AbsentDataModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': (data as AbsentDataModel?)?.toJson(),
    };
  }
}

class AbsentDataModel extends AbsentDataEntity {
  AbsentDataModel({
    super.employeeName,
    super.totalAbsentDays,
    super.absentPercentage,
    List<AbsentRecordModel>? absentRecords,
  }) : super(absentRecords: absentRecords);

  factory AbsentDataModel.fromJson(Map<String, dynamic> json) {
    return AbsentDataModel(
      employeeName: json['employee_name'],
      totalAbsentDays: json['total_absent_days'],
      absentPercentage: json['absent_percentage'],
      absentRecords: (json['absent_records'] as List<dynamic>?)
          ?.map((e) => AbsentRecordModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employee_name': employeeName,
      'total_absent_days': totalAbsentDays,
      'absent_percentage': absentPercentage,
      'absent_records':
      (absentRecords as List<AbsentRecordModel>?)?.map((e) => e.toJson()).toList(),
    };
  }
}

class AbsentRecordModel extends AbsentRecordEntity {
  AbsentRecordModel({
    super.date,
    super.empName,
    super.checkin,
    super.status,
  });

  factory AbsentRecordModel.fromJson(Map<String, dynamic> json) {
    return AbsentRecordModel(
      date: json['date'],
      empName: json['emp_name'],
      checkin: json['checkin'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'emp_name': empName,
      'checkin': checkin,
      'status': status,
    };
  }
}
