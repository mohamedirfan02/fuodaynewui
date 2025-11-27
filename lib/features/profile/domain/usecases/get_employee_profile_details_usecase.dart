import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/profile/domain/repository/employee_details_repository.dart';

class GetEmployeeProfileDetailsUseCase {
  final EmployeeDetailsRepository employeeDetailsRepository;

  GetEmployeeProfileDetailsUseCase({required this.employeeDetailsRepository});

  Future<EmployeeDataEntity> call({
    required EmployeeDataEntity employeeDetails,
  }) async {
    return await employeeDetailsRepository.getEmployeeProfileDetails(
      employeeDetails,
    );
  }
}
