


import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/payslip/data/models/payroll_overview_model.dart';
import 'package:fuoday/features/payslip/domain/entities/payroll_overview_entity.dart';
import 'package:fuoday/features/payslip/domain/repositories/payroll_overview_repository.dart';

class PayrollOverviewRepositoryImpl implements PayrollOverviewRepository {
  final DioService dioService;

  PayrollOverviewRepositoryImpl(this.dioService);

  @override
  Future<PayrollOverviewEntity> getPayrollOverview(int webUserId) async {
    final endpoint = "/hrms/payroll/getoverview/$webUserId";

    try {
      final response = await dioService.get(endpoint);

      if (response.statusCode == 200) {
        final jsonData = response.data;

        if (jsonData['status'] == 'Success') {
          return PayrollOverviewModel.fromJson(jsonData);
        } else {
          throw Exception(jsonData['message'] ?? 'Unknown error');
        }
      } else {
        throw Exception("Failed to fetch Payroll Overview");
      }
    } catch (e) {
      throw Exception("Error fetching Payroll Overview: $e");
    }
  }
}
