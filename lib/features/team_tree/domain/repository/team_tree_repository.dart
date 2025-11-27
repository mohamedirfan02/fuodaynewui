import 'package:fuoday/features/team_tree/domain/entities/team_tree_entity.dart';

abstract class TeamTreeRepository {
  Future<List<TeamTreeEntity>> getTeamTree(int webUserId);
}