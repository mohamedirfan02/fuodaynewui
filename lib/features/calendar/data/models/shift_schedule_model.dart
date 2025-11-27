class ShiftScheduleModel {
  final int id;
  final int webUserId;
  final String empName;
  final String empId;
  final String date;
  final String shiftStart;
  final String shiftEnd;
  final String? startDate;
  final String? endDate;

  ShiftScheduleModel({
    required this.id,
    required this.webUserId,
    required this.empName,
    required this.empId,
    required this.date,
    required this.shiftStart,
    required this.shiftEnd,
     this.startDate,
     this.endDate,
  });

  factory ShiftScheduleModel.fromJson(Map<String, dynamic> json) {
    return ShiftScheduleModel(
      id: json['id'],
      webUserId: json['web_user_id'],
      empName: json['emp_name'],
      empId: json['emp_id'],
      date: json['date'],
      shiftStart: json['shift_start'],
      shiftEnd: json['shift_end'],
      startDate: json['start_date'] ?? json['date'] ?? '',
      endDate: json['end_date'] ?? json['date'] ?? '',
    );
  }
}