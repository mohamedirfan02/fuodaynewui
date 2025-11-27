import 'package:fuoday/features/teams/domain/entities/team_project_entity.dart';
import 'package:fuoday/features/teams/domain/repository/team_project_repostiory.dart';

class GetTeamProjectsUseCase {
  final TeamProjectRepository teamProjectRepository;

  GetTeamProjectsUseCase({required this.teamProjectRepository});

  Future<List<TeamProjectEntity>> call(String webUserId) {
    return teamProjectRepository.getTeamProjects(webUserId);
  }
}
