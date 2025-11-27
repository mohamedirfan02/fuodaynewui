import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/attendance/domain/entities/total_late_arrivals_details_entity.dart';
import 'package:fuoday/features/attendance/domain/usecases/get_total_late_arrivals_details_use_case.dart';

class TotalLateArrivalsDetailsProvider extends ChangeNotifier {
  final GetTotalLateArrivalsDetailsUseCase getTotalLateArrivalsDetailsUseCase;

  TotalLateArrivalsDetailsProvider({
    required this.getTotalLateArrivalsDetailsUseCase,
  });

  bool _isLoading = false;
  String? _errorMessage;
  TotalLateArrivalsDetailsEntity? _data;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  TotalLateArrivalsDetailsEntity? get data => _data;

  Future<void> fetchLateArrivalDetails(int webUserId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await getTotalLateArrivalsDetailsUseCase(webUserId);
      _data = result;
      AppLoggerHelper.logInfo(
        'Fetched late arrivals successfully for user: $webUserId',
      );
    } catch (e) {
      _errorMessage = 'Failed to fetch late arrival details';
      AppLoggerHelper.logError('Late arrival fetch error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
