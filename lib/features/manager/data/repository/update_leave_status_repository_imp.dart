// lib/features/team_leader/data/repository/update_leave_status_repository_impl.dart

import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/manager/data/datasources/update_leave_status_remote_data_source.dart';
import 'package:fuoday/features/manager/data/model/update_leave_status_model.dart';
import 'package:fuoday/features/manager/domain/entities/update_leave_status_entity.dart';
import 'package:fuoday/features/manager/domain/repository/update_leave_status_repository.dart';

class UpdateLeaveStatusRepositoryImpl implements UpdateLeaveStatusRepository {
  final UpdateLeaveStatusRemoteDataSource remoteDataSource;

  UpdateLeaveStatusRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UpdateLeaveStatusEntity> updateLeaveStatus(int id, String status, String access) async {
    try {
      final model = await remoteDataSource.updateLeaveStatus(id, status, access);
      return model.toEntity();
    } catch (e) {
      AppLoggerHelper.logError("❌ Repository failed: $e");
      rethrow;
    }
  }
}
