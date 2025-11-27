import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/payslip/data/models/payroll_model.dart';

abstract class PayrollRemoteDataSource {
  Future<PayrollModel> getPayroll(int webUserId);
}

class PayrollRemoteDataSourceImpl implements PayrollRemoteDataSource {
  final DioService dio;
  final String baseUrl;

  PayrollRemoteDataSourceImpl({required this.dio, required this.baseUrl});

  @override
  Future<PayrollModel> getPayroll(int webUserId) async {
    final response = await dio.get(AppApiEndpointConstants.getPayroll(webUserId));

    if (response.statusCode == 200 && response.data['status'] == "Success") {
      return PayrollModel.fromJson(response.data['data']);
    } else {
      throw Exception(response.data['message'] ?? 'Failed to fetch payroll');
    }
  }
}
