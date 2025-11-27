// forgot_password_remote_datasource.dart
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/auth/data/models/forgot_password_model.dart';

class ForgotPasswordRemoteDataSource {
  final DioService dioService;

  ForgotPasswordRemoteDataSource({required this.dioService});

  Future<ForgotPasswordModel> sendOtp({required String email}) async {
    try {
      final response = await dioService.post(
        AppApiEndpointConstants.forgotPassword, // 🔹 endpoint
        data: {'email': email}, // only email
      );
      return ForgotPasswordModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
