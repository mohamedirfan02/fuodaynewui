
import 'package:fuoday/features/profile/data/datasources/employee_educational_remote_data_source.dart';
import 'package:fuoday/features/profile/domain/entities/education_entity.dart';
import 'package:fuoday/features/profile/domain/repository/employee_educational_repository.dart';


class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<EducationEntity>> getEducation(String webUserId) async {
    final data = await remoteDataSource.getProfileData(webUserId);
    final educationList = (data['education'] as List)
        .map((e) => EducationEntity(
      qualification: e['qualification'],
      university: e['university'],
      yearOfPassing: e['year_of_passing'],
    ))
        .toList();
    return educationList;
  }

  @override
  Future<List<SkillEntity>> getSkills(String webUserId) async {
    final data = await remoteDataSource.getProfileData(webUserId);
    final skillList = (data['skills'] as List)
        .map((e) => SkillEntity(skill: e['skill']))
        .toList();
    return skillList;
  }
}
