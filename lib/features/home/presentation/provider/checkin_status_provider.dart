import 'package:flutter/cupertino.dart';
import 'package:fuoday/features/home/domain/entities/checkin_status_entity.dart';
import 'package:fuoday/features/home/domain/usecases/get_checkin_status_usecase.dart';

class CheckinStatusProvider with ChangeNotifier {
  final GetCheckinStatusUseCase _getCheckinStatusUseCase;

  CheckinStatusProvider({
    required GetCheckinStatusUseCase getCheckinStatusUseCase,
  }) : _getCheckinStatusUseCase = getCheckinStatusUseCase;

  CheckinStatusEntity? _checkinStatus;
  bool _isLoading = false;
  String? _error;
  DateTime? _checkinDateTime;
  DateTime? _checkoutDateTime;

  // Getters
  CheckinStatusEntity? get checkinStatus => _checkinStatus;
  bool get isLoading => _isLoading;
  String? get error => _error;

  bool get isCurrentlyCheckedIn =>
      _checkinStatus?.checkin != null && _checkinStatus?.checkout == null;

  String get formattedCheckinTime => _checkinStatus?.checkin ?? "00:00:00";
  String get formattedCheckoutTime => _checkinStatus?.checkout ?? "00:00:00";

  Duration get workingDuration {
    if (_checkinDateTime == null) return Duration.zero;
    final endTime = _checkoutDateTime ?? DateTime.now();
    return endTime.difference(_checkinDateTime!);
  }

  String get formattedWorkingDuration {
    final d = workingDuration;
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> fetchCheckinStatus(int webUserId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _checkinStatus = await _getCheckinStatusUseCase(webUserId);
      _parseDateTime();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _parseDateTime() {
    // Parse checkin
    if (_checkinStatus?.checkin != null) {
      try {
        _checkinDateTime = _parseTime(_checkinStatus!.checkin!);
      } catch (e) {
        _checkinDateTime = DateTime.now();
      }
    } else {
      _checkinDateTime = null;
    }

    // Parse checkout
    if (_checkinStatus?.checkout != null) {
      try {
        _checkoutDateTime = _parseTime(_checkinStatus!.checkout!);
      } catch (e) {
        _checkoutDateTime = null;
      }
    } else {
      _checkoutDateTime = null;
    }
  }

  DateTime _parseTime(String timeString) {
    // if API returns HH:mm:ss, combine with today
    final now = DateTime.now();
    final parts = timeString.split(':');
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  /// Call this immediately after check-in
  void updateCheckinTimeLocally() {
    _checkinDateTime = DateTime.now();
    _checkoutDateTime = null;
    notifyListeners();
  }

  /// Call this immediately after check-out
  void updateCheckoutTimeLocally() {
    _checkoutDateTime = DateTime.now();
    notifyListeners();
  }
}
