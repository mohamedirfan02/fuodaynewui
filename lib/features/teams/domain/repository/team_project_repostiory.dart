import 'package:fuoday/features/teams/domain/entities/team_project_entity.dart';

abstract class TeamProjectRepository {
  Future<List<TeamProjectEntity>> getTeamProjects(String webUserId);
}
