import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/auth/domain/repository/employee_auth_repository.dart';

class EmployeeAuthLoginUseCase {
  final EmployeeAuthRepository employeeAuthRepository;

  EmployeeAuthLoginUseCase({required this.employeeAuthRepository});

  Future<EmployeeAuthEntity> call({
    required String role,
    required String emailId,
    required String password,
  }) async {
    return await employeeAuthRepository.employeeAuthLogin(
      role,
      emailId,
      password,
    );
  }
}
