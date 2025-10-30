import 'package:fuoday/features/team_leader/domain/entities/role_based_users_entity.dart';

abstract class RoleBasedUsersRepository {
  Future<RoleBasedUsersEntity> getAllRoleBasedUsers(int webUserId);
}
