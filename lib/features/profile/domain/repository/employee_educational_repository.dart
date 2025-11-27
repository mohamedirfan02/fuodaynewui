import '../entities/education_entity.dart';

abstract class ProfileRepository {
  Future<List<EducationEntity>> getEducation(String webUserId);
  Future<List<SkillEntity>> getSkills(String webUserId);
}
