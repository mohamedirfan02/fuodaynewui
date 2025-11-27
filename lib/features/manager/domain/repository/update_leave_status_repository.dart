// lib/features/team_leader/domain/repository/update_leave_status_repository.dart

import 'package:fuoday/features/manager/domain/entities/update_leave_status_entity.dart';

abstract class UpdateLeaveStatusRepository {
  Future<UpdateLeaveStatusEntity> updateLeaveStatus(int id, String status, String access);
}
