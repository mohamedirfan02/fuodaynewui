import 'package:fuoday/features/profile/data/datasources/employee_profile_remote_datasource.dart';
import 'package:fuoday/features/profile/data/mappers/employee_profile_mapper.dart';
import 'package:fuoday/features/profile/domain/entities/employee_profile_entity.dart';
import 'package:fuoday/features/profile/domain/repository/employee_profile_repository.dart';

class EmployeeProfileRepositoryImpl implements EmployeeProfileRepository {
  final EmployeeProfileRemoteDataSource remoteDataSource;

  EmployeeProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<EmployeeProfileEntity> getProfile(String webUserId) async {
    final model = await remoteDataSource.getEmployeeProfile(webUserId);
    return EmployeeProfileMapper.toEntity(model);
  }
}
