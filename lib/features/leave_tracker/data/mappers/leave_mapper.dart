import '../../domain/entities/leave_summary_entity.dart';
import '../models/leave_summary_model.dart';

extension LeaveMapper on LeaveSummaryModel {
  LeaveSummaryEntity toEntity() {
    return LeaveSummaryEntity(
      type: type,
      allowed: allowed,
      taken: taken,
      pending: pending,
      remaining: remaining,
      remainingPercentage: remainingPercentage,
    );
  }
}
