import 'package:fuoday/features/attendance/domain/entities/total_attendance_details_entity.dart';
import 'package:fuoday/features/attendance/domain/repository/total_attendance_details_repository.dart';

class GetTotalAttendanceDetailsUseCase {
  final TotalAttendanceDetailsRepository totalAttendanceDetailsRepository;

  GetTotalAttendanceDetailsUseCase({
    required this.totalAttendanceDetailsRepository,
  });

  /// Executes the use case to fetch total attendance details for the given user.
  Future<TotalAttendanceDetailsEntity> call(int webUserId) {
    return totalAttendanceDetailsRepository.getTotalAttendanceDetails(
      webUserId,
    );
  }
}
