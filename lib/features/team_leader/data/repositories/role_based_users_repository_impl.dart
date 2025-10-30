import 'package:fuoday/features/team_leader/data/datasource/role_based_users_remote_datasource.dart';
import 'package:fuoday/features/team_leader/domain/entities/role_based_users_entity.dart';
import 'package:fuoday/features/team_leader/domain/repository/role_based_users_repository.dart';

class RoleBasedUsersRepositoryImpl implements RoleBasedUsersRepository {
  final RoleBasedUsersRemoteDataSource remoteDataSource;

  RoleBasedUsersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<RoleBasedUsersEntity> getAllRoleBasedUsers(int webUserId) async {
    final model = await remoteDataSource.getAllRoleBasedUsers(webUserId);
    return model.toEntity();
  }
}
