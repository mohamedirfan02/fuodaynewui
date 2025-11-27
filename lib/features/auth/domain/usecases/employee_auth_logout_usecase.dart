import 'package:fuoday/features/auth/domain/repository/employee_auth_repository.dart';

class EmployeeAuthLogOutUseCase {
  final EmployeeAuthRepository employeeAuthRepository;

  EmployeeAuthLogOutUseCase({required this.employeeAuthRepository});

  // Employee Log Out
  Future<void> call() async {
    await employeeAuthRepository.employeeAuthLogOut();
  }
}
