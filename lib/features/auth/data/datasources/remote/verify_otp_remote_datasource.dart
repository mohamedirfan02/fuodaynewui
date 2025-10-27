// verify_otp_remote_datasource.dart
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/auth/data/models/verify_otp_model.dart';

class VerifyOtpRemoteDataSource {
  final DioService dioService;

  VerifyOtpRemoteDataSource({required this.dioService});

  Future<VerifyOtpModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await dioService.post(
        AppApiEndpointConstants.forgotPasswordOTPverify, // 🔹 endpoint
        data: {'email': email, 'otp': otp},
      );
      return VerifyOtpModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
