
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/time_tracker/data/models/tracker_model.dart';

class TrackerRemoteDataSource {
  final DioService dio;
  TrackerRemoteDataSource({required this.dio});

  Future<TrackerModel> getTracker(String webUserId) async {
    final response = await dio.get('/hrms/timetracker/gettracker/$webUserId');
    return TrackerModel.fromJson(response.data['data']);
  }
}
