import 'package:fuoday/features/teams/domain/entities/team_member_entity.dart';

abstract class TeamMemberRepository {
  Future<List<TeamMemberEntity>> getTeamMembers(String webUserId);
}
