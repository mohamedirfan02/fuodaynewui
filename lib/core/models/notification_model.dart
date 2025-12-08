import 'package:hive/hive.dart';

part 'notification_model.g.dart';

@HiveType(typeId: 5) // Use a unique typeId (make sure it's not used by other models)
class NotificationModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String body;

  @HiveField(3)
  DateTime timestamp;

  @HiveField(4)
  bool isRead;

  @HiveField(5)
  String? payload;

  @HiveField(6)
  String? type; // 'checkin', 'checkout', 'info', 'alert'

  @HiveField(7)
  DateTime? checkInTime;

  @HiveField(8)
  DateTime? checkOutTime;

  @HiveField(9)
  String? checkInLocation;

  @HiveField(10)
  String? checkOutLocation;

  @HiveField(11)
  String? workDuration;

  @HiveField(12)
  String? date;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
    this.payload,
    this.type,
    this.checkInTime,
    this.checkOutTime,
    this.checkInLocation,
    this.checkOutLocation,
    this.workDuration,
    this.date,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'timestamp': timestamp.toIso8601String(),
    'isRead': isRead,
    'payload': payload,
    'type': type,
    'checkInTime': checkInTime?.toIso8601String(),
    'checkOutTime': checkOutTime?.toIso8601String(),
    'checkInLocation': checkInLocation,
    'checkOutLocation': checkOutLocation,
    'workDuration': workDuration,
    'date': date,
  };

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'] ?? false,
      payload: json['payload'],
      type: json['type'],
      checkInTime: json['checkInTime'] != null
          ? DateTime.parse(json['checkInTime'])
          : null,
      checkOutTime: json['checkOutTime'] != null
          ? DateTime.parse(json['checkOutTime'])
          : null,
      checkInLocation: json['checkInLocation'],
      checkOutLocation: json['checkOutLocation'],
      workDuration: json['workDuration'],
      date: json['date'],
    );
  }
}