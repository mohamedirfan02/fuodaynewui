import 'package:fuoday/features/team_leader/data/datasource/all_role_total_attendance_report_remote_datasource.dart';
import 'package:fuoday/features/team_leader/domain/entities/all_role_total_attendance_report_entity.dart';
import 'package:fuoday/features/team_leader/domain/repository/all_role_total_attendance_report_repository.dart';

class AllRoleTotalAttendanceReportRepositoryImpl
    implements AllRoleTotalAttendanceReportRepository {
  final AllRoleTotalAttendanceReportRemoteDataSource remoteDataSource;

  AllRoleTotalAttendanceReportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AllRoleTotalAttendanceReportEntity> getAllAttendanceReport(
    int webUserId,
  ) async {
    final model = await remoteDataSource.getAllAttendanceReport(webUserId);
    return model.toEntity();
  }
}
