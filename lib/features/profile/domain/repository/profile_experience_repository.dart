
import 'package:fuoday/features/profile/domain/entities/profile_professional_experience_entity.dart';

abstract class ExperienceRepository {
  Future<void> updateExperience({
    required int webUserId,
    required ProfessionalExperienceEntity experience,
  });
}
