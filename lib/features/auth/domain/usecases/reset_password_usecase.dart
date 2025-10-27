import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/auth/domain/repository/reset_password_repository.dart';

class ResetPasswordUseCase {
  final ResetPasswordRepository repository;

  ResetPasswordUseCase({required this.repository});

  Future<ResetPasswordEntity> call({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await repository.resetPassword(
      email: email,
      otp: otp,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
