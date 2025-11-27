import 'package:fuoday/features/attendance/domain/entities/total_punctual_arrivals_details_entity.dart';

abstract class AttendanceRepository {
  Future<TotalPunctualArrivalsDetailsEntity> getTotalPunctualArrivalDetails(int webUserId);
}