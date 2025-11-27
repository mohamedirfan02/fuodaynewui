import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/home/data/model/checkin_status_model.dart';

abstract class CheckinStatusRemoteDataSource {
  Future<CheckinStatusModel> getCheckinStatus(int webUserId);
}

class CheckinStatusRemoteDataSourceImpl implements CheckinStatusRemoteDataSource {
  final DioService _dioService;

  CheckinStatusRemoteDataSourceImpl(this._dioService);

  @override
  Future<CheckinStatusModel> getCheckinStatus(int webUserId) async {
    try {
      final response = await _dioService.get('/hrms/home/getactivities/$webUserId');

      if (response.statusCode == 200) {
        final checkinStatusResponse = CheckinStatusResponse.fromJson(response.data);
        return checkinStatusResponse.data;
      } else {
        throw Exception('Failed to get checkin status');
      }
    } catch (e) {
      throw Exception('Error getting checkin status: $e');
    }
  }
}