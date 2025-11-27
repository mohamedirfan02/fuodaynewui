import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/performance/domain/usecases/get_employee_audit_use_case.dart';
import 'package:fuoday/features/performance/domain/entities/employee_audit_entity.dart';

class EmployeeAuditProvider extends ChangeNotifier {
  final GetEmployeeAuditUseCase getEmployeeAuditUseCase;

  EmployeeAuditProvider({required this.getEmployeeAuditUseCase});

  EmployeeAuditEntity? _audit;
  bool _isLoading = false;
  String? _error;

  EmployeeAuditEntity? get audit => _audit;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> fetchEmployeeAudit(int webUserId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    AppLoggerHelper.logInfo(
      '🔄 Fetching employee audit for userId: $webUserId',
    );

    try {
      final result = await getEmployeeAuditUseCase(webUserId);

      if (result != null) {
        _audit = result;
        AppLoggerHelper.logInfo('✅ Fetched employee audit successfully');
      } else {
        _audit = null;
        _error = 'No audit data found';
        AppLoggerHelper.logError('⚠️ No data returned for employee audit');
      }
    } catch (e, stack) {
      _audit = null;
      _error = 'Error fetching audit: $e';
      AppLoggerHelper.logError('❌ Exception during audit fetch: $e');
      AppLoggerHelper.logError('Stack trace: $stack');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
