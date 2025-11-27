class TotalLateArrivalsDetailsEntity {
  final String employeeName;
  final int totalLateArrivals;
  final int totalLateMinutes;
  final double averageLateMinutes;
  final double totalLateHours;
  final int recordsUpdated;
  final double lateArrivalPercentage;
  final List<LateArrivalEntry> lateArrivalsDetails;

  TotalLateArrivalsDetailsEntity({
    required this.employeeName,
    required this.totalLateArrivals,
    required this.totalLateMinutes,
    required this.averageLateMinutes,
    required this.totalLateHours,
    required this.recordsUpdated,
    required this.lateArrivalPercentage,
    required this.lateArrivalsDetails,
  });
}

class LateArrivalEntry {
  final String date;
  final String empName;
  final String checkinTime;
  final int minutesLate;
  final String hoursMinutesLate;
  final String currentStatus;

  LateArrivalEntry({
    required this.date,
    required this.empName,
    required this.checkinTime,
    required this.minutesLate,
    required this.hoursMinutesLate,
    required this.currentStatus,
  });
}
