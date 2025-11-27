import 'package:flutter/foundation.dart';
import 'package:fuoday/features/leave_tracker/domain/entities/leave_regulation_entity.dart';
import 'package:fuoday/features/leave_tracker/domain/usecase/submit_leave_regulation_usecase.dart';

class LeaveRegulationProvider with ChangeNotifier {
  final SubmitLeaveRegulationUseCase submitLeaveRegulationUseCase;

  LeaveRegulationProvider(this.submitLeaveRegulationUseCase);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> submitRegulation(LeaveRegulationEntity entity) async {
    _isLoading = true;
    notifyListeners();

    try {
      await submitLeaveRegulationUseCase(entity);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
