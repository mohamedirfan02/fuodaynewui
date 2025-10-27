import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';

abstract class ResetPasswordRepository {
  Future<ResetPasswordEntity> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  });
}
