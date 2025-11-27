import 'package:fuoday/features/home/domain/entities/checkin_entity.dart';

class CheckInModel extends CheckInEntity {
  CheckInModel({
    required super.webUserId,
    required super.time,
    required super.isCheckIn,
  });

  factory CheckInModel.fromJson(Map<String, dynamic> json) {
    return CheckInModel(
      webUserId: json['web_user_id'] ?? 0,
      time: json['checkin'] ?? json['checkout'] ?? '',
      isCheckIn: json.containsKey('checkin'),
    );
  }

  Map<String, dynamic> toJson() {
    if (isCheckIn) {
      return {'web_user_id': webUserId, 'checkin': time};
    } else {
      return {'web_user_id': webUserId, 'checkout': time};
    }
  }
}
