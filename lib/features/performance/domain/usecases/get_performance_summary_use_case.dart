import 'package:fuoday/features/performance/domain/entities/performance_summary_entity.dart';
import 'package:fuoday/features/performance/domain/repository/performance_summary_repository.dart';

class GetPerformanceSummaryUseCase {
  final PerformanceSummaryRepository performanceSummaryRepository;

  GetPerformanceSummaryUseCase({required this.performanceSummaryRepository});

  Future<PerformanceSummaryEntity> call(int webUserId) async {
    return await performanceSummaryRepository.getPerformanceSummary(webUserId);
  }
}
