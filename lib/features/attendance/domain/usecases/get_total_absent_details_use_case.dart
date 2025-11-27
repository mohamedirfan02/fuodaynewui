import 'package:fuoday/features/attendance/domain/entities/total_absent_details_entity.dart';
import 'package:fuoday/features/attendance/domain/repository/total_absent_details_repository.dart';

class GetTotalAbsentDetailsUseCase {
  final TotalAbsentDetailsRepository totalAbsentDetailsRepository;

  GetTotalAbsentDetailsUseCase({required this.totalAbsentDetailsRepository});

  Future<TotalAbsentDetailsEntity> call(int webUserId) {
    return totalAbsentDetailsRepository.getTotalAbsentDetails(webUserId);
  }
}
