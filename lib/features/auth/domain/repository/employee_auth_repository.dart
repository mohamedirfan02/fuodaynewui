import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';

abstract class EmployeeAuthRepository {
  // Employee Auth Login
  Future<EmployeeAuthEntity> employeeAuthLogin(
    String role,
    String emailId,
    String password,
  );

  // Employee Auth Logout
  Future<void> employeeAuthLogOut();
}
