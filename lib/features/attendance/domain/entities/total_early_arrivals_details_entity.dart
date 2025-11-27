class EarlyArrivalsEntity {
  final String? message;
  final String? status;
  final EarlyArrivalDataEntity? data;

  EarlyArrivalsEntity({
    this.message,
    this.status,
    this.data,
  });
}

class EarlyArrivalDataEntity {
  final String? employeeName;
  final int? totalEarlyArrivals;
  final int? totalEarlyMinutes;
  final double? averageEarlyMinutes;
  final double? totalEarlyHours;
  final int? recordsUpdated;
  final int? earlyArrivalPercentage;
  final List<EarlyArrivalDetailEntity>? earlyArrivalsDetails;

  EarlyArrivalDataEntity({
    this.employeeName,
    this.totalEarlyArrivals,
    this.totalEarlyMinutes,
    this.averageEarlyMinutes,
    this.totalEarlyHours,
    this.recordsUpdated,
    this.earlyArrivalPercentage,
    this.earlyArrivalsDetails,
  });
}

class EarlyArrivalDetailEntity {
  final String? date;
  final String? empName;
  final String? checkinTime;
  final int? minutesEarly;
  final String? hoursMinutesEarly;
  final String? currentStatus;

  EarlyArrivalDetailEntity({
    this.date,
    this.empName,
    this.checkinTime,
    this.minutesEarly,
    this.hoursMinutesEarly,
    this.currentStatus,
  });
}
