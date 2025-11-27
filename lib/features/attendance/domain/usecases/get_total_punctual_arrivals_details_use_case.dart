// File: features/attendance/domain/usecases/get_total_punctual_arrivals_details_use_case.dart

import 'package:fuoday/features/attendance/domain/entities/total_punctual_arrivals_details_entity.dart';
import 'package:fuoday/features/attendance/domain/repository/total_punctual_details_repository.dart';

class GetTotalPunctualArrivalsDetailsUseCase {
  final AttendanceRepository repository;

  GetTotalPunctualArrivalsDetailsUseCase({required this.repository});

  Future<TotalPunctualArrivalsDetailsEntity> call(int webUserId) async {
    try {
      print('🔍 UseCase: Executing for webUserId: $webUserId');

      final result = await repository.getTotalPunctualArrivalDetails(webUserId);

      print('✅ UseCase: Successfully got data from repository');
      print('✅ UseCase: Result type: ${result.runtimeType}');
      print('✅ UseCase: Message: ${result.message}');
      print('✅ UseCase: Status: ${result.status}');
      print('✅ UseCase: Has data: ${result.data != null}');

      if (result.data != null) {
        print('✅ UseCase: Employee: ${result.data!.employeeName}');
        print('✅ UseCase: Total punctual: ${result.data!.totalPunctualArrivals}');
        print('✅ UseCase: Percentage: ${result.data!.punctualArrivalPercentage}');
        print('✅ UseCase: Records: ${result.data!.punctualArrivalsDetails?.length}');
      }

      return result;
    } catch (e, stackTrace) {
      print('❌ UseCase Error: $e');
      print('❌ UseCase Stack: $stackTrace');
      rethrow;
    }
  }
}