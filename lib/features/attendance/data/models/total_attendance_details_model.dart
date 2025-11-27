import 'package:fuoday/features/attendance/domain/entities/total_attendance_details_entity.dart';

class TotalAttendanceDetailsModel extends TotalAttendanceDetailsEntity {
  TotalAttendanceDetailsModel({
    String? message,
    String? status,
    AttendanceDataModel? data,
  }) : super(
    message: message,
    status: status,
    data: data,
  );

  factory TotalAttendanceDetailsModel.fromJson(Map<String, dynamic> json) {
    return TotalAttendanceDetailsModel(
      message: json['message'] as String?,
      status: json['status'] as String?,
      data: json['data'] != null
          ? AttendanceDataModel.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': (data as AttendanceDataModel?)?.toJson(),
    };
  }
}

class AttendanceDataModel extends AttendanceDataEntity {
  AttendanceDataModel({
    String? totalWorkedHours,
    List<DayAttendanceModel>? days,
    Map<String, int>? monthlyCounts,
    int? totalPresent,
    int? totalAbsent,
    int? totalLate,
    int? totalEarly,
    int? totalPermission,
    int? totalHalfDay,
    int? totalPunctual,
    int? totalLeave,
    int? totalHoliday,
    String? averageCheckinTime,
    String? averageCheckoutTime,
    double? averageAttendancePercent,
    String? bestMonth,
    List<MonthlyGraphModel>? graph,
  }) : super(
    totalWorkedHours: totalWorkedHours,
    days: days,
    monthlyCounts: monthlyCounts,
    totalPresent: totalPresent,
    totalAbsent: totalAbsent,
    totalLate: totalLate,
    totalEarly: totalEarly,
    totalPermission: totalPermission,
    totalHalfDay: totalHalfDay,
    totalPunctual: totalPunctual,
    totalLeave: totalLeave,
    totalHoliday: totalHoliday,
    averageCheckinTime: averageCheckinTime,
    averageCheckoutTime: averageCheckoutTime,
    averageAttendancePercent: averageAttendancePercent,
    bestMonth: bestMonth,
    graph: graph,
  );

  factory AttendanceDataModel.fromJson(Map<String, dynamic> json) {
    return AttendanceDataModel(
      totalWorkedHours: json['total_worked_hours'] as String?,
      days: (json['days'] as List?)
          ?.map((e) => DayAttendanceModel.fromJson(e))
          .toList() ??
          [],
      monthlyCounts: json['monthly_counts'] != null
          ? Map<String, int>.from(json['monthly_counts'])
          : {},
      totalPresent: json['total_present'] as int?,
      totalAbsent: json['total_absent'] as int?,
      totalLate: json['total_late'] as int?,
      totalEarly: json['total_early'] as int?,
      totalPermission: json['total_permission'] as int?,
      totalHalfDay: json['total_half_day'] as int?,
      totalPunctual: json['total_punctual'] as int?,
      totalLeave: json['total_leave'] as int?,
      totalHoliday: json['total_holiday'] as int?,
      averageCheckinTime: json['average_checkin_time'] as String?,
      averageCheckoutTime: json['average_checkout_time'] as String?,
      averageAttendancePercent:
      (json['average_attendance_percent'] as num?)?.toDouble(),
      bestMonth: json['best_month'] as String?,
      graph: (json['graph'] as List?)
          ?.map((e) => MonthlyGraphModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_worked_hours': totalWorkedHours,
      'days': days?.map((e) => (e as DayAttendanceModel).toJson()).toList() ?? [],
      'monthly_counts': monthlyCounts ?? {},
      'total_present': totalPresent,
      'total_absent': totalAbsent,
      'total_late': totalLate,
      'total_early': totalEarly,
      'total_permission': totalPermission,
      'total_half_day': totalHalfDay,
      'total_punctual': totalPunctual,
      'total_leave': totalLeave,
      'total_holiday': totalHoliday,
      'average_checkin_time': averageCheckinTime,
      'average_checkout_time': averageCheckoutTime,
      'average_attendance_percent': averageAttendancePercent,
      'best_month': bestMonth,
      'graph':
      graph?.map((e) => (e as MonthlyGraphModel).toJson()).toList() ?? [],
    };
  }
}

class DayAttendanceModel extends DayAttendanceEntity {
  DayAttendanceModel({
    String? date,
    String? day,
    String? checkin,
    String? checkout,
    String? status,
    String? regulationStatus,
    String? workedHours,
  }) : super(
    date: date,
    day: day,
    checkin: checkin,
    checkout: checkout,
    status: status,
    regulationStatus: regulationStatus,
    workedHours: workedHours,
  );

  factory DayAttendanceModel.fromJson(Map<String, dynamic> json) {
    return DayAttendanceModel(
      date: json['date'] as String?,
      day: json['day'] as String?,
      checkin: json['checkin'] as String?,
      checkout: json['checkout'] as String?,
      status: json['status'] as String?,
      regulationStatus: json['regulation_status'] as String?,
      workedHours: json['worked_hours'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'day': day,
      'checkin': checkin,
      'checkout': checkout,
      'status': status,
      'regulation_status': regulationStatus,
      'worked_hours': workedHours,
    };
  }
}

class MonthlyGraphModel extends MonthlyGraphEntity {
  MonthlyGraphModel({
    String? month,
    int? present,
    int? absent,
    int? permission,
    int? leave,
  }) : super(
    month: month,
    present: present,
    absent: absent,
    permission: permission,
    leave: leave,
  );

  factory MonthlyGraphModel.fromJson(Map<String, dynamic> json) {
    return MonthlyGraphModel(
      month: json['month'] as String?,
      present: json['present'] as int?,
      absent: json['absent'] as int?,
      permission: json['permission'] as int?,
      leave: json['leave'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'present': present,
      'absent': absent,
      'permission': permission,
      'leave': leave,
    };
  }
}
