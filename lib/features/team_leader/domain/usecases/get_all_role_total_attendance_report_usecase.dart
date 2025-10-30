import 'package:fuoday/features/team_leader/domain/entities/all_role_total_attendance_report_entity.dart';
import 'package:fuoday/features/team_leader/domain/repository/all_role_total_attendance_report_repository.dart';

class GetAllRoleTotalAttendanceReportUseCase {
  final AllRoleTotalAttendanceReportRepository repository;

  GetAllRoleTotalAttendanceReportUseCase({required this.repository});

  Future<AllRoleTotalAttendanceReportEntity> call(int webUserId) async {
    return await repository.getAllAttendanceReport(webUserId);
  }
}
