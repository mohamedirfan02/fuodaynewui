import 'package:fuoday/features/home/data/datasources/remote/checkin_status_remote_data_source.dart';
import 'package:fuoday/features/home/domain/entities/checkin_status_entity.dart';
import 'package:fuoday/features/home/domain/repositories/checkin_status_repository.dart';

class CheckinStatusRepositoryImpl implements CheckinStatusRepository {
  final CheckinStatusRemoteDataSource _remoteDataSource;

  CheckinStatusRepositoryImpl(this._remoteDataSource);

  @override
  Future<CheckinStatusEntity> getCheckinStatus(int webUserId) async {
    try {
      final model = await _remoteDataSource.getCheckinStatus(webUserId);
      return CheckinStatusEntity(
        checkin: model.checkin,
        checkout: model.checkout,
        location: model.location,
      );
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}