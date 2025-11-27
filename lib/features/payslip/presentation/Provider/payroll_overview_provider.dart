import 'package:flutter/material.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/payslip/domain/entities/payroll_overview_entity.dart';
import 'package:fuoday/features/payslip/domain/usecase/get_payroll_overview_usecase.dart';


class PayrollOverviewProvider extends ChangeNotifier {
  final GetPayrollOverviewUseCase getPayrollOverviewUseCase;

  PayrollOverviewEntity? payrollOverview;
  bool isLoading = false;
  String? errorMessage;

  PayrollOverviewProvider({required this.getPayrollOverviewUseCase});

  Future<void> fetchPayrollOverview() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final webUserId = getIt<HiveStorageService>()
          .employeeDetails?['web_user_id']
          ?.toString();

      if (webUserId == null) {
        errorMessage = 'User ID not found in Hive';
        AppLoggerHelper.logError(errorMessage!);  // Log here
        isLoading = false;
        notifyListeners();
        return;
      }

      final userIdInt = int.tryParse(webUserId);
      if (userIdInt == null) {
        errorMessage = 'Invalid User ID format';
        AppLoggerHelper.logError(errorMessage!);  // Log here
        isLoading = false;
        notifyListeners();
        return;
      }

      payrollOverview = await getPayrollOverviewUseCase(userIdInt);
      errorMessage = null;

    } catch (e, stackTrace) {
      errorMessage = e.toString();
      payrollOverview = null;
      AppLoggerHelper.logError(errorMessage!, stackTrace);  // Log here with stacktrace
    }

    isLoading = false;
    notifyListeners();
  }


  // Method to retry fetching data
  Future<void> retryFetch() async {
    await fetchPayrollOverview();
  }

  // Method to clear data (useful for logout scenarios)
  void clearData() {
    payrollOverview = null;
    errorMessage = null;
    isLoading = false;
    notifyListeners();
  }

  // Getter to check if data is available
  bool get hasData => payrollOverview != null;

  // Getter to check if there's an error
  bool get hasError => errorMessage != null;
}
