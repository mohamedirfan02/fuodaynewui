import 'package:fuoday/core/constants/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/organizations/data/models/department_member_model.dart';

abstract class DepartmentListRemoteDataSource {
  Future<Map<String, List<DepartmentMemberModel>>> fetchDepartmentList(String webUserId);
}

class DepartmentListRemoteDataSourceImpl implements DepartmentListRemoteDataSource {
  final DioService dio;

  DepartmentListRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, List<DepartmentMemberModel>>> fetchDepartmentList(String webUserId) async {
    final response = await dio.get(AppApiEndpointConstants.getDeptTeamList(webUserId));
    print("Response Data: ${response.data}");

    final Map<String, dynamic> dataMap = response.data['data'];
    return dataMap.map((key, value) => MapEntry(
      key,
      List<DepartmentMemberModel>.from(
        (value as List).map((e) => DepartmentMemberModel.fromJson(e)),
      ),
    ));
  }
}
