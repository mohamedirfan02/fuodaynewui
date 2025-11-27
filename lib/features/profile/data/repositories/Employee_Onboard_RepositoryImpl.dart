import 'package:dio/dio.dart';
import 'package:fuoday/features/profile/data/datasources/Employee_OnboardRemote_DataSource.dart';
import 'package:fuoday/features/profile/data/models/Employee_Onboard_Model.dart';
import 'package:fuoday/features/profile/domain/entities/Employee_onboard_entity.dart';
import 'package:fuoday/features/profile/domain/repository/Employee_Onboard_Repository.dart';

class EmployeeOnboardRepositoryImpl implements EmployeeOnboardRepository {
  final EmployeeOnboardRemoteDataSource dataSource;

  EmployeeOnboardRepositoryImpl(this.dataSource);

  @override
  Future<void> onboardEmployee(EmployeeOnboardEntity entity) async {
    final model = EmployeeOnboardModel(
      webUserId: entity.webUserId,
      welcomeEmailSent: entity.welcomeEmailSent?.toIso8601String(),
      scheduledDate: entity.scheduledDate?.toIso8601String(),
      photo: entity.photo != null
          ? MultipartFile.fromFileSync(entity.photo!.path, filename: 'photo')
          : null,
      pan: entity.pan != null
          ? MultipartFile.fromFileSync(entity.pan!.path, filename: 'pan')
          : null,
      passbook: entity.passbook != null
          ? MultipartFile.fromFileSync(entity.passbook!.path, filename: 'passbook')
          : null,
      payslip: entity.payslip != null
          ? MultipartFile.fromFileSync(entity.payslip!.path, filename: 'payslip')
          : null,
      offerLetter: entity.offerLetter != null
          ? MultipartFile.fromFileSync(entity.offerLetter!.path, filename: 'offerLetter')
          : null,
    );
    await dataSource.onboardEmployee(model);
  }
}
