import 'package:fuoday/core/providers/app_internet_checker_provider.dart';
import 'package:fuoday/features/attendance/data/datasources/local/total_late_arrivals_details_local_data_source.dart';
import 'package:fuoday/features/attendance/data/datasources/remote/total_late_arrivals_details_remote_data_source.dart';
import 'package:fuoday/features/attendance/domain/entities/total_late_arrivals_details_entity.dart';
import 'package:fuoday/features/attendance/domain/repository/total_late_arrivals_details_repository.dart';

class TotalLateArrivalsDetailsRepositoryImpl
    implements TotalLateArrivalsDetailsRepository {
  final TotalLateArrivalsDetailsRemoteDataSource
  totalLateArrivalsDetailsRemoteDataSource;
  final TotalLateArrivalsDetailsLocalDataSource
  totalLateArrivalsDetailsLocalDataSource;
  final AppInternetCheckerProvider appInternetCheckerProvider;

  TotalLateArrivalsDetailsRepositoryImpl({
    required this.totalLateArrivalsDetailsRemoteDataSource,
    required this.totalLateArrivalsDetailsLocalDataSource,
    required this.appInternetCheckerProvider,
  });

  @override
  Future<TotalLateArrivalsDetailsEntity> getTotalLateArrivalsDetails(
    int webUserId,
  ) async {
    final isConnected = appInternetCheckerProvider.isNetworkConnected;

    if (isConnected) {
      // ✅ Online: fetch from API & cache locally
      final remoteModel = await totalLateArrivalsDetailsRemoteDataSource
          .getTotalLateArrivalsDetails(webUserId);

      await totalLateArrivalsDetailsLocalDataSource.cacheLateArrivalsDetails(
        remoteModel,
      );

      return remoteModel;
    } else {
      // ✅ Offline: fetch from Hive
      final localModel = await totalLateArrivalsDetailsLocalDataSource
          .getLateArrivalsDetailsLocalHive();

      if (localModel == null) {
        throw Exception("No cached late arrivals details found");
      }

      return localModel;
    }
  }
}
