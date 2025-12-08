import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fuoday/common_main.dart';

class NotificationHelper {
  static Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'attendance_channel', // channel id
      'Attendance Notifications', // channel name
      channelDescription: 'Notifications for attendance check-in/out',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // notification ID
      title,
      body,
      notificationDetails,
    );
  }
}
