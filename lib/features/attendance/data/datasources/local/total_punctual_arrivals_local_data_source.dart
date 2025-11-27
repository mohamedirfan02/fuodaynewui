import 'package:fuoday/core/constants/storage/app_hive_storage_constants.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/attendance/data/models/total_punctual_arrivals_details_model.dart';

class TotalPunctualArrivalsLocalDataSource {
  final HiveStorageService hiveStorageService;

  TotalPunctualArrivalsLocalDataSource({required this.hiveStorageService});

  Future<void> cachePunctualArrivalsDetails(
    TotalPunctualArrivalsDetailsModel details,
  ) async {
    await hiveStorageService.put(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.totalPunctualArrivalsDetails,
      details.toJson(),
    );
  }

  Future<TotalPunctualArrivalsDetailsModel?>
  getPunctualArrivalsDetailsLocalHive() async {
    final data = await hiveStorageService.get<Map<String, dynamic>>(
      AppHiveStorageConstants.apiCacheBox,
      AppHiveStorageConstants.totalPunctualArrivalsDetails,
    );

    if (data == null) return null;
    return TotalPunctualArrivalsDetailsModel.fromJson(data);
  }
}
