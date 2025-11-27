
import 'package:fuoday/features/profile/domain/entities/profile_professional_experience_entity.dart';
import 'package:fuoday/features/profile/domain/repository/profile_experience_repository.dart';

class UpdateExperienceUseCase {
  final ExperienceRepository repository;

  UpdateExperienceUseCase(this.repository);

  Future<void> call({
    required int webUserId,
    required ProfessionalExperienceEntity experience,
  }) async {
    await repository.updateExperience(
      webUserId: webUserId,
      experience: experience,
    );
  }
}
