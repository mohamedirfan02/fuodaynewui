import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/attendance/data/models/total_attendance_details_model.dart';

class TotalAttendanceDetailsRemoteDataSource {
  final DioService dioService;

  TotalAttendanceDetailsRemoteDataSource({required this.dioService});

  Future<TotalAttendanceDetailsModel> getTotalAttendanceDetails(
    int webUserId,
  ) async {
    try {
      final response = await dioService.get(
        AppApiEndpointConstants.getTotalAttendanceDetails(webUserId),
        queryParams: {'web_user_id': webUserId},
      );

      return TotalAttendanceDetailsModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
