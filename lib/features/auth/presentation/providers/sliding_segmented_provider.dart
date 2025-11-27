import 'package:flutter/material.dart';


class SlidingSegmentedProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  bool get isEmployee => _selectedIndex == 0;

  bool get isRecruiter => _selectedIndex == 1;

  void setSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  void selectEmployee() {
    setSelectedIndex(0);
  }

  void selectRecruiter() {
    setSelectedIndex(1);
  }

  void reset() {
    _selectedIndex = 0;
    notifyListeners();
  }
}
