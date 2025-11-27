
import 'package:fuoday/features/payslip/data/datasource/payroll_remote_data_source.dart';
import 'package:fuoday/features/payslip/domain/entities/payroll_entity.dart';
import 'package:fuoday/features/payslip/domain/repositories/payroll_repository.dart';

class PayrollRepositoryImpl implements PayrollRepository {
  final PayrollRemoteDataSource remoteDataSource;

  PayrollRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PayrollEntity> getPayroll(int webUserId) {
    return remoteDataSource.getPayroll(webUserId);
  }
}
