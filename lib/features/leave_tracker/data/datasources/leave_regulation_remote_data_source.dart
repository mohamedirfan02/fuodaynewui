

import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/leave_tracker/data/models/leave_regulation_model.dart';

abstract class LeaveRegulationRemoteDataSource {
  Future<void> submitLeaveRegulation(LeaveRegulationModel model);
}

class LeaveRegulationRemoteDataSourceImpl
    implements LeaveRegulationRemoteDataSource {
  final DioService dioService;

  LeaveRegulationRemoteDataSourceImpl(this.dioService);

  @override
  Future<void> submitLeaveRegulation(LeaveRegulationModel model) async {
    await dioService.post("/hrms/leave/regulate", data: model.toJson());
  }
}
