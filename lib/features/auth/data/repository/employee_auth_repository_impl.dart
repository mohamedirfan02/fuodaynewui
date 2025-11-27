import 'package:fuoday/features/auth/data/datasources/remote/employee_auth_remote_datasource.dart';
import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';
import 'package:fuoday/features/auth/domain/repository/employee_auth_repository.dart';

class EmployeeAuthRepositoryImpl implements EmployeeAuthRepository {
  final EmployeeAuthRemoteDataSource employeeAuthRemoteDataSource;

  EmployeeAuthRepositoryImpl({required this.employeeAuthRemoteDataSource});

  @override
  Future<EmployeeAuthEntity> employeeAuthLogin(
    String role,
    String emailId,
    String password,
  ) {
    return employeeAuthRemoteDataSource.login(
      role: role,
      emailId: emailId,
      password: password,
    );
  }

  @override
  Future<void> employeeAuthLogOut() async {
    await employeeAuthRemoteDataSource.logOut();
  }
}
