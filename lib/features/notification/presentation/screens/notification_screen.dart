import 'package:flutter/material.dart';
import 'package:fuoday/commons/widgets/k_app_%20bar_with_drawer.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/core/di/injection.dart' show getIt;
import 'package:fuoday/core/service/hive_storage_service.dart';

import 'notification_card.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _headerAnimationController;
  late AnimationController _listAnimationController;
  late Animation<double> _headerAnimation;
  late Animation<double> _listAnimation;

  @override
  void initState() {
    super.initState();
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _listAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _headerAnimation = CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeOutCubic,
    );
    _listAnimation = CurvedAnimation(
      parent: _listAnimationController,
      curve: Curves.easeOutCubic,
    );

    // Start animations
    _headerAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _listAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _listAnimationController.dispose();
    super.dispose();
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  // Premium sample notification data
  final List<NotificationItem> notifications = [
    NotificationItem(
      id: '1',
      title: 'Project Milestone Achieved',
      message:
          'Congratulations! Your team has successfully completed Phase 2 of the Digital Transformation project.',
      type: NotificationType.achievement,
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      isRead: false,
      priority: NotificationPriority.high,
      avatar: '🎉',
    ),
    NotificationItem(
      id: '2',
      title: 'Executive Meeting Invitation',
      message:
          'You\'ve been invited to the quarterly board meeting. Please review the attached agenda.',
      type: NotificationType.meeting,
      timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
      isRead: false,
      priority: NotificationPriority.high,
      avatar: '👔',
    ),
    NotificationItem(
      id: '3',
      title: 'Bonus Payment Processed',
      message:
          'Your performance bonus of \$2,500 has been credited to your account.',
      type: NotificationType.financial,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      priority: NotificationPriority.medium,
      avatar: '💰',
    ),
    NotificationItem(
      id: '4',
      title: 'New Team Member',
      message:
          'Sarah Johnson has joined your development team. Welcome her aboard!',
      type: NotificationType.social,
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
      priority: NotificationPriority.low,
      avatar: '👋',
    ),
    NotificationItem(
      id: '5',
      title: 'Security Alert',
      message:
          'New login detected from iPhone. If this wasn\'t you, please secure your account.',
      type: NotificationType.security,
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: true,
      priority: NotificationPriority.high,
      avatar: '🔐',
    ),
    NotificationItem(
      id: '6',
      title: 'Training Reminder',
      message:
          'Your AI & Machine Learning certification course starts tomorrow at 10 AM.',
      type: NotificationType.education,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: false,
      priority: NotificationPriority.medium,
      avatar: '🎓',
    ),
    NotificationItem(
      id: '7',
      title: 'Holiday Announcement',
      message:
          'Company holiday declared for Christmas week. Enjoy your extended weekend!',
      type: NotificationType.announcement,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
      priority: NotificationPriority.low,
      avatar: '🎄',
    ),
  ];

  void _markAsRead(String notificationId) {
    setState(() {
      final index = notifications.indexWhere((n) => n.id == notificationId);
      if (index != -1) {
        notifications[index].isRead = true;
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No email";

    final unreadCount = notifications.where((n) => !n.isRead).length;
    final highPriorityCount = notifications
        .where((n) => !n.isRead && n.priority == NotificationPriority.high)
        .length;

    // MediaQuery responsive values
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 1024;
    final isLargeScreen = screenWidth >= 1024;

    // Responsive dimensions
    final headerHorizontalPadding = isSmallScreen
        ? 16.0
        : (isMediumScreen ? 24.0 : 32.0);
    final headerVerticalPadding = isSmallScreen
        ? 16.0
        : (isMediumScreen ? 20.0 : 24.0);
    final cardHorizontalPadding = isSmallScreen
        ? 8.0
        : (isMediumScreen ? 16.0 : 24.0);
    final titleFontSize = isSmallScreen ? 24.0 : (isMediumScreen ? 28.0 : 32.0);
    final maxContentWidth = isLargeScreen ? 800.0 : double.infinity;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: KAppBarWithDrawer(
        userName: name,
        cachedNetworkImageUrl: profilePhoto,
        userDesignation: designation,
        showUserInfo: true,
        onDrawerPressed: _openDrawer,
        onNotificationPressed: () {},
      ),
      drawer: KDrawer(
        userName: name,
        userEmail: email,
        profileImageUrl: profilePhoto,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth),
          child: Column(
            children: [
              // Premium Header with Glassmorphism Effect
              AnimatedBuilder(
                animation: _headerAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, -50 * (1 - _headerAnimation.value)),
                    child: Opacity(
                      opacity: _headerAnimation.value,
                      child: Container(
                        margin: EdgeInsets.all(headerHorizontalPadding),
                        padding: EdgeInsets.all(headerVerticalPadding),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(
                            isSmallScreen ? 16 : 20,
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: isSmallScreen ? 15 : 20,
                              offset: const Offset(0, 10),
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.8),
                              blurRadius: isSmallScreen ? 8 : 10,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            isSmallScreen
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildHeaderContent(
                                        titleFontSize,
                                        unreadCount,
                                        highPriorityCount,
                                        isSmallScreen,
                                      ),
                                      if (unreadCount > 0) ...[
                                        const SizedBox(height: 16),
                                        _buildMarkAllReadButton(isSmallScreen),
                                      ],
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: _buildHeaderContent(
                                          titleFontSize,
                                          unreadCount,
                                          highPriorityCount,
                                          isSmallScreen,
                                        ),
                                      ),
                                      if (unreadCount > 0) ...[
                                        const SizedBox(width: 16),
                                        _buildMarkAllReadButton(isSmallScreen),
                                      ],
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Premium Notifications List
              Expanded(
                child: AnimatedBuilder(
                  animation: _listAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 30 * (1 - _listAnimation.value)),
                      child: Opacity(
                        opacity: _listAnimation.value,
                        child: notifications.isEmpty
                            ? _buildEmptyState(isSmallScreen)
                            : ListView.builder(
                                padding: EdgeInsets.only(
                                  left: cardHorizontalPadding,
                                  right: cardHorizontalPadding,
                                  bottom: headerHorizontalPadding,
                                ),
                                itemCount: notifications.length,
                                itemBuilder: (context, index) {
                                  return AnimatedBuilder(
                                    animation: _listAnimation,
                                    builder: (context, child) {
                                      final delay = index * 0.1;
                                      final animationValue = Curves.easeOutCubic
                                          .transform(
                                            (_listAnimation.value - delay)
                                                    .clamp(0.0, 1.0) /
                                                (1.0 - delay),
                                          );

                                      return Transform.translate(
                                        offset: Offset(
                                          0,
                                          50 * (1 - animationValue),
                                        ),
                                        child: Opacity(
                                          opacity: animationValue,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                              bottom: isSmallScreen ? 8 : 12,
                                            ),
                                            child: PremiumNotificationCard(
                                              notification:
                                                  notifications[index],
                                              onTap: () => _markAsRead(
                                                notifications[index].id,
                                              ),
                                              isSmallScreen: isSmallScreen,
                                              isMediumScreen: isMediumScreen,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderContent(
    double titleFontSize,
    int unreadCount,
    int highPriorityCount,
    bool isSmallScreen,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 12),
              ),
              child: Icon(
                Icons.notifications_active,
                color: Colors.white,
                size: isSmallScreen ? 16 : 20,
              ),
            ),
            SizedBox(width: isSmallScreen ? 8 : 12),
            Flexible(
              child: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A202C),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: isSmallScreen ? 6 : 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            _buildStatsChip(
              '$unreadCount Unread',
              Colors.blue,
              Icons.mark_email_unread,
              isSmallScreen,
            ),
            if (highPriorityCount > 0)
              _buildStatsChip(
                '$highPriorityCount Urgent',
                Colors.red,
                Icons.priority_high,
                isSmallScreen,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildMarkAllReadButton(bool isSmallScreen) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
        ),
        borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 25),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.3),
            blurRadius: isSmallScreen ? 6 : 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 25),
          onTap: _markAllAsRead,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 16 : 20,
              vertical: isSmallScreen ? 10 : 12,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.done_all,
                  color: Colors.white,
                  size: isSmallScreen ? 16 : 18,
                ),
                SizedBox(width: isSmallScreen ? 4 : 6),
                Text(
                  isSmallScreen ? 'Mark Read' : 'Mark All Read',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsChip(
    String text,
    Color color,
    IconData icon, [
    bool isSmallScreen = false,
  ]) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 10 : 12,
        vertical: isSmallScreen ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isSmallScreen ? 12 : 14, color: color),
          SizedBox(width: isSmallScreen ? 3 : 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: isSmallScreen ? 10 : 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState([bool isSmallScreen = false]) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 20 : 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade100, Colors.grey.shade50],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none,
              size: isSmallScreen ? 48 : 64,
              color: Colors.grey.shade400,
            ),
          ),
          SizedBox(height: isSmallScreen ? 16 : 24),
          Text(
            'All Caught Up!',
            style: TextStyle(
              fontSize: isSmallScreen ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: isSmallScreen ? 6 : 8),
          Text(
            'No new notifications right now',
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final NotificationPriority priority;
  final String avatar;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.priority,
    required this.avatar,
    required this.isRead,
  });
}

enum NotificationType {
  achievement,
  meeting,
  financial,
  social,
  security,
  education,
  announcement,
}

enum NotificationPriority { high, medium, low }
