import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/profile/data/models/Employee_Onboard_Model.dart';

class EmployeeOnboardRemoteDataSource {
  final DioService dio;

  EmployeeOnboardRemoteDataSource(this.dio);

  Future<void> onboardEmployee(EmployeeOnboardModel model) async {
    final response = await dio.client.post(
      AppApiEndpointConstants.updateOnboarding,
      data: model.toFormData(),
    );
    if (response.statusCode! >= 400) {
      throw Exception('Failed onboard: ${response.data}');
    }
  }
}
