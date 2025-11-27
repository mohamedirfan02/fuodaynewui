import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/attendance/data/models/total_absent_details_model.dart';

class TotalAbsentDetailsLocalDataSource {
  final HiveStorageService hiveStorageService;

  TotalAbsentDetailsLocalDataSource({required this.hiveStorageService});

  Future<void> cacheAbsentDetails(TotalAbsentDetailsModel details) async {
    await hiveStorageService.put(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.totalAbsentDetails,
      details.toJson(),
    );
  }

  Future<TotalAbsentDetailsModel?> getAbsentDetailsLocalHive() async {
    final data = await hiveStorageService.get<Map<String, dynamic>>(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.totalAbsentDetails,
    );

    if (data == null) return null;
    return TotalAbsentDetailsModel.fromJson(data);
  }
}
