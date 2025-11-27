import 'package:flutter/material.dart';

class RatingProvider extends ChangeNotifier {
  double _rating = 3.0;

  double get rating => _rating;

  void setRating(double value) {
    _rating = value;
    notifyListeners();
  }

  void reset() {
    _rating = 3.0;
    notifyListeners();
  }
}
