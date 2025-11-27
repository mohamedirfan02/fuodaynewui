import 'package:flutter/material.dart';
import 'package:fuoday/features/time_tracker/domain/entities/time_tracker_entity.dart';
import 'package:fuoday/features/time_tracker/domain/usecase/get_time_and_project_tracker_UseCase.dart';

class TimeTrackerProvider extends ChangeNotifier {
  final GetTimeAndProjectTrackerUseCase usecase;
  TimeTrackerEntity? entity;
  bool loading = false;
  String? error;

  TimeTrackerProvider({required this.usecase});

  Future<void> load(String webUserId) async {
    loading = true; notifyListeners();
    try {
      entity = await usecase(webUserId);
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false; notifyListeners();
    }
  }
}
