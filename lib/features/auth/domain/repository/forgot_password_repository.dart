// forgot_password_repository.dart

import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';

abstract class ForgotPasswordRepository {
  Future<ForgotPasswordEntity> sendOtp({required String email});
}
