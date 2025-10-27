import 'package:flutter/material.dart';
import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/auth/domain/usecases/reset_password_usecase.dart';

class ResetPasswordProvider extends ChangeNotifier {
  final ResetPasswordUseCase resetPasswordUseCase;

  bool _isLoading = false;
  String? _error;
  ResetPasswordEntity? _response;

  bool get isLoading => _isLoading;
  String? get error => _error;
  ResetPasswordEntity? get response => _response;

  ResetPasswordProvider({required this.resetPasswordUseCase});

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await resetPasswordUseCase(
        email: email,
        otp: otp,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      _response = result;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
