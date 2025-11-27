import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/attendance/domain/entities/total_attendance_details_entity.dart';
import 'package:fuoday/features/attendance/domain/usecases/get_total_attendance_details_use_case.dart';

class TotalAttendanceDetailsProvider extends ChangeNotifier {
  final GetTotalAttendanceDetailsUseCase getTotalAttendanceDetailsUseCase;

  TotalAttendanceDetailsProvider({
    required this.getTotalAttendanceDetailsUseCase,
  });

  TotalAttendanceDetailsEntity? _attendanceDetails;
  String? _errorMessage;
  bool _isLoading = false;

  TotalAttendanceDetailsEntity? get attendanceDetails => _attendanceDetails;

  String? get errorMessage => _errorMessage;

  bool get isLoading => _isLoading;

  Future<void> fetchAttendanceDetails(int webUserId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    AppLoggerHelper.logInfo(
      'Fetching total attendance details for user: $webUserId',
    );

    try {
      final result = await getTotalAttendanceDetailsUseCase(webUserId);
      _attendanceDetails = result;
      AppLoggerHelper.logInfo('Attendance data loaded successfully');
    } catch (e) {
      _errorMessage = 'Failed to load attendance data';
      AppLoggerHelper.logError('Error fetching attendance details: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
