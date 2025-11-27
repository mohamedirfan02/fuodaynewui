import 'package:flutter/foundation.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/service/secure_storage_service.dart';
import 'package:fuoday/features/auth/domain/usecases/employee_auth_logout_usecase.dart';

class EmployeeAuthLogoutProvider extends ChangeNotifier {
  final EmployeeAuthLogOutUseCase employeeAuthLogOutUseCase;

  EmployeeAuthLogoutProvider({required this.employeeAuthLogOutUseCase});

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> logout() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    AppLoggerHelper.logInfo('Attempting logout...');

    try {
      final token = await SecureStorageService().getToken();

      if (token != null) {
        DioService().updateAuthToken(token);

        AppLoggerHelper.logInfo(token);
      } else {
        throw Exception('No auth token found.');
      }

      // Call logout API
      await employeeAuthLogOutUseCase();

      // Delete token
      await SecureStorageService().deleteToken();

      AppLoggerHelper.logInfo('Logout successful!');
    } catch (e) {
      _error = e.toString();
      AppLoggerHelper.logError('Logout failed: $_error');
    }

    _isLoading = false;
    notifyListeners();
  }
}
