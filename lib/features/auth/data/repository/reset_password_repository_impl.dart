import 'package:fuoday/features/auth/data/datasources/remote/reset_password_remote_datasource.dart';
import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/auth/domain/repository/reset_password_repository.dart';

class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ResetPasswordRemoteDataSource remoteDataSource;

  ResetPasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ResetPasswordEntity> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await remoteDataSource.resetPassword(
      email: email,
      otp: otp,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}
