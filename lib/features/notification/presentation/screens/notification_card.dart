import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'notification_screen.dart';

class PremiumNotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const PremiumNotificationCard({
    super.key,
    required this.notification,
    required this.onTap, required bool isSmallScreen, required bool isMediumScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: notification.isRead
            ? LinearGradient(
          colors: [Colors.white, Colors.grey.shade50],
        )
            : LinearGradient(
          colors: [Colors.white, Colors.blue.shade50.withOpacity(0.3)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: notification.isRead
              ? Colors.grey.shade200
              : _getPriorityColor(notification.priority).withOpacity(0.3),
          width: notification.isRead ? 1 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: notification.isRead
                ? Colors.black.withOpacity(0.05)
                : _getPriorityColor(notification.priority).withOpacity(0.1),
            blurRadius: notification.isRead ? 8 : 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Premium Avatar with Gradient Background
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _getGradientColors(notification.type),
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: _getGradientColors(notification.type)[0].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      notification.avatar,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: notification.isRead ? FontWeight.w600 : FontWeight.bold,
                                color: const Color(0xFF1A202C),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (!notification.isRead)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    _getPriorityColor(notification.priority),
                                    _getPriorityColor(notification.priority).withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                notification.priority.name.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification.message,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatTimestamp(notification.timestamp),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          if (!notification.isRead)
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    _getPriorityColor(notification.priority),
                                    _getPriorityColor(notification.priority).withOpacity(0.8),
                                  ],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: _getPriorityColor(notification.priority).withOpacity(0.5),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _getGradientColors(NotificationType type) {
    switch (type) {
      case NotificationType.achievement:
        return [const Color(0xFFFFD700), const Color(0xFFFFA500)];
      case NotificationType.meeting:
        return [const Color(0xFF4F46E5), const Color(0xFF7C3AED)];
      case NotificationType.financial:
        return [const Color(0xFF10B981), const Color(0xFF059669)];
      case NotificationType.social:
        return [const Color(0xFFEC4899), const Color(0xFFBE185D)];
      case NotificationType.security:
        return [const Color(0xFFEF4444), const Color(0xFFDC2626)];
      case NotificationType.education:
        return [const Color(0xFF3B82F6), const Color(0xFF2563EB)];
      case NotificationType.announcement:
        return [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)];
    }
  }

  Color _getPriorityColor(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.high:
        return const Color(0xFFEF4444);
      case NotificationPriority.medium:
        return const Color(0xFFF59E0B);
      case NotificationPriority.low:
        return const Color(0xFF10B981);
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
