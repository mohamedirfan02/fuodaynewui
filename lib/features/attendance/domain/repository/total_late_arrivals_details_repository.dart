import 'package:fuoday/features/attendance/domain/entities/total_late_arrivals_details_entity.dart';

abstract class TotalLateArrivalsDetailsRepository {
  // Get Total Late Arrivals Details
  Future<TotalLateArrivalsDetailsEntity> getTotalLateArrivalsDetails(
    int webUserId,
  );
}
