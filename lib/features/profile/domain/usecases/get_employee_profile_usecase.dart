import '../repository/employee_profile_repository.dart';
import '../entities/employee_profile_entity.dart';

class GetEmployeeProfileUseCase {
  final EmployeeProfileRepository repository;

  GetEmployeeProfileUseCase({required this.repository});

  Future<EmployeeProfileEntity> execute(String webUserId) {
    return repository.getProfile(webUserId);
  }
}
