import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/performance/domain/entities/performance_summary_entity.dart';
import 'package:fuoday/features/performance/domain/usecases/get_performance_summary_use_case.dart';

class PerformanceSummaryProvider extends ChangeNotifier {
  final GetPerformanceSummaryUseCase getPerformanceSummaryUseCase;

  PerformanceSummaryProvider({required this.getPerformanceSummaryUseCase});

  PerformanceSummaryEntity? _summary;

  PerformanceSummaryEntity? get summary => _summary;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _error;

  String? get error => _error;

  Future<void> loadSummary(int webUserId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    AppLoggerHelper.logInfo(
      '🔄 Fetching performance summary for userId: $webUserId',
    );

    try {
      final result = await getPerformanceSummaryUseCase(webUserId);

      if (result != null) {
        _summary = result;
        AppLoggerHelper.logInfo('✅ Summary fetched successfully.');
      } else {
        _error = "No data available.";
        AppLoggerHelper.logError('⚠️ Summary returned null.');
      }
    } catch (e, stack) {
      _error = e.toString();
      _summary = null;
      AppLoggerHelper.logError('❌ Error fetching summary: $e');
      AppLoggerHelper.logError('Stack trace: $stack');
    }

    _isLoading = false;
    notifyListeners();
  }
}
