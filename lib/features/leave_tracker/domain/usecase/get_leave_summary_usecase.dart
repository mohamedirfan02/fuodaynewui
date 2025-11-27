import 'package:fuoday/features/leave_tracker/domain/repository/leave_repository.dart';

import '../entities/leave_summary_entity.dart';

class GetLeaveSummaryUseCase {
  final LeaveRepository repository;

  GetLeaveSummaryUseCase(this.repository);

  Future<List<LeaveSummaryEntity>> call(String webUserId) {
    return repository.getLeaveSummary(webUserId);
  }
}
