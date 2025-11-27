import 'package:fuoday/features/profile/domain/repository/employee_educational_repository.dart';

import '../entities/education_entity.dart';

class GetEducationUseCase {
  final ProfileRepository repository;

  GetEducationUseCase(this.repository);

  Future<List<EducationEntity>> call(String webUserId) {
    return repository.getEducation(webUserId);
  }
}

// get_skills_usecase.dart


class GetSkillsUseCase {
  final ProfileRepository repository;

  GetSkillsUseCase(this.repository);

  Future<List<SkillEntity>> call(String webUserId) {
    return repository.getSkills(webUserId);
  }
}
