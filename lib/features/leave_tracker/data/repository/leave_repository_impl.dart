import 'package:fuoday/features/leave_tracker/domain/repository/leave_repository.dart';
import '../../domain/entities/leave_summary_entity.dart';
import '../datasources/leave_remote_data_source.dart';
import '../mappers/leave_mapper.dart';

class LeaveRepositoryImpl implements LeaveRepository {
  final LeaveRemoteDataSource remoteDataSource;

  LeaveRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<LeaveSummaryEntity>> getLeaveSummary(String webUserId) async {
    final models = await remoteDataSource.fetchLeaveSummary(webUserId);
    return models.map((e) => e.toEntity()).toList();
  }
}
