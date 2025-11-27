import 'package:fuoday/features/time_tracker/domain/entities/time_tracker_entity.dart';

abstract class TimeTrackerRepository {
  Future<TimeTrackerEntity> getTimeTracker(String webUserId);
}
