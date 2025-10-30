// lib/features/team_leader/presentation/providers/update_leave_status_provider.dart
import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/manager/domain/entities/update_leave_status_entity.dart';
import 'package:fuoday/features/manager/domain/usecase/update_leave_status_usecase.dart';

class UpdateLeaveStatusProvider extends ChangeNotifier {
  final UpdateLeaveStatusUseCase updateLeaveStatusUseCase;

  UpdateLeaveStatusProvider({required this.updateLeaveStatusUseCase});

  bool isLoading = false;
  UpdateLeaveStatusEntity? updatedLeave;

  Future<void> updateLeave(int id, String status, String access) async {
    try {
      isLoading = true;
      notifyListeners();

      final result = await updateLeaveStatusUseCase(id, status, access);
      updatedLeave = result;

      AppLoggerHelper.logInfo("✅ Leave Updated: ${result.message}");
    } catch (e) {
      AppLoggerHelper.logError("❌ Provider update failed: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
