import 'package:fuoday/core/constants/api/app_api_endpoint_constants.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/calendar/data/models/shift_schedule_model.dart';

class ShiftScheduleRemoteDataSource {
  final DioService dioService;

  ShiftScheduleRemoteDataSource({required this.dioService});

  Future<List<ShiftScheduleModel>> fetchMonthlyShifts(
    String webUserId,
    String month,
  ) async {
    final response = await dioService.post(
      AppApiEndpointConstants.getSchedules(webUserId),
      data: {'month': month},
    );

    final dataList = response.data['data'] as List<dynamic>;

    // Flatten employees into shift models
    List<ShiftScheduleModel> shifts = [];

    for (var schedule in dataList) {
      final shiftStart = schedule['shift_start'] as String;
      final shiftEnd = schedule['shift_end'] as String;
      final date = schedule['date'] as String;

      final employees = schedule['employees'] as List<dynamic>? ?? [];


      // ✅ Normal shifts
      for (var emp in employees) {
        shifts.add(
          ShiftScheduleModel(
            id: emp['id'],
            webUserId: emp['id'],
            empName: emp['name'],
            empId: emp['emp_id'].toString(),
            date: date,
            shiftStart: shiftStart,
            shiftEnd: shiftEnd,
            startDate: schedule['start_date'] ?? '',
            endDate: schedule['end_date'] ?? '',
          ),
        );
      }
      // ✅ Saturday shifts
      final saturdayDates = schedule['saturday_dates'] as List<dynamic>? ?? [];
      if (saturdayDates.isNotEmpty) {
        for (var satDate in saturdayDates) {
          for (var emp in employees) {
            shifts.add(
              ShiftScheduleModel(
                id: emp['id'],
                webUserId: emp['id'],
                empName: emp['name'],
                empId: emp['emp_id'].toString(),
                date: satDate.toString(),
                shiftStart: shiftStart,
                shiftEnd: shiftEnd,
                startDate: satDate.toString(),
                endDate: satDate.toString(),
              ),
            );
          }
        }
      }
    }


    return shifts;
  }
}
