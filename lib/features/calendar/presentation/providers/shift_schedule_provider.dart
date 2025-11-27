import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/calendar/domain/entities/shift_schedule_entity.dart';
import 'package:fuoday/features/calendar/domain/usecases/get_monthly_shift_usecase.dart';

class ShiftScheduleProvider extends ChangeNotifier {
  final GetMonthlyShiftUseCase getMonthlyShiftUseCase;

  ShiftScheduleProvider({required this.getMonthlyShiftUseCase});

  List<ShiftScheduleEntity> _shifts = [];
  List<ShiftScheduleEntity> get shifts => _shifts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchMonthlyShifts({
    required String webUserId,
    required String month,
    bool forceRefresh = false,
  }) async {
    if (_shifts.isNotEmpty && !forceRefresh) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await getMonthlyShiftUseCase(webUserId, month);
      _shifts = data;

      /// ✅ Logging number of shifts
      AppLoggerHelper.logInfo(
        "📅 Fetched ${_shifts.length} shifts for $month (User ID: $webUserId)",
      );
    } catch (e) {
      _error = e.toString();
      AppLoggerHelper.logError("❌ Error fetching shifts: $_error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearShifts() {
    _shifts = [];
    notifyListeners();
  }
}