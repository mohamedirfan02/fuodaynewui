import 'package:fuoday/features/attendance/domain/entities/total_early_arrivals_details_entity.dart';
import 'package:fuoday/features/attendance/domain/repository/total_early_arrivals_details_repository.dart';

class GetTotalEarlyArrivalsUseCase {
  final TotalEarlyArrivalsDetailsRepository totalEarlyArrivalsDetailsRepository;

  GetTotalEarlyArrivalsUseCase({
    required this.totalEarlyArrivalsDetailsRepository,
  });

  Future<EarlyArrivalsEntity> call(int webUserId) {
    return totalEarlyArrivalsDetailsRepository.getTotalEarlyArrivalsDetails(
      webUserId,
    );
  }
}
