import 'package:fuoday/core/constants/app_hive_storage_constants.dart';
import 'package:fuoday/core/models/notification_model.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';


class NotificationService {
  Box<NotificationModel> get _notificationsBox =>
      Hive.box<NotificationModel>(AppHiveStorageConstants.notificationsBoxKey);

  // Save Check-In Notification
  Future<void> saveCheckInNotification({
    required DateTime checkInTime,
    String? location,
  }) async {
    final id = 'checkin_${checkInTime.millisecondsSinceEpoch}';
    final date = DateFormat('yyyy-MM-dd').format(checkInTime);
    final timeStr = DateFormat('hh:mm:ss a').format(checkInTime);

    final notification = NotificationModel(
      id: id,
      title: 'Check-In Successful',
      body: 'You checked in at $timeStr${location != null ? ' at $location' : ''}',
      timestamp: checkInTime,
      type: 'checkin',
      checkInTime: checkInTime,
      checkInLocation: location,
      date: date,
      isRead: false,
    );

    await _notificationsBox.put(id, notification);
    print('✅ Check-In notification saved: $id');
  }

  // Save Check-Out Notification
  Future<void> saveCheckOutNotification({
    required DateTime checkOutTime,
    DateTime? checkInTime,
    String? location,
  }) async {
    final id = 'checkout_${checkOutTime.millisecondsSinceEpoch}';
    final date = DateFormat('yyyy-MM-dd').format(checkOutTime);
    final timeStr = DateFormat('hh:mm:ss a').format(checkOutTime);

    // Calculate work duration
    String? duration;
    if (checkInTime != null) {
      final diff = checkOutTime.difference(checkInTime);
      final hours = diff.inHours;
      final minutes = diff.inMinutes.remainder(60);
      duration = '${hours}h ${minutes}m';
    }

    final notification = NotificationModel(
      id: id,
      title: 'Check-Out Successful',
      body: 'You checked out at $timeStr${duration != null ? '\nWork Duration: $duration' : ''}',
      timestamp: checkOutTime,
      type: 'checkout',
      checkInTime: checkInTime,
      checkOutTime: checkOutTime,
      checkOutLocation: location,
      workDuration: duration,
      date: date,
      isRead: false,
    );

    await _notificationsBox.put(id, notification);
    print('✅ Check-Out notification saved: $id');
  }

  // Get all notifications
  List<NotificationModel> getAllNotifications() {
    return _notificationsBox.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  // Get notifications by type
  List<NotificationModel> getNotificationsByType(String type) {
    return _notificationsBox.values
        .where((n) => n.type == type)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  // Get unread notifications
  List<NotificationModel> getUnreadNotifications() {
    return _notificationsBox.values
        .where((notification) => !notification.isRead)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  // Get unread count
  int getUnreadCount() {
    return _notificationsBox.values
        .where((notification) => !notification.isRead)
        .length;
  }

  // Mark as read
  Future<void> markAsRead(String id) async {
    final notification = _notificationsBox.get(id);
    if (notification != null) {
      notification.isRead = true;
      await notification.save();
    }
  }

  // Mark all as read
  Future<void> markAllAsRead() async {
    for (var notification in _notificationsBox.values) {
      notification.isRead = true;
      await notification.save();
    }
  }

  // Delete notification
  Future<void> deleteNotification(String id) async {
    await _notificationsBox.delete(id);
  }

  // Clear all notifications
  Future<void> clearAllNotifications() async {
    await _notificationsBox.clear();
  }
}