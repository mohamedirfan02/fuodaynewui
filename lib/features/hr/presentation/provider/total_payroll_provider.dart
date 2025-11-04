import 'package:flutter/material.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/features/hr/domain/entities/total_payroll_entity.dart';
import 'package:fuoday/features/hr/domain/usecase/get_total_payroll_usecase.dart';

class TotalPayrollProvider extends ChangeNotifier {
  final GetTotalPayrollUseCase getTotalPayrollUseCase;

  TotalPayrollProvider({required this.getTotalPayrollUseCase});

  bool isLoading = false;
  TotalPayrollEntity? totalPayroll;
  String? errorMessage;

  Future<void> fetchTotalPayroll() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      totalPayroll = await getTotalPayrollUseCase.call();
      AppLoggerHelper.logInfo("✅ Total payroll data fetched successfully");
    } catch (e) {
      errorMessage = e.toString();
      AppLoggerHelper.logError("❌ Failed to fetch total payroll data: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Helper method to get salary components for a specific employee
  SalaryComponentsEntity? getSalaryComponents(String empId) {
    if (totalPayroll?.data == null) return null;

    try {
      final employee = totalPayroll!.data!.firstWhere(
        (emp) => emp.empId == empId,
      );
      return employee.salaryComponents;
    } catch (e) {
      return null;
    }
  }
}
