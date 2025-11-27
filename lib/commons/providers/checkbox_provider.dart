import 'package:flutter/material.dart';

class CheckboxProvider extends ChangeNotifier {
  final Map<String, bool> _checkboxStates = {};

  // Get checkbox state by key
  bool getCheckboxState(String key) {
    return _checkboxStates[key] ?? false;
  }

  // Set checkbox state by key
  void setCheckboxState(String key, bool value) {
    _checkboxStates[key] = value;
    notifyListeners();
  }

  // Toggle checkbox state
  void toggleCheckbox(String key) {
    _checkboxStates[key] = !(_checkboxStates[key] ?? false);
    notifyListeners();
  }

  // Clear all checkboxes
  void clearAll() {
    _checkboxStates.clear();
    notifyListeners();
  }

  // Get all checkbox states
  Map<String, bool> getAllStates() {
    return Map.from(_checkboxStates);
  }

  // Check if specific checkboxes are all checked
  bool areAllChecked(List<String> keys) {
    return keys.every((key) => getCheckboxState(key));
  }

  // Get count of checked checkboxes
  int getCheckedCount() {
    return _checkboxStates.values.where((value) => value).length;
  }
}
