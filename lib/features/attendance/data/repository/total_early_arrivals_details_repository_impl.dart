import 'package:fuoday/core/providers/app_internet_checker_provider.dart';
import 'package:fuoday/features/attendance/data/datasources/local/total_early_arrivals_details_local_data_source.dart';
import 'package:fuoday/features/attendance/data/datasources/remote/total_early_arrivals_details_remote_data_source.dart';
import 'package:fuoday/features/attendance/domain/entities/total_early_arrivals_details_entity.dart';
import 'package:fuoday/features/attendance/domain/repository/total_early_arrivals_details_repository.dart';

class TotalEarlyArrivalsDetailsRepositoryImpl
    implements TotalEarlyArrivalsDetailsRepository {
  final TotalEarlyArrivalsDetailsRemoteDataSource
  totalEarlyArrivalsDetailsRemoteDataSource;
  final TotalEarlyArrivalsDetailsLocalDataSource
  totalEarlyArrivalsDetailsLocalDataSource;
  final AppInternetCheckerProvider appInternetCheckerProvider;

  TotalEarlyArrivalsDetailsRepositoryImpl({
    required this.totalEarlyArrivalsDetailsRemoteDataSource,
    required this.totalEarlyArrivalsDetailsLocalDataSource,
    required this.appInternetCheckerProvider,
  });

  @override
  Future<EarlyArrivalsEntity> getTotalEarlyArrivalsDetails(
    int webUserId,
  ) async {
    final isConnected = appInternetCheckerProvider.isNetworkConnected;

    if (isConnected) {
      // ✅ Online: fetch from API and cache locally
      final remoteModel = await totalEarlyArrivalsDetailsRemoteDataSource
          .getEarlyArrivalDetails(webUserId);

      await totalEarlyArrivalsDetailsLocalDataSource.cacheEarlyArrivalDetails(
        remoteModel,
      );

      return remoteModel;
    } else {
      // ✅ Offline: fetch from local Hive
      final localModel = await totalEarlyArrivalsDetailsLocalDataSource
          .getEarlyArrivalDetailsLocalHive();

      if (localModel == null) {
        throw Exception("No cached early arrivals details found");
      }

      return localModel;
    }
  }
}
