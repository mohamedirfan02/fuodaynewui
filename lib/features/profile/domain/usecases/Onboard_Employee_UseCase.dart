import 'package:fuoday/features/profile/domain/entities/Employee_onboard_entity.dart';
import 'package:fuoday/features/profile/domain/repository/Employee_Onboard_Repository.dart';

class OnboardEmployeeUseCase {
  final EmployeeOnboardRepository repo;
  OnboardEmployeeUseCase(this.repo);

  Future<void> call(EmployeeOnboardEntity entity) {
    return repo.onboardEmployee(entity);
  }
}
