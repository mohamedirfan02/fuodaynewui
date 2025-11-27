import 'package:flutter/foundation.dart';
import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/auth/domain/usecases/send_otp_usecase.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final SendOtpUseCase sendOtpUseCase;

  ForgotPasswordProvider({required this.sendOtpUseCase});

  bool _isLoading = false;
  ForgotPasswordEntity? _entity;
  String? _error;

  bool get isLoading => _isLoading;
  ForgotPasswordEntity? get entity => _entity;
  String? get error => _error;

  Future<void> sendOtp({required String email}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _entity = await sendOtpUseCase(email: email);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
