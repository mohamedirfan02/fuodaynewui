import 'package:fuoday/features/attendance/domain/entities/total_early_arrivals_details_entity.dart';

abstract class TotalEarlyArrivalsDetailsRepository {
  Future<EarlyArrivalsEntity> getTotalEarlyArrivalsDetails(int webUserId);
}
