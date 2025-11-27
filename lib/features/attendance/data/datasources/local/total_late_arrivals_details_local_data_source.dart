import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/attendance/data/models/total_late_arrivals_details_model.dart';

class TotalLateArrivalsDetailsLocalDataSource {
  final HiveStorageService hiveStorageService;

  TotalLateArrivalsDetailsLocalDataSource({required this.hiveStorageService});

  Future<void> cacheLateArrivalsDetails(
    TotalLateArrivalsDetailsModel details,
  ) async {
    await hiveStorageService.put(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.totalLateArrivalsDetails,
      details.toJson(),
    );
  }

  Future<TotalLateArrivalsDetailsModel?>
  getLateArrivalsDetailsLocalHive() async {
    final data = await hiveStorageService.get<Map<String, dynamic>>(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.totalLateArrivalsDetails,
    );

    if (data == null) return null;
    return TotalLateArrivalsDetailsModel.fromJson(data);
  }
}
