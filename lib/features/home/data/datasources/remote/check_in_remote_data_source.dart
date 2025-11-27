import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/home/data/model/checkin_model.dart';

class CheckInRemoteDataSource {
  final DioService dioService;

  CheckInRemoteDataSource({required this.dioService});

  Future<CheckInModel> checkIn(CheckInModel model) async {
    try {
      final response = await dioService.post(
        AppApiEndpointConstants.checkIn,
        data: model.toJson(),
      );
      return CheckInModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<CheckInModel> checkOut(CheckInModel model) async {
    try {
      final response = await dioService.post(
        AppApiEndpointConstants.checkOut,
        data: model.toJson(),
      );
      return CheckInModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
