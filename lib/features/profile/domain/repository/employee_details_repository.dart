import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';

abstract class EmployeeDetailsRepository {
  final EmployeeDataEntity employeeModel;

  EmployeeDetailsRepository({required this.employeeModel});

  // Get Employee Profile Details
  Future<EmployeeDataEntity> getEmployeeProfileDetails(
    EmployeeDataEntity employeeDetails,
  );

  // Update Employee Profile Details
  Future<EmployeeDataEntity> updateEmployeeProfileDetails(
    EmployeeDataEntity employeeDetails,
  );
}
