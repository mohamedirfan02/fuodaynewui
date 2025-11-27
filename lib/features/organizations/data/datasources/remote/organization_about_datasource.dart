import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/organizations/data/models/organization_about_model.dart';

class OrganizationAboutRemoteDatasource implements OrganizationAboutDatasource {
  final DioService dio;

  OrganizationAboutRemoteDatasource(this.dio);

  @override
  Future<OrganizationAboutModel> getAbout(String webUserId) async {
    final response = await dio.get(AppApiEndpointConstants.getAbout(webUserId));
    if (response.statusCode == 200 && response.data['status'] == 'Success') {
      return OrganizationAboutModel.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to fetch organization about info');
    }
  }
}

abstract class OrganizationAboutDatasource {
  Future<OrganizationAboutModel> getAbout(String webUserId);
}

