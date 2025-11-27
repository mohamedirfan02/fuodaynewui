import 'package:fuoday/features/attendance/domain/entities/total_early_arrivals_details_entity.dart';

class EarlyArrivalsDetailsModel extends EarlyArrivalsEntity {
  EarlyArrivalsDetailsModel({
    super.message,
    super.status,
    EarlyArrivalDataModel? super.data,
  });

  factory EarlyArrivalsDetailsModel.fromJson(Map<String, dynamic> json) {
    return EarlyArrivalsDetailsModel(
      message: json['message'] as String?,
      status: json['status'] as String?,
      data: json['data'] != null
          ? EarlyArrivalDataModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': (data as EarlyArrivalDataModel?)?.toJson(),
    };
  }
}

class EarlyArrivalDataModel extends EarlyArrivalDataEntity {
  EarlyArrivalDataModel({
    super.employeeName,
    super.totalEarlyArrivals,
    super.totalEarlyMinutes,
    super.averageEarlyMinutes,
    super.totalEarlyHours,
    super.recordsUpdated,
    super.earlyArrivalPercentage,
    List<EarlyArrivalDetailModel>? super.earlyArrivalsDetails,
  });

  factory EarlyArrivalDataModel.fromJson(Map<String, dynamic> json) {
    return EarlyArrivalDataModel(
      employeeName: json['employee_name'] as String?,
      totalEarlyArrivals: (json['total_early_arrivals'] as num?)?.toInt(),
      totalEarlyMinutes: (json['total_early_minutes'] as num?)?.toInt(),
      averageEarlyMinutes: (json['average_early_minutes'] as num?)?.toDouble(),
      totalEarlyHours: (json['total_early_hours'] as num?)?.toDouble(),
      recordsUpdated: (json['records_updated'] as num?)?.toInt(),
      earlyArrivalPercentage: (json['early_arrival_percentage'] as num?)?.toInt(),
      earlyArrivalsDetails:
      (json['early_arrivals_details'] as List?)
          ?.map((e) => EarlyArrivalDetailModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employee_name': employeeName,
      'total_early_arrivals': totalEarlyArrivals,
      'total_early_minutes': totalEarlyMinutes,
      'average_early_minutes': averageEarlyMinutes,
      'total_early_hours': totalEarlyHours,
      'records_updated': recordsUpdated,
      'early_arrival_percentage': earlyArrivalPercentage,
      'early_arrivals_details': earlyArrivalsDetails
          ?.map((e) => (e as EarlyArrivalDetailModel).toJson())
          .toList(),
    };
  }
}

class EarlyArrivalDetailModel extends EarlyArrivalDetailEntity {
  EarlyArrivalDetailModel({
    super.date,
    super.empName,
    super.checkinTime,
    super.minutesEarly,
    super.hoursMinutesEarly,
    super.currentStatus,
  });

  factory EarlyArrivalDetailModel.fromJson(Map<String, dynamic> json) {
    return EarlyArrivalDetailModel(
      date: json['date'] as String?,
      empName: json['emp_name'] as String?,
      checkinTime: json['checkin_time'] as String?,
      minutesEarly: (json['minutes_early'] as num?)?.toInt(),
      hoursMinutesEarly: json['hours_minutes_early'] as String?,
      currentStatus: json['current_status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'emp_name': empName,
      'checkin_time': checkinTime,
      'minutes_early': minutesEarly,
      'hours_minutes_early': hoursMinutesEarly,
      'current_status': currentStatus,
    };
  }
}
