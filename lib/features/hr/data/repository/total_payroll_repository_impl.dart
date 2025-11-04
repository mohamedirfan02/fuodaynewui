import 'package:fuoday/features/hr/data/datasources/total_payroll_remote_datasource.dart';
import 'package:fuoday/features/hr/domain/entities/total_payroll_entity.dart';
import 'package:fuoday/features/hr/domain/repository/total_payroll_repository.dart';

class TotalPayrollRepositoryImpl implements TotalPayrollRepository {
  final TotalPayrollRemoteDataSource remoteDataSource;

  TotalPayrollRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TotalPayrollEntity> getTotalPayroll() async {
    final model = await remoteDataSource.getTotalPayroll();
    return model.toEntity();
  }
}
