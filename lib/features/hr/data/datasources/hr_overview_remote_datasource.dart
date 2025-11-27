

import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/hr/data/models/hr_overview_model.dart';

abstract class HROverviewRemoteDataSource {
  Future<HROverviewModel> getHROverview(int webUserId);
}

class HROverviewRemoteDataSourceImpl implements HROverviewRemoteDataSource {
  final DioService dioService;

  HROverviewRemoteDataSourceImpl({required this.dioService});

  @override
  Future<HROverviewModel> getHROverview(int webUserId) async {
    final response = await dioService.get('/hrms/hr/gethr/$webUserId');
    return HROverviewModel.fromJson(response.data['data']);
  }
}
