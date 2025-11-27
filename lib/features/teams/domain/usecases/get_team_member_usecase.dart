import 'package:fuoday/features/teams/domain/entities/team_member_entity.dart';
import 'package:fuoday/features/teams/domain/repository/team_member_respository.dart';

class GetTeamMemberUseCase {
  final TeamMemberRepository teamMemberRepository;

  GetTeamMemberUseCase({required this.teamMemberRepository});

  Future<List<TeamMemberEntity>> call(String webUserId) {
    return teamMemberRepository.getTeamMembers(webUserId);
  }
}
