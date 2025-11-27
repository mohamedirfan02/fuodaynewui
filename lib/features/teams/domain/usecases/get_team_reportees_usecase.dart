import 'package:fuoday/features/teams/domain/entities/team_reportees_entity.dart';
import 'package:fuoday/features/teams/domain/repository/team_reportees_repository.dart';

class GetTeamReporteesUseCase {
  final TeamReporteesRepository repository;

  GetTeamReporteesUseCase({required this.repository});

  Future<List<TeamReporteesEntity>> call(String webUserId) {
    return repository.getReportees(webUserId);
  }
}
