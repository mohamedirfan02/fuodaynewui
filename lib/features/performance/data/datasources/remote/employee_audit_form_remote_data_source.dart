import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/performance/data/models/employee_audit_form_model.dart';

class EmployeeAuditFormRemoteDataSource {
  final DioService dioService;

  EmployeeAuditFormRemoteDataSource({required this.dioService});

  Future<void> postEmployeeAuditForm(
    EmployeeAuditFormModel employeeAuditFormModel,
  ) async {
    try {
      final response = await dioService.post(
        AppApiEndpointConstants.postAuditForm,
        data: employeeAuditFormModel.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Successfully posted
        AppLoggerHelper.logInfo('✅ Audit form posted successfully');
      } else {
        throw Exception(
          '❌ Failed to post audit form. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      AppLoggerHelper.logError("Error posting form: $e");

      rethrow;
    }
  }
}
