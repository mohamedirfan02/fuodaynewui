
import 'package:fuoday/features/payslip/domain/entities/payroll_overview_entity.dart';

abstract class PayrollOverviewRepository {
  Future<PayrollOverviewEntity> getPayrollOverview(int webUserId);
}
