import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/attendance/data/models/total_absent_details_model.dart';

class TotalAbsentDetailsRemoteDataSource {
  final DioService dioService;

  TotalAbsentDetailsRemoteDataSource({required this.dioService});

  Future<TotalAbsentDetailsModel> getTotalAbsentDaysDetails(
    int webUserId,
  ) async {
    final response = await dioService.get(
      AppApiEndpointConstants.getAbsentDaysDetails(webUserId),
    );

    return TotalAbsentDetailsModel.fromJson(response.data);
  }
}
