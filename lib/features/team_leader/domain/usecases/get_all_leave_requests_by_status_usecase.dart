
import 'package:fuoday/features/team_leader/domain/entities/all_leave_requests_entity.dart';

import 'package:fuoday/features/team_leader/domain/repository/all_leave_requests_repository.dart';

class GetAllLeaveRequestsByStatusUseCase {
  final AllLeaveRequestsRepository repository;

  GetAllLeaveRequestsByStatusUseCase({required this.repository});

  Future<AllLeaveRequestsEntity> call(String status) async {
    return await repository.getAllLeaveRequestsByStatus(status);
  }
}
