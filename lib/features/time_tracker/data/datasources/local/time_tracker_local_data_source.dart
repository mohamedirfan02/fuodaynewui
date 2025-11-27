import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/time_tracker/data/models/tracker_model.dart';

class TimeTrackerLocalDataSource {
  final HiveStorageService hiveStorageService;

  TimeTrackerLocalDataSource({required this.hiveStorageService});

  Future<void> cacheTracker(TrackerModel tracker) async {
    await hiveStorageService.put(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.timeTracker,
      tracker,
    );
  }

  Future<TrackerModel?> getTrackerLocalHive() async {
    final data = await hiveStorageService.get<Map<String, dynamic>>(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.timeTracker,
    );

    if (data == null) return null;
    return TrackerModel.fromJson(data);
  }
}
