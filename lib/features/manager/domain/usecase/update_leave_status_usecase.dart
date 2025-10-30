

import 'package:fuoday/features/manager/domain/entities/update_leave_status_entity.dart';
import 'package:fuoday/features/manager/domain/repository/update_leave_status_repository.dart';

class UpdateLeaveStatusUseCase {
  final UpdateLeaveStatusRepository repository;

  UpdateLeaveStatusUseCase({required this.repository});

  Future<UpdateLeaveStatusEntity> call(int id, String status,String access) {
    return repository.updateLeaveStatus(id, status, access);
  }
}
