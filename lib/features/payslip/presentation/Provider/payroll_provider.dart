import 'package:flutter/foundation.dart';
import 'package:fuoday/features/payslip/domain/entities/payroll_entity.dart';
import 'package:fuoday/features/payslip/domain/usecase/get_payroll_usecase.dart';
import 'package:hive/hive.dart';

class PayrollProvider extends ChangeNotifier {
  final GetPayrollUseCase getPayrollUseCase;

  PayrollProvider({required this.getPayrollUseCase});

  PayrollEntity? payroll;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchPayroll() async {
    isLoading = true;
    notifyListeners();

    try {
      final box = Hive.box('employeeBox');
      final employeeDetails = box.get('employeeDetails');
      final webUserId = employeeDetails?['web_user_id'] ?? 0;

      if (webUserId == 0) {
        throw Exception('User ID not found in Hive');
      }

      payroll = await getPayrollUseCase(webUserId);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
