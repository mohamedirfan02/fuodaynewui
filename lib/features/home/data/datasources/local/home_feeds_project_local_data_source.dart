import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/home/data/model/home_feeds_project_data_model.dart';

class HomeFeedsProjectLocalDataSource {
  final HiveStorageService hiveStorageService;

  HomeFeedsProjectLocalDataSource({required this.hiveStorageService});

  Future<void> cacheHomeFeeds(HomeFeedsProjectDataModel feeds) async {
    await hiveStorageService.put(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.homeFeedsProject,
      feeds.toJson(),
    );
  }

  Future<HomeFeedsProjectDataModel?> getHomeFeedsLocalHive() async {
    final data = await hiveStorageService.get<Map<String, dynamic>>(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.homeFeedsProject,
    );

    if (data == null) return null;
    return HomeFeedsProjectDataModel.fromJson(data);
  }
}
