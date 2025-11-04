import 'package:fuoday/features/hr/domain/entities/total_payroll_entity.dart';
import 'package:fuoday/features/hr/domain/repository/total_payroll_repository.dart';

class GetTotalPayrollUseCase {
  final TotalPayrollRepository repository;

  GetTotalPayrollUseCase({required this.repository});

  Future<TotalPayrollEntity> call() {
    return repository.getTotalPayroll();
  }
}
