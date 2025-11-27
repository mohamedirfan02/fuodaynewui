// File: features/attendance/domain/entities/total_punctual_arrivals_details_entity.dart

class TotalPunctualArrivalsDetailsEntity {
  final String? message;
  final String? status;
  final PunctualDataEntity? data;

  TotalPunctualArrivalsDetailsEntity({
    this.message,
    this.status,
    this.data
  });
}

class PunctualDataEntity {
  final String? employeeName;
  final int? totalPunctualArrivals;
  final int? recordsUpdated;
  final double? punctualArrivalPercentage;
  final List<PunctualArrivalRecordEntity>? punctualArrivalsDetails;

  PunctualDataEntity({
    this.employeeName,
    this.totalPunctualArrivals,
    this.recordsUpdated,
    this.punctualArrivalPercentage,
    this.punctualArrivalsDetails,
  });
}

class PunctualArrivalRecordEntity {
  final String? date;
  final String? empName;
  final String? checkinTime;
  final String? punctualTime;
  final String? currentStatus;

  PunctualArrivalRecordEntity({
    this.date,
    this.empName,
    this.checkinTime,
    this.punctualTime,
    this.currentStatus,
  });
}