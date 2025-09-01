import 'package:fuoday/features/calendar/data/datasources/shift_schedule_remote_datasource.dart';
import 'package:fuoday/features/calendar/domain/entities/shift_schedule_entity.dart';
import 'package:fuoday/features/calendar/domain/repository/shift_schedule_repository.dart';

class ShiftScheduleRepositoryImpl implements ShiftScheduleRepository {
  final ShiftScheduleRemoteDataSource shiftScheduleRemoteDataSource;

  ShiftScheduleRepositoryImpl({required this.shiftScheduleRemoteDataSource});

  @override
  Future<List<ShiftScheduleEntity>> getMonthlyShifts(
    String webUserId,
    String month,
  ) async {
    final models = await shiftScheduleRemoteDataSource.fetchMonthlyShifts(
      webUserId,
      month,
    );
    return models
        .map(
          (model) => ShiftScheduleEntity(
            id: model.id,
            webUserId: model.webUserId,
            empName: model.empName,
            empId: model.empId,
            date: model.date,
            shiftStart: model.shiftStart,
            shiftEnd: model.shiftEnd,
            startDate: model.startDate,
            endDate: model.endDate,
          ),
        )
        .toList();
  }
}
