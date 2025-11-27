import 'package:fuoday/features/time_tracker/domain/entities/time_tracker_entity.dart';
import 'package:fuoday/features/time_tracker/domain/repositiory/time_tracker_repository.dart';

class GetTimeAndProjectTrackerUseCase {
  final TimeTrackerRepository repository;
  GetTimeAndProjectTrackerUseCase(this.repository);
  Future<TimeTrackerEntity> call(String webUserId) => repository.getTimeTracker(webUserId);
}
