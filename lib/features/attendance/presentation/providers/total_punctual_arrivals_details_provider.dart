// File: features/attendance/presentation/providers/total_punctual_arrival_details_provider.dart

import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/attendance/domain/entities/total_punctual_arrivals_details_entity.dart';
import 'package:fuoday/features/attendance/domain/usecases/get_total_punctual_arrivals_details_use_case.dart';

class TotalPunctualArrivalDetailsProvider extends ChangeNotifier {
  final GetTotalPunctualArrivalsDetailsUseCase getTotalPunctualArrivalsDetailsUseCase;

  TotalPunctualArrivalDetailsProvider({
    required this.getTotalPunctualArrivalsDetailsUseCase,
  });

  TotalPunctualArrivalsDetailsEntity? _details;
  bool _isLoading = false;
  String? _error;

  TotalPunctualArrivalsDetailsEntity? get details => _details;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTotalPunctualArrivalDetails(int webUserId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      AppLoggerHelper.logInfo('Provider: Starting fetch for webUserId: $webUserId');
      print('🔍 Provider: Starting fetch for webUserId: $webUserId');

      final result = await getTotalPunctualArrivalsDetailsUseCase(webUserId);

      _details = result;

      print('✅ Provider: Successfully fetched data');
      print('✅ Provider: Result type: ${result.runtimeType}');
      print('✅ Provider: Message: ${result.message}');
      print('✅ Provider: Status: ${result.status}');
      print('✅ Provider: Has data: ${result.data != null}');

      if (result.data != null) {
        print('✅ Provider: Employee: ${result.data!.employeeName}');
        print('✅ Provider: Total punctual: ${result.data!.totalPunctualArrivals}');
        print('✅ Provider: Percentage: ${result.data!.punctualArrivalPercentage}');
        print('✅ Provider: Records: ${result.data!.punctualArrivalsDetails?.length}');

        if (result.data!.punctualArrivalsDetails?.isNotEmpty == true) {
          final firstRecord = result.data!.punctualArrivalsDetails![0];
          print('✅ Provider: First record - Name: ${firstRecord.empName}, Date: ${firstRecord.date}');
        }
      } else {
        print('⚠️ Provider: Data is null!');
      }

      AppLoggerHelper.logInfo('Provider: Fetched punctual arrivals successfully for $webUserId');

    } catch (e, stackTrace) {
      _error = e.toString();
      _details = null;

      print('❌ Provider Error: $e');
      print('❌ Provider Stack: $stackTrace');

      AppLoggerHelper.logError('Provider: Failed to fetch punctual arrival details for $webUserId: $e');

    } finally {
      _isLoading = false;
      notifyListeners();
      print('🔍 Provider: Fetch completed, isLoading: $_isLoading, hasData: ${_details != null}');
    }
  }

  void clear() {
    AppLoggerHelper.logInfo('Provider: Clearing punctual arrival state');
    print('🔍 Provider: Clearing state');

    _details = null;
    _error = null;
    _isLoading = false;

    notifyListeners();
  }
}
