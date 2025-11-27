import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/manager/data/datasources/all_regulations_remote_data_source.dart';
import 'package:fuoday/features/manager/domain/entities/all_regulations_entity.dart';
import 'package:fuoday/features/manager/domain/repository/all_regulations_repository.dart';

class AllRegulationsRepositoryImpl implements AllRegulationsRepository {
  final AllRegulationsRemoteDataSource remoteDataSource;

  AllRegulationsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AllRegulationsEntity> getAllRegulations(int webUserId) async {
    try {
      final result = await remoteDataSource.getAllRegulations(webUserId);
      return result;
    } catch (e) {
      AppLoggerHelper.logError("❌ Repository failed: $e");
      rethrow;
    }
  }
}
