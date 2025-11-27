

import 'package:fuoday/features/team_tree/domain/entities/team_tree_entity.dart';
import 'package:fuoday/features/team_tree/domain/repository/team_tree_repository.dart';

class GetTeamTreeUseCase {
  final TeamTreeRepository repository;

  GetTeamTreeUseCase(this.repository);

  Future<List<TeamTreeEntity>> call(int webUserId) {
    return repository.getTeamTree(webUserId);
  }
}
