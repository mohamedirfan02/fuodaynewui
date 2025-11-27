import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/attendance/data/models/total_late_arrivals_details_model.dart';

class TotalLateArrivalsDetailsRemoteDataSource {
  final DioService dioService;

  TotalLateArrivalsDetailsRemoteDataSource({required this.dioService});

  Future<TotalLateArrivalsDetailsModel> getTotalLateArrivalsDetails(
    int webUserId,
  ) async {
    final response = await dioService.get(
      AppApiEndpointConstants.getLateAttendanceLateArrivalsDetails(webUserId),
    );

    final data = response.data['data'];
    return TotalLateArrivalsDetailsModel.fromJson(data);
  }
}
