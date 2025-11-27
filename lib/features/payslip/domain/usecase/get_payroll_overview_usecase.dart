
import 'package:fuoday/features/payslip/domain/entities/payroll_overview_entity.dart';
import 'package:fuoday/features/payslip/domain/repositories/payroll_overview_repository.dart';

class GetPayrollOverviewUseCase {
  final PayrollOverviewRepository repository;

  GetPayrollOverviewUseCase(this.repository);

  Future<PayrollOverviewEntity> call(int webUserId) {
    return repository.getPayrollOverview(webUserId);
  }
}
