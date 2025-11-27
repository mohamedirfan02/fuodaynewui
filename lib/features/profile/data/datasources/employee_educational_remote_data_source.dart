import 'package:dio/dio.dart';
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';

class ProfileRemoteDataSource {
  final Dio dio;

  ProfileRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> getProfileData(String webUserId) async {
    final response = await dio.get(AppApiEndpointConstants.profileData(webUserId));
    return response.data['data'];
  }
}
