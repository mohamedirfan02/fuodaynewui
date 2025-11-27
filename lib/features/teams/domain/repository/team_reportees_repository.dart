import 'package:fuoday/features/teams/domain/entities/team_reportees_entity.dart';

abstract class TeamReporteesRepository {
  Future<List<TeamReporteesEntity>> getReportees(String webUserId);
}
