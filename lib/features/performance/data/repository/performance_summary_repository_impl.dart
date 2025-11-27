import 'package:fuoday/features/performance/data/datasources/remote/performance_summary_remote_data_source.dart';
import 'package:fuoday/features/performance/domain/entities/performance_summary_entity.dart';
import 'package:fuoday/features/performance/domain/repository/performance_summary_repository.dart';

class PerformanceSummaryRepositoryImpl implements PerformanceSummaryRepository {
  final PerformanceRemoteDataSource performanceRemoteDataSource;

  PerformanceSummaryRepositoryImpl({required this.performanceRemoteDataSource});

  @override
  Future<PerformanceSummaryEntity> getPerformanceSummary(int webUserId) async {
    return await performanceRemoteDataSource.getPerformanceSummary(webUserId);
  }
}
