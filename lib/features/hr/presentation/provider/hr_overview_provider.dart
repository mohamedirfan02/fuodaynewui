import 'package:flutter/material.dart';
import 'package:fuoday/features/hr/domain/entities/hr_overview_entity.dart';
import 'package:fuoday/features/hr/domain/usecase/get_hr_overview.dart';


class HROverviewProvider extends ChangeNotifier {
  final GetHROverview getHROverviewUseCase;

  HROverviewProvider({required this.getHROverviewUseCase});

  HROverviewEntity? hrOverview;
  bool isLoading = false;
  String? error;

  Future<void> fetchHROverview(int webUserId) async {
    isLoading = true;
    notifyListeners();

    try {
      hrOverview = await getHROverviewUseCase(webUserId);
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
