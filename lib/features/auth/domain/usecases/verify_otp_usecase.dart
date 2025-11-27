import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/auth/domain/repository/verify_otp_repository.dart';

class VerifyOtpUseCase {
  final VerifyOtpRepository repository;

  VerifyOtpUseCase({required this.repository});

  Future<VerifyOtpEntity> call({
    required String email,
    required String otp,
  }) async {
    return await repository.verifyOtp(email: email, otp: otp);
  }
}
