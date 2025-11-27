
import 'package:fuoday/features/time_tracker/data/datasources/remote/tracker_remote_datasource.dart';
import 'package:fuoday/features/time_tracker/domain/entities/time_tracker_entity.dart';
import 'package:fuoday/features/time_tracker/domain/repositiory/time_tracker_repository.dart';

class TimeTrackerRepositoryImpl implements TimeTrackerRepository {
  final TrackerRemoteDataSource remote;
  TimeTrackerRepositoryImpl({required this.remote});
  @override
  Future<TimeTrackerEntity> getTimeTracker(String webUserId) async {
    final model = await remote.getTracker(webUserId);
    return model.toEntity();
  }
}
