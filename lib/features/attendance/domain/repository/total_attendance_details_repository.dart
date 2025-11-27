import 'package:fuoday/features/attendance/domain/entities/total_attendance_details_entity.dart';

abstract class TotalAttendanceDetailsRepository {
  // Get Total Attendance Details
  Future<TotalAttendanceDetailsEntity> getTotalAttendanceDetails(
    int webUserId,
  );
}
