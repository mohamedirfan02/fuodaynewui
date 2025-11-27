import 'package:flutter/material.dart';
import 'package:fuoday/features/home/presentation/screens/ats_screens/home_recruiter_screen.dart';

class RecruiterBottomNavProvider extends ChangeNotifier {
  int _currentIndex = 2;

  int get currentIndex => _currentIndex;

  // Recruiter-specific Pages
  final List<Widget> _pages = [
    const HomeRecruiterScreen(), // Index 0

    const HomeRecruiterScreen(), // Index 1 (instead of LeaveTracker)

    const HomeRecruiterScreen(), // Index 2 (instead of HomeEmployee)

    const HomeRecruiterScreen(), // Index 3

    const HomeRecruiterScreen(), // Index 4
  ];

  List<Widget> get pages => _pages;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Widget get currentPage => _pages[currentIndex];
}
