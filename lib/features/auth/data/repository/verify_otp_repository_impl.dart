import 'package:fuoday/features/auth/data/datasources/remote/verify_otp_remote_datasource.dart';
import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/auth/domain/repository/verify_otp_repository.dart';

class VerifyOtpRepositoryImpl implements VerifyOtpRepository {
  final VerifyOtpRemoteDataSource remoteDataSource;

  VerifyOtpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<VerifyOtpEntity> verifyOtp({
    required String email,
    required String otp,
  }) async {
    return await remoteDataSource.verifyOtp(email: email, otp: otp);
  }
}
