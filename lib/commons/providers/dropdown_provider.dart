import 'package:flutter/material.dart';

class DropdownProvider with ChangeNotifier {
  // Store all dropdown values in a map
  final Map<String, String?> _dropdownValues = {};

  // Getter to get value for a specific dropdown
  String? getValue(String key) => _dropdownValues[key];

  // Setter to update value for a specific dropdown
  void setValue(String key, String? value) {
    _dropdownValues[key] = value;
    notifyListeners();
  }

  // Method to clear a specific dropdown
  void clearValue(String key) {
    _dropdownValues.remove(key);
    notifyListeners();
  }

  // Method to clear all dropdowns
  void clearAll() {
    _dropdownValues.clear();
    notifyListeners();
  }

  // Method to get all values
  Map<String, String?> getAllValues() => Map.from(_dropdownValues);

  // Method to set multiple values at once
  void setMultipleValues(Map<String, String?> values) {
    _dropdownValues.addAll(values);
    notifyListeners();
  }
}
