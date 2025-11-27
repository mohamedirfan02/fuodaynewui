import 'package:fuoday/core/constants/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/organizations/data/models/service_industries_models.dart';

abstract class ServicesAndIndustriesDatasource {
  Future<ServicesAndIndustriesModel> fetchServicesAndIndustries(String webUserId);
}

class ServicesAndIndustriesRemoteDatasource implements ServicesAndIndustriesDatasource {
  final DioService dio;
  ServicesAndIndustriesRemoteDatasource(this.dio);

  @override
  Future<ServicesAndIndustriesModel> fetchServicesAndIndustries(String webUserId) async {

    final url = AppApiEndpointConstants.getServInd(webUserId);
    final response = await dio.get(url);

    if (response.statusCode == 200 && response.data['status'] == 'Success') {
      return ServicesAndIndustriesModel.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch services and industries');
    }
  }
}