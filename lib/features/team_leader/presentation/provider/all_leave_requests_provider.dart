import 'package:flutter/material.dart';
import 'package:fuoday/features/team_leader/domain/entities/all_leave_requests_entity.dart';
import 'package:fuoday/features/team_leader/domain/usecases/get_all_leave_requests_by_status_usecase.dart';


class AllLeaveRequestsProvider extends ChangeNotifier {
  final GetAllLeaveRequestsByStatusUseCase getAllLeaveRequestsByStatusUseCase;

  AllLeaveRequestsProvider({required this.getAllLeaveRequestsByStatusUseCase});

  bool isLoading = false;
  String? errorMessage;
  AllLeaveRequestsEntity? leaveRequests;

  Future<void> fetchAllLeaveRequests(String status) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      leaveRequests = await getAllLeaveRequestsByStatusUseCase(status);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearSelected() {
    leaveRequests = null;
    notifyListeners();
  }
  void clearData() {
    leaveRequests = null;
    notifyListeners();
  }
}
