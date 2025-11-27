import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/attendance/data/models/total_early_arrivals_details_model.dart';

class TotalEarlyArrivalsDetailsRemoteDataSource {
  final DioService dioService;

  TotalEarlyArrivalsDetailsRemoteDataSource({required this.dioService});

  Future<EarlyArrivalsDetailsModel> getEarlyArrivalDetails(int webUserId) async {
    final response = await dioService.get(
      AppApiEndpointConstants.getEarlyArrivalsDetails(webUserId),
    );

    return EarlyArrivalsDetailsModel.fromJson(response.data);
  }
}

