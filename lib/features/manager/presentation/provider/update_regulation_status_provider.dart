import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/manager/domain/entities/update_regulation_status_entity.dart';
import 'package:fuoday/features/manager/domain/usecase/update_regulation_status_usecase.dart';

class UpdateRegulationStatusProvider extends ChangeNotifier {
  final UpdateRegulationStatusUseCase updateRegulationStatusUseCase;

  UpdateRegulationStatusProvider({required this.updateRegulationStatusUseCase});

  bool isLoading = false;
  UpdateRegulationStatusEntity? updatedRegulation;

  Future<void> updateRegulation(
    int id,
    String status,
    String access,
    String module,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      final result = await updateRegulationStatusUseCase(
        id,
        status,
        access,
        module,
      );
      updatedRegulation = result;

      AppLoggerHelper.logInfo("✅ Regulation Updated: ${result.message}");
    } catch (e) {
      AppLoggerHelper.logError("❌ Provider update failed: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
