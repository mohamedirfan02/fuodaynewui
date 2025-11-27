import 'package:fuoday/features/calendar/domain/entities/shift_schedule_entity.dart';
import 'package:fuoday/features/calendar/domain/repository/shift_schedule_repository.dart';

class GetMonthlyShiftUseCase {
  final ShiftScheduleRepository shiftScheduleRepository;

  GetMonthlyShiftUseCase({required this.shiftScheduleRepository});




  Future<List<ShiftScheduleEntity>> call(String webUserId, String month) {
    return shiftScheduleRepository.getMonthlyShifts(webUserId, month);
  }
}
