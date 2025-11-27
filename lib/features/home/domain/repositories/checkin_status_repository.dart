import 'package:fuoday/features/home/domain/entities/checkin_status_entity.dart';

abstract class CheckinStatusRepository {
  Future<CheckinStatusEntity> getCheckinStatus(int webUserId);
}