class TotalAbsentDetailsEntity {
  final String? message;
  final String? status;
  final AbsentDataEntity? data;

  TotalAbsentDetailsEntity({this.message, this.status, this.data});
}

class AbsentDataEntity {
  final String? employeeName;
  final int? totalAbsentDays;
  final int? absentPercentage;
  final List<AbsentRecordEntity>? absentRecords;

  AbsentDataEntity({
    this.employeeName,
    this.totalAbsentDays,
    this.absentPercentage,
    this.absentRecords,
  });
}

class AbsentRecordEntity {
  final String? date;
  final String? empName;
  final String? checkin;
  final String? status;

  AbsentRecordEntity({this.date, this.empName, this.checkin, this.status});
}
