

import 'package:fuoday/features/leave_tracker/domain/entities/leave_regulation_entity.dart';
import 'package:fuoday/features/leave_tracker/domain/repository/leave_regulation_repository.dart';

class SubmitLeaveRegulationUseCase {
  final LeaveRegulationRepository repository;

  SubmitLeaveRegulationUseCase(this.repository);

  Future<void> call(LeaveRegulationEntity entity) {
    return repository.submitLeaveRegulation(entity);
  }
}
