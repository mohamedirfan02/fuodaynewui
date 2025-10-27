// forgot_password_repository_impl.dart

import 'package:fuoday/features/auth/data/datasources/remote/forgot_password_remote_datasource.dart';
import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/auth/domain/repository/forgot_password_repository.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordRemoteDataSource remoteDataSource;

  ForgotPasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ForgotPasswordEntity> sendOtp({required String email}) {
    return remoteDataSource.sendOtp(email: email);
  }
}
