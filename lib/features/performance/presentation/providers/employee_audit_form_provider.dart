import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/performance/domain/entities/employee_audit_form_entity.dart';
import 'package:fuoday/features/performance/domain/usecases/post_employee_audit_form_use_case.dart';

class EmployeeAuditFormProvider extends ChangeNotifier {
  final PostEmployeeAuditFormUseCase postEmployeeAuditFormUseCase;

  EmployeeAuditFormProvider({required this.postEmployeeAuditFormUseCase});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _error;

  String? get error => _error;

  bool _isSuccess = false;

  bool get isSuccess => _isSuccess;

  Future<void> postAuditForm(EmployeeAuditFormEntity entity) async {
    _isLoading = true;
    _error = null;
    _isSuccess = false;
    notifyListeners();

    AppLoggerHelper.logInfo('📤 Posting employee audit form...');

    try {
      await postEmployeeAuditFormUseCase(entity);
      _isSuccess = true;
      AppLoggerHelper.logInfo('✅ Audit form submitted successfully.');
    } catch (e, stack) {
      _error = 'Error: $e';
      _isSuccess = false;
      AppLoggerHelper.logError('❌ Failed to post audit form: $e');
      AppLoggerHelper.logError('Stack trace: $stack');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _isLoading = false;
    _error = null;
    _isSuccess = false;
    notifyListeners();
  }
}
