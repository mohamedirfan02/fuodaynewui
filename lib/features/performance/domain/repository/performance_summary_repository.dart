import 'package:fuoday/features/performance/domain/entities/performance_summary_entity.dart';

abstract class PerformanceSummaryRepository {
  // Get Performance Summary
  Future<PerformanceSummaryEntity> getPerformanceSummary(int webUserId);
}
