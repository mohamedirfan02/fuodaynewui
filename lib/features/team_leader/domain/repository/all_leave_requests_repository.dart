
import 'package:fuoday/features/team_leader/domain/entities/all_leave_requests_entity.dart';

abstract class AllLeaveRequestsRepository {
  Future<AllLeaveRequestsEntity> getAllLeaveRequestsByStatus(String status);
}
