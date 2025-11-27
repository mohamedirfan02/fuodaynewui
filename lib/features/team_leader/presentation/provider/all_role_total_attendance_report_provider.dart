import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/team_leader/domain/entities/all_role_total_attendance_report_entity.dart';
import 'package:fuoday/features/team_leader/domain/usecases/get_all_role_total_attendance_report_usecase.dart';

class AttendanceReportProvider extends ChangeNotifier {
  final GetAllRoleTotalAttendanceReportUseCase
  getAllRoleTotalAttendanceReportUseCase;

  AttendanceReportProvider({
    required this.getAllRoleTotalAttendanceReportUseCase,
  });

  bool isLoading = false;
  AllRoleTotalAttendanceReportEntity? attendanceReport;
  String? errorMessage;

  /// ✅ Fetch all roles attendance report by web user id
  Future<void> fetchAllRoleAttendance(int webUserId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      attendanceReport = await getAllRoleTotalAttendanceReportUseCase.call(
        webUserId,
      );
      AppLoggerHelper.logInfo(
        '✅ All Role Attendance Report fetched successfully',
      );
    } catch (e) {
      errorMessage = e.toString();
      AppLoggerHelper.logError(
        '❌ Failed to fetch All Role Attendance Report: $e',
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ✅ Convenience getters for UI access
  List<AttendanceUserEntity> get hrList => attendanceReport?.hrList ?? [];
  List<AttendanceUserEntity> get managerList =>
      attendanceReport?.managerList ?? [];
  List<AttendanceUserEntity> get teamsList => attendanceReport?.teamsList ?? [];

  bool get hasError => errorMessage != null;
  bool get hasData => attendanceReport != null;
}
