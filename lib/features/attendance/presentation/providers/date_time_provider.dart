import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:intl/intl.dart';

/// TimeProvider handles updating current date/time and greeting
class DateTimeProvider extends ChangeNotifier {
  String _currentTime = "";
  String _currentDate = "";
  String _greeting = "";

  String get currentTime => _currentTime;
  String get currentDate => _currentDate;
  String get greeting => _greeting;

  DateTimeProvider() {
    _updateTime(); // initial call
    Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    DateTime now = DateTime.now();

    // Format time: 09:02:04 AM
    _currentTime = DateFormat("hh:mm:ss a").format(now);

    // Format date: 23 July 2025
    _currentDate = DateFormat("dd MMMM yyyy").format(now);

    // Greeting based on hour
    int hour = now.hour;
    if (hour >= 5 && hour < 12) {
      _greeting = "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      _greeting = "Good Afternoon";
    } else {
      _greeting = "Good Evening";
    }

    notifyListeners();
  }
}
