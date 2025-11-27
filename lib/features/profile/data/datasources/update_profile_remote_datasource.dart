import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/profile/data/models/update_profile_model.dart';
import 'package:fuoday/features/profile/domain/entities/update_profile_entity.dart';

class UpdateProfileRemoteDataSource {
  final DioService dioService;
  UpdateProfileRemoteDataSource({required this.dioService});

  Future<void> updateProfile(UpdateProfileEntity entity) async {
    final formData = UpdateProfileModel.fromEntity(entity);
    await dioService.post(AppApiEndpointConstants.updateProfile, data: formData);
  }
}