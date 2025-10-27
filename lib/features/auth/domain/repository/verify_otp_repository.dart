import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';

abstract class VerifyOtpRepository {
  Future<VerifyOtpEntity> verifyOtp({
    required String email,
    required String otp,
  });
}
