import 'package:dio/dio.dart';
import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/features/profile/data/models/profile_professional_experience_entity.dart';


abstract class ExperienceRemoteDataSource {
  ExperienceRemoteDataSource(Dio dio);

  Future<void> updateExperience(
      int webUserId,
      ProfessionalExperienceModel experience,
      );
}

class ExperienceRemoteDataSourceImpl implements ExperienceRemoteDataSource {
  final Dio dio;

  ExperienceRemoteDataSourceImpl(this.dio);

  @override
  Future<void> updateExperience(
      int webUserId,
      ProfessionalExperienceModel experience,
      ) async {
    final response = await dio.post(
        AppApiEndpointConstants.updateExperience,
      data: experience.toJson(webUserId),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update experience');
    }
  }
}
