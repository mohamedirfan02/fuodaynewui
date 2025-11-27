// 1. Entity (domain/entities/checkin_entity.dart)
class CheckInEntity {
  final int webUserId;
  final String time;
  final bool isCheckIn;


  CheckInEntity({
    required this.webUserId,
    required this.time,
    required this.isCheckIn,

  });
}
