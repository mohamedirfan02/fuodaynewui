import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/home/domain/entities/checkin_entity.dart';
import 'package:fuoday/features/home/domain/usecases/checkin_usecase.dart';

class CheckInProvider with ChangeNotifier {
  final CheckInUseCase checkInUseCase;
  final CheckOutUseCase checkOutUseCase;

  CheckInProvider({
    required this.checkInUseCase,
    required this.checkOutUseCase,
  });

  final StopWatchTimer stopWatchTimer = StopWatchTimer();
  bool isCheckedIn = false;
  bool isLoading = false;
  String status = 'Not Checked In';
  String? checkInTime;
  String? checkOutTime;

  Future<void> handleCheckIn({
    required int userId,
    required String time,
  }) async {
    _setLoading(true);
    AppLoggerHelper.logInfo('Attempting check-in for userId: $userId at $time');

    try {
      final entity = CheckInEntity(
        webUserId: userId,
        time: time,
        isCheckIn: true,
      );

      final result = await checkInUseCase(entity);

      if (result != null) {
        isCheckedIn = true;
        checkInTime = time;
        status = 'Checked In';
        stopWatchTimer.onStartTimer();
        AppLoggerHelper.logInfo('Check-in successful: $result');
      } else {
        AppLoggerHelper.logError('Check-in failed: result was null');
      }
    } catch (e, stackTrace) {
      AppLoggerHelper.logError('Exception during check-in: $e', stackTrace);
    }

    _setLoading(false);
  }

  Future<void> handleCheckOut({
    required int userId,
    required String time,
  }) async {
    _setLoading(true);
    AppLoggerHelper.logInfo(
      'Attempting check-out for userId: $userId at $time',
    );

    try {
      final entity = CheckInEntity(
        webUserId: userId,
        time: time,
        isCheckIn: false,
      );

      final result = await checkOutUseCase(entity);

      if (result != null) {
        isCheckedIn = false;
        checkOutTime = time;
        status = 'Checked Out';
        stopWatchTimer.onStopTimer();
        AppLoggerHelper.logInfo('Check-out successful: $result');
      } else {
        AppLoggerHelper.logError('Check-out failed: result was null');
      }
    } catch (e, stackTrace) {
      AppLoggerHelper.logError('Exception during check-out: $e', stackTrace);
    }

    _setLoading(false);
  }

  void restoreTimerIfCheckedIn() {
    if (isCheckedIn) {
      stopWatchTimer.onStartTimer();
      AppLoggerHelper.logInfo('Timer restored on app resume');
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    stopWatchTimer.dispose();
    super.dispose();
  }
}
