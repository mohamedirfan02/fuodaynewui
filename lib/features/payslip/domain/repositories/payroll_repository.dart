
import 'package:fuoday/features/payslip/domain/entities/payroll_entity.dart';

abstract class PayrollRepository {
  Future<PayrollEntity> getPayroll(int webUserId);
}
