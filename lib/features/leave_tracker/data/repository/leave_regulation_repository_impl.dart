

import 'package:fuoday/features/leave_tracker/data/datasources/leave_regulation_remote_data_source.dart';
import 'package:fuoday/features/leave_tracker/data/models/leave_regulation_model.dart';
import 'package:fuoday/features/leave_tracker/domain/entities/leave_regulation_entity.dart';
import 'package:fuoday/features/leave_tracker/domain/repository/leave_regulation_repository.dart';

class LeaveRegulationRepositoryImpl implements LeaveRegulationRepository {
  final LeaveRegulationRemoteDataSource remoteDataSource;

  LeaveRegulationRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> submitLeaveRegulation(LeaveRegulationEntity entity) {
    final model = LeaveRegulationModel(
      webUserId: entity.webUserId,
      fromDate: entity.fromDate,
      toDate: entity.toDate,
      reason: entity.reason,
      comment: entity.comment,
    );

    return remoteDataSource.submitLeaveRegulation(model);
  }
}
