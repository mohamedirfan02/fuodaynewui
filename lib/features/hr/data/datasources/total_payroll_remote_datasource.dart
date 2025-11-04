import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/hr/data/models/total_payroll_model.dart';

class TotalPayrollRemoteDataSource {
  final DioService dioService;

  TotalPayrollRemoteDataSource({required this.dioService});

  Future<TotalPayrollModel> getTotalPayroll() async {
    try {
      final response = await dioService.get(
        AppApiEndpointConstants.getTotalPayrollSummary(),
      );
      return TotalPayrollModel.fromJson(response.data);
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to fetch total payroll: $e");
      rethrow;
    }
  }
}
