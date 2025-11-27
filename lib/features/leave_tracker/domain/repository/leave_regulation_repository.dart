
import 'package:fuoday/features/leave_tracker/domain/entities/leave_regulation_entity.dart';

abstract class LeaveRegulationRepository {
  Future<void> submitLeaveRegulation(LeaveRegulationEntity entity);
}
