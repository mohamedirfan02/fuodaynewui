import 'package:fuoday/features/home/data/datasources/remote/check_in_remote_data_source.dart';
import 'package:fuoday/features/home/data/model/checkin_model.dart';
import 'package:fuoday/features/home/domain/entities/checkin_entity.dart';
import 'package:fuoday/features/home/domain/repositories/checkin_repository.dart';

class CheckInRepositoryImpl implements CheckInRepository {
  final CheckInRemoteDataSource remoteDataSource;

  CheckInRepositoryImpl({required this.remoteDataSource});

  @override
  Future<CheckInEntity?> checkIn(CheckInEntity entity) async {
    try {
      final model = CheckInModel(
        webUserId: entity.webUserId,
        time: entity.time,
        isCheckIn: true,
      );

      final result = await remoteDataSource.checkIn(model);
      return result;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<CheckInEntity?> checkOut(CheckInEntity entity) async {
    try {
      final model = CheckInModel(
        webUserId: entity.webUserId,
        time: entity.time,
        isCheckIn: false,
      );

      final result = await remoteDataSource.checkOut(model);
      return result;
    } catch (e) {
      return null;
    }
  }
}
