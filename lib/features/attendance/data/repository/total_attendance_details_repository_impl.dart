import 'package:fuoday/core/providers/app_internet_checker_provider.dart';
import 'package:fuoday/features/attendance/data/datasources/local/total_attendance_details_local_data_source.dart';
import 'package:fuoday/features/attendance/data/datasources/remote/total_attendance_details_remote_data_source.dart';
import 'package:fuoday/features/attendance/domain/entities/total_attendance_details_entity.dart';
import 'package:fuoday/features/attendance/domain/repository/total_attendance_details_repository.dart';

class TotalAttendanceDetailsRepositoryImpl
    implements TotalAttendanceDetailsRepository {
  final TotalAttendanceDetailsRemoteDataSource
  totalAttendanceDetailsRemoteDataSource;
  final TotalAttendanceDetailsLocalDataSource
  totalAttendanceDetailsLocalDataSource;
  final AppInternetCheckerProvider appInternetCheckerProvider;

  TotalAttendanceDetailsRepositoryImpl({
    required this.totalAttendanceDetailsRemoteDataSource,
    required this.totalAttendanceDetailsLocalDataSource,
    required this.appInternetCheckerProvider,
  });

  @override
  Future<TotalAttendanceDetailsEntity> getTotalAttendanceDetails(
    int webUserId,
  ) async {
    final isConnected = await appInternetCheckerProvider.isNetworkConnected;

    if (isConnected) {
      // ✅ Online: fetch from API and cache locally
      final remoteModel = await totalAttendanceDetailsRemoteDataSource
          .getTotalAttendanceDetails(webUserId);

      await totalAttendanceDetailsLocalDataSource.cacheTotalAttendanceDetails(
        remoteModel,
      );

      return remoteModel;
    } else {
      // ✅ Offline: fetch from Hive
      final localModel = await totalAttendanceDetailsLocalDataSource
          .getTotalAttendanceDetailsLocalHive();

      if (localModel == null) {
        throw Exception("No cached attendance details found");
      }

      return localModel;
    }
  }
}
