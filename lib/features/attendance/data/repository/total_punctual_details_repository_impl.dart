import 'package:fuoday/features/attendance/domain/entities/total_punctual_arrivals_details_entity.dart';
import 'package:fuoday/features/attendance/domain/repository/total_punctual_details_repository.dart';

import '../datasources/remote/total_punctual_arrivals_details_remote_data_source.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TotalPunctualArrivalsDetailsEntity> getTotalPunctualArrivalDetails(int webUserId) async {
    try {
      print('🔍 Repository: Fetching punctual arrival details for webUserId: $webUserId');

      final result = await remoteDataSource.getTotalPunctualArrivalDetails(webUserId);

      print('✅ Repository: Successfully got data from remote source');
      print('✅ Repository: Result type: ${result.runtimeType}');
      print('✅ Repository: Has data: ${result.data != null}');
      print('✅ Repository: Records count: ${result.data?.punctualArrivalsDetails?.length}');

      return result;
    } catch (e, stackTrace) {
      print('❌ Repository Error: $e');
      print('❌ Repository Stack: $stackTrace');
      rethrow;
    }
  }
}