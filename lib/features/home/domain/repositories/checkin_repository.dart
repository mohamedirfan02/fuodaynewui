import 'package:fuoday/features/home/domain/entities/checkin_entity.dart';

abstract class CheckInRepository {
  Future<CheckInEntity?> checkIn(CheckInEntity entity);
  Future<CheckInEntity?> checkOut(CheckInEntity entity);
}
