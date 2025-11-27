// send_otp_usecase.dart

import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/auth/domain/repository/forgot_password_repository.dart';

class SendOtpUseCase {
  final ForgotPasswordRepository repository;

  SendOtpUseCase({required this.repository});

  Future<ForgotPasswordEntity> call({required String email}) {
    return repository.sendOtp(email: email);
  }
}
