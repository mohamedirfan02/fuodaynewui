import '../entities/employee_profile_entity.dart';

abstract class EmployeeProfileRepository {
  Future<EmployeeProfileEntity> getProfile(String webUserId);
}
