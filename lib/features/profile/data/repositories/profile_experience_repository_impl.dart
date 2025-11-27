

import 'package:fuoday/features/profile/data/datasources/profile_experience_remote_data_source.dart';
import 'package:fuoday/features/profile/data/models/profile_professional_experience_entity.dart';
import 'package:fuoday/features/profile/domain/entities/profile_professional_experience_entity.dart';
import 'package:fuoday/features/profile/domain/repository/profile_experience_repository.dart';

class ExperienceRepositoryImpl implements ExperienceRepository {
  final ExperienceRemoteDataSource remoteDataSource;

  ExperienceRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> updateExperience({
    required int webUserId,
    required ProfessionalExperienceEntity experience,
  }) async {
    final model = ProfessionalExperienceModel(
      companyName: experience.companyName,
      noOfYears: experience.noOfYears,
      role: experience.role,
      duration: experience.duration,
      responsibilities: experience.responsibilities,
      achievements: experience.achievements,
    );

    await remoteDataSource.updateExperience(webUserId, model);
  }
}
