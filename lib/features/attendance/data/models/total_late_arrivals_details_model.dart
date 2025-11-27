import 'package:fuoday/features/attendance/domain/entities/total_late_arrivals_details_entity.dart';

class TotalLateArrivalsDetailsModel extends TotalLateArrivalsDetailsEntity {
  TotalLateArrivalsDetailsModel({
    required super.employeeName,
    required super.totalLateArrivals,
    required super.totalLateMinutes,
    required super.averageLateMinutes,
    required super.totalLateHours,
    required super.recordsUpdated,
    required super.lateArrivalPercentage,
    required super.lateArrivalsDetails,
  });

  factory TotalLateArrivalsDetailsModel.fromJson(Map<String, dynamic> json) {
    return TotalLateArrivalsDetailsModel(
      employeeName: json['employee_name'],
      totalLateArrivals: json['total_late_arrivals'],
      totalLateMinutes: json['total_late_minutes'],
      averageLateMinutes: (json['average_late_minutes'] as num).toDouble(),
      totalLateHours: (json['total_late_hours'] as num).toDouble(),
      recordsUpdated: json['records_updated'],
      lateArrivalPercentage: (json['late_arrival_percentage'] as num)
          .toDouble(),
      lateArrivalsDetails: (json['late_arrivals_details'] as List)
          .map((e) => LateArrivalEntryModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employee_name': employeeName,
      'total_late_arrivals': totalLateArrivals,
      'total_late_minutes': totalLateMinutes,
      'average_late_minutes': averageLateMinutes,
      'total_late_hours': totalLateHours,
      'records_updated': recordsUpdated,
      'late_arrival_percentage': lateArrivalPercentage,
      'late_arrivals_details': lateArrivalsDetails
          .map((e) => (e as LateArrivalEntryModel).toJson())
          .toList(),
    };
  }
}

class LateArrivalEntryModel extends LateArrivalEntry {
  LateArrivalEntryModel({
    required super.date,
    required super.empName,
    required super.checkinTime,
    required super.minutesLate,
    required super.hoursMinutesLate,
    required super.currentStatus,
  });

  factory LateArrivalEntryModel.fromJson(Map<String, dynamic> json) {
    return LateArrivalEntryModel(
      date: json['date'],
      empName: json['emp_name'],
      checkinTime: json['checkin_time'],
      minutesLate: json['minutes_late'],
      hoursMinutesLate: json['hours_minutes_late'],
      currentStatus: json['current_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'emp_name': empName,
      'checkin_time': checkinTime,
      'minutes_late': minutesLate,
      'hours_minutes_late': hoursMinutesLate,
      'current_status': currentStatus,
    };
  }
}
