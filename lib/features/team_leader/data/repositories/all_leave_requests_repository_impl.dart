import 'package:fuoday/features/team_leader/data/datasource/all_leave_requests_remote_data_source.dart';
import 'package:fuoday/features/team_leader/data/models/all_leave_requests_model.dart';
import 'package:fuoday/features/team_leader/domain/entities/all_leave_requests_entity.dart';
import 'package:fuoday/features/team_leader/domain/repository/all_leave_requests_repository.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';

class AllLeaveRequestsRepositoryImpl implements AllLeaveRequestsRepository {
  final AllLeaveRequestsRemoteDataSource remoteDataSource;

  AllLeaveRequestsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AllLeaveRequestsEntity> getAllLeaveRequestsByStatus(String status) async {
    try {
      final AllLeaveRequestsModel model =
      await remoteDataSource.getAllLeavesByStatus(status);
      // ✅ Model already extends AllLeaveRequestsEntity, so return directly
      return model;
    } catch (e) {
      AppLoggerHelper.logError("❌ Repository failed: $e");
      rethrow;
    }
  }
}
