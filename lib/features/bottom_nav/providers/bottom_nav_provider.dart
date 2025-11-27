import 'package:flutter/material.dart';
import 'package:fuoday/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:fuoday/features/home/presentation/screens/hrms_screens/home_employee_screen.dart';
import 'package:fuoday/features/leave_tracker/presentation/screens/leave_tracker_screen.dart';
import 'package:fuoday/features/notification/presentation/screens/notification_screen.dart';
import 'package:fuoday/features/profile/presentation/screens/profile_screen.dart';

class BottomNavProvider extends ChangeNotifier {
  int _currentIndex = 2;

  int get currentIndex => _currentIndex;

  // Pages
  final List<Widget> _pages = [
    const NotificationScreen(),

    const LeaveTrackerScreen(),

    const HomeEmployeeScreen(),

    const CalendarScreen(),

    const ProfileScreen(),
  ];

  List<Widget> get pages => _pages;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Widget get currentPage => _pages[currentIndex];
}
