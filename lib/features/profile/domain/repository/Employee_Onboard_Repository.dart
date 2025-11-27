import 'package:fuoday/features/profile/domain/entities/Employee_onboard_entity.dart';

abstract class EmployeeOnboardRepository {
  Future<void> onboardEmployee(EmployeeOnboardEntity entity);
}
