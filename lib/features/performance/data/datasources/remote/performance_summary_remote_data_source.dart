import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/performance/data/models/performance_summary_model.dart';

class PerformanceRemoteDataSource {
  final DioService dioService;

  PerformanceRemoteDataSource({required this.dioService});

  Future<PerformanceSummaryModel> getPerformanceSummary(int webUserId) async {
    final response = await dioService.get(
      AppApiEndpointConstants.getPerformanceSummary(webUserId),
    );

    // 🔥 Correctly extract the nested "data" field
    final summaryJson = response.data['data'];

    return PerformanceSummaryModel.fromJson(summaryJson);
  }
}
