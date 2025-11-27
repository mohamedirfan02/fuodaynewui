import 'package:fuoday/features/team_leader/domain/entities/all_role_total_attendance_report_entity.dart';

abstract class AllRoleTotalAttendanceReportRepository {
  Future<AllRoleTotalAttendanceReportEntity> getAllAttendanceReport(
    int webUserId,
  );
}
