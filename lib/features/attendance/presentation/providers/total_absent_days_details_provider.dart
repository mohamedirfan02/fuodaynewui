import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/attendance/domain/entities/total_absent_details_entity.dart';
import 'package:fuoday/features/attendance/domain/usecases/get_total_absent_details_use_case.dart';

class TotalAbsentDaysDetailsProvider extends ChangeNotifier {
  final GetTotalAbsentDetailsUseCase getTotalAbsentDetailsUseCase;

  TotalAbsentDaysDetailsProvider({required this.getTotalAbsentDetailsUseCase});

  bool _isLoading = false;
  String? _errorMessage;
  TotalAbsentDetailsEntity? _absentDetails;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  TotalAbsentDetailsEntity? get data => _absentDetails;

  Future<void> fetchTotalAbsentDetails(int userId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await getTotalAbsentDetailsUseCase.call(userId);
      _absentDetails = result;

      AppLoggerHelper.logInfo(
        '✅ Absent details fetched successfully for userId: $userId',
      );
    } catch (e) {
      _errorMessage = 'Failed to load absent details';
      _absentDetails = null;

      AppLoggerHelper.logError(
        '❌ Error fetching absent details for userId $userId — $e',
      );
    }

    _isLoading = false;
    notifyListeners();
  }
}
