class TotalAttendanceDetailsEntity {
  final String? message;
  final String? status;
  final AttendanceDataEntity? data;

  TotalAttendanceDetailsEntity({
    this.message,
    this.status,
    this.data,
  });
}

class AttendanceDataEntity {
  final String? totalWorkedHours;
  final List<DayAttendanceEntity>? days;
  final Map<String, int>? monthlyCounts;
  final int? totalPresent;
  final int? totalAbsent;
  final int? totalLate;
  final int? totalEarly;
  final int? totalPermission;
  final int? totalHalfDay;
  final int? totalPunctual;
  final int? totalLeave;
  final int? totalHoliday;
  final String? averageCheckinTime;
  final String? averageCheckoutTime;
  final double? averageAttendancePercent;
  final String? bestMonth;
  final List<MonthlyGraphEntity>? graph;

  AttendanceDataEntity({
    this.totalWorkedHours,
    this.days,
    this.monthlyCounts,
    this.totalPresent,
    this.totalAbsent,
    this.totalLate,
    this.totalEarly,
    this.totalPermission,
    this.totalHalfDay,
    this.totalPunctual,
    this.totalLeave,
    this.totalHoliday,
    this.averageCheckinTime,
    this.averageCheckoutTime,
    this.averageAttendancePercent,
    this.bestMonth,
    this.graph,
  });
}

class DayAttendanceEntity {
  final String? date;
  final String? day;
  final String? checkin;
  final String? checkout;
  final String? status;
  final String? regulationStatus;
  final String? workedHours;

  DayAttendanceEntity({
    this.date,
    this.day,
    this.checkin,
    this.checkout,
    this.status,
    this.regulationStatus,
    this.workedHours,
  });
}

class MonthlyGraphEntity {
  final String? month;
  final int? present;
  final int? absent;
  final int? permission;
  final int? leave;

  MonthlyGraphEntity({
    this.month,
    this.present,
    this.absent,
    this.permission,
    this.leave,
  });
}
