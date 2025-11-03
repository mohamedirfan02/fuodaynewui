import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/manager/data/datasources/update_regulation_status_remote_data_source.dart';
import 'package:fuoday/features/manager/data/model/update_regulation_status_model.dart';
import 'package:fuoday/features/manager/domain/entities/update_regulation_status_entity.dart';
import 'package:fuoday/features/manager/domain/repository/update_regulation_status_repository.dart';

class UpdateRegulationStatusRepositoryImpl
    implements UpdateRegulationStatusRepository {
  final UpdateRegulationStatusRemoteDataSource remoteDataSource;

  UpdateRegulationStatusRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UpdateRegulationStatusEntity> updateRegulationStatus(
    int id,
    String status,
    String access,
    String module,
  ) async {
    try {
      final model = await remoteDataSource.updateRegulationStatus(
        id,
        status,
        access,
        module,
      );
      return model.toEntity();
    } catch (e) {
      AppLoggerHelper.logError("❌ Regulation Repository failed: $e");
      rethrow;
    }
  }
}
