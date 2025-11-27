import 'package:fuoday/features/leave_tracker/domain/entities/leave_summary_entity.dart';


abstract class LeaveRepository {
  Future<List<LeaveSummaryEntity>> getLeaveSummary(String webUserId);
}
