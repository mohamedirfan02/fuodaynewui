import 'package:flutter/foundation.dart';
import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/auth/domain/usecases/verify_otp_usecase.dart';

class VerifyOtpProvider extends ChangeNotifier {
  final VerifyOtpUseCase verifyOtpUseCase;

  VerifyOtpProvider({required this.verifyOtpUseCase});

  bool _isLoading = false;
  VerifyOtpEntity? _entity;
  String? _error;

  bool get isLoading => _isLoading;
  VerifyOtpEntity? get entity => _entity;
  String? get error => _error;

  Future<void> verifyOtp({required String email, required String otp}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _entity = await verifyOtpUseCase(email: email, otp: otp);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
