import 'package:flutter/material.dart';
import 'package:fuoday/features/home/domain/entities/badge_entity.dart';
import 'package:fuoday/features/home/domain/usecases/get_badges_usecase.dart';


class BadgeProvider extends ChangeNotifier {
  final GetBadgesUseCase getBadgesUseCase;

  BadgeProvider({required this.getBadgesUseCase});

  List<BadgeEntity> _badges = [];
  List<BadgeEntity> get badges => _badges;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchBadges(int webUserId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _badges = await getBadgesUseCase(webUserId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearBadges() {
    _badges = [];
    notifyListeners();
  }
}
