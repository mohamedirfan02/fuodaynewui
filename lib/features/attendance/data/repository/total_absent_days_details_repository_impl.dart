import 'package:fuoday/core/providers/app_internet_checker_provider.dart';
import 'package:fuoday/features/attendance/data/datasources/local/total_absent_details_local_data_source.dart';
import 'package:fuoday/features/attendance/data/datasources/remote/total_absent_details_remote_data_source.dart';
import 'package:fuoday/features/attendance/domain/entities/total_absent_details_entity.dart';
import 'package:fuoday/features/attendance/domain/repository/total_absent_details_repository.dart';

class TotalAbsentDaysDetailsRepositoryImpl
    implements TotalAbsentDetailsRepository {
  final TotalAbsentDetailsRemoteDataSource totalAbsentDetailsRemoteDataSource;
  final TotalAbsentDetailsLocalDataSource totalAbsentDetailsLocalDataSource;
  final AppInternetCheckerProvider appInternetCheckerProvider;

  TotalAbsentDaysDetailsRepositoryImpl({
    required this.totalAbsentDetailsRemoteDataSource,
    required this.totalAbsentDetailsLocalDataSource,
    required this.appInternetCheckerProvider,
  });

  @override
  Future<TotalAbsentDetailsEntity> getTotalAbsentDetails(int webUserId) async {
    final isConnected = appInternetCheckerProvider.isNetworkConnected;

    if (isConnected) {
      // ✅ Online: fetch from API & cache locally
      final remoteModel = await totalAbsentDetailsRemoteDataSource
          .getTotalAbsentDaysDetails(webUserId);

      await totalAbsentDetailsLocalDataSource.cacheAbsentDetails(remoteModel);

      return remoteModel;
    } else {
      // ✅ Offline: fetch from Hive
      final localModel = await totalAbsentDetailsLocalDataSource
          .getAbsentDetailsLocalHive();

      if (localModel == null) {
        throw Exception("No cached absent details found");
      }

      return localModel;
    }
  }
}
