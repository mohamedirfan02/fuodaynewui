import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/attendance/data/models/total_early_arrivals_details_model.dart';

class TotalEarlyArrivalsDetailsLocalDataSource {
  final HiveStorageService hiveStorageService;

  TotalEarlyArrivalsDetailsLocalDataSource({required this.hiveStorageService});

  Future<void> cacheEarlyArrivalDetails(
    EarlyArrivalsDetailsModel details,
  ) async {
    await hiveStorageService.put(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.totalEarlyArrivalsDetails,
      details.toJson(),
    );
  }

  Future<EarlyArrivalsDetailsModel?> getEarlyArrivalDetailsLocalHive() async {
    final data = await hiveStorageService.get<Map<String, dynamic>>(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.totalEarlyArrivalsDetails,
    );

    if (data == null) return null;
    return EarlyArrivalsDetailsModel.fromJson(data);
  }
}
