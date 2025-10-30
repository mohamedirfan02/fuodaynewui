//=============================================
// Presentation Layer: PROVIDER
//=============================================
import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/team_leader/domain/entities/late_arrivals_entity.dart';
import 'package:fuoday/features/team_leader/domain/usecases/get_late_arrivals_usecase.dart';

class LateArrivalsProvider extends ChangeNotifier {
  final GetLateArrivalsUseCase getLateArrivalsUseCase;

  LateArrivalsProvider({required this.getLateArrivalsUseCase});

  bool isLoading = false;
  LateArrivalsEntity? lateArrivals;
  String? errorMessage;

  Future<void> fetchLateArrivals() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      lateArrivals = await getLateArrivalsUseCase.call();
      AppLoggerHelper.logInfo("✅ Late arrivals data fetched successfully");
    } catch (e) {
      errorMessage = e.toString();
      AppLoggerHelper.logError("❌ Failed to fetch late arrivals data: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
