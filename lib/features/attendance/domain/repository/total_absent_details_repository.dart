import 'package:fuoday/features/attendance/domain/entities/total_absent_details_entity.dart';

abstract class TotalAbsentDetailsRepository {
  // Get Total Absent Details
  Future<TotalAbsentDetailsEntity> getTotalAbsentDetails(int webUserId);
}
