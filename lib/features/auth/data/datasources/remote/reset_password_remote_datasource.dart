import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/auth/data/models/reset_password_model.dart';

class ResetPasswordRemoteDataSource {
  final DioService dioService;

  ResetPasswordRemoteDataSource({required this.dioService});

  Future<ResetPasswordModel> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await dioService.post(
        AppApiEndpointConstants.resetPassword, // ✅ your API endpoint
        data: {
          "email": email,
          "otp": otp,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      return ResetPasswordModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
