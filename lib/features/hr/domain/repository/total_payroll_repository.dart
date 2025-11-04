import 'package:fuoday/features/hr/domain/entities/total_payroll_entity.dart';

abstract class TotalPayrollRepository {
  Future<TotalPayrollEntity> getTotalPayroll();
}
