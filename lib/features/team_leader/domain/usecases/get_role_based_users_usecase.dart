import 'package:fuoday/features/team_leader/domain/entities/role_based_users_entity.dart';
import 'package:fuoday/features/team_leader/domain/repository/role_based_users_repository.dart';

class GetRoleBasedUsersUseCase {
  final RoleBasedUsersRepository repository;

  GetRoleBasedUsersUseCase({required this.repository});

  Future<RoleBasedUsersEntity> cell(int webUserId) {
    return repository.getAllRoleBasedUsers(webUserId);
  }
}
