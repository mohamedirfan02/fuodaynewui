

import 'package:fuoday/features/payslip/domain/entities/payroll_entity.dart';
import 'package:fuoday/features/payslip/domain/repositories/payroll_repository.dart';

class GetPayrollUseCase {
  final PayrollRepository repository;
  GetPayrollUseCase(this.repository);

  Future<PayrollEntity> call(int webUserId) {
    return repository.getPayroll(webUserId);
  }
}
