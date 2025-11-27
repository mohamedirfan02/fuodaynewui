import 'package:fuoday/features/attendance/domain/entities/total_late_arrivals_details_entity.dart';
import 'package:fuoday/features/attendance/domain/repository/total_late_arrivals_details_repository.dart';

class GetTotalLateArrivalsDetailsUseCase {
  final TotalLateArrivalsDetailsRepository totalLateArrivalsDetailsRepository;

  GetTotalLateArrivalsDetailsUseCase({
    required this.totalLateArrivalsDetailsRepository,
  });

  Future<TotalLateArrivalsDetailsEntity> call(int webUserId) {
    return totalLateArrivalsDetailsRepository.getTotalLateArrivalsDetails(
      webUserId,
    );
  }
}
