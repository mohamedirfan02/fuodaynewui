import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/teams/data/models/team_reportees_model.dart';

class TeamReporteesRemoteDataSource {
  final DioService dioService;

  TeamReporteesRemoteDataSource({required this.dioService});

  Future<List<TeamReporteesModel>> getReportees(String webUserId) async {
    final response = await dioService.get(
      AppApiEndpointConstants.teamReport(webUserId),
    );

    final List<dynamic> data = response.data['data'] ?? [];

    return data.map((json) => TeamReporteesModel.fromJson(json)).toList();
  }
}
