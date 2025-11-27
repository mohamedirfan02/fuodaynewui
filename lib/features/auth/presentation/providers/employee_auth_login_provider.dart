import 'package:flutter/foundation.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/auth/domain/usecases/employee_auth_login_usecase.dart';

class EmployeeAuthLoginProvider extends ChangeNotifier {
  final EmployeeAuthLoginUseCase employeeAuthLoginUseCase;

  EmployeeAuthLoginProvider({required this.employeeAuthLoginUseCase});

  bool _isLoading = false;
  EmployeeAuthEntity? _authEntity;
  String? _error;

  bool get isLoading => _isLoading;

  EmployeeAuthEntity? get authEntity => _authEntity;

  String? get error => _error;

  Future<void> login({
    required String role,
    required String emailId,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    AppLoggerHelper.logInfo('Attempting login...');
    AppLoggerHelper.logInfo('Role: $role');
    AppLoggerHelper.logInfo('Email: $emailId');

    try {
      final result = await employeeAuthLoginUseCase(
        role: role,
        emailId: emailId,
        password: password,
      );

      _authEntity = result;

      AppLoggerHelper.logInfo('Login successful!');
      AppLoggerHelper.logInfo('Token: ${_authEntity?.token}');
      AppLoggerHelper.logInfo('Name: ${_authEntity?.data.name}');
    } catch (e) {
      _error = e.toString();
      AppLoggerHelper.logError('Login failed: $_error');
    }

    _isLoading = false;
    notifyListeners();
  }
}
