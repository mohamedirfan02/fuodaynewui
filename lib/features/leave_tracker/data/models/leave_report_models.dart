class LeaveReportModel {
  final String date;
  final String type;
  final String from;
  final String to;
  final String days;
  final String reason;
  final String status;
  final String regulationDate;
  final String permissionTiming;
  final String regulationStatus;

  LeaveReportModel({
    required this.date,
    required this.type,
    required this.from,
    required this.to,
    required this.days,
    required this.reason,
    required this.status,
    required this.regulationDate,
    required this.permissionTiming,
    required this.regulationStatus,
  });

  factory LeaveReportModel.fromJson(Map<String, dynamic> json) {
    return LeaveReportModel(
      date: json['date']?.toString() ?? '-',
      type: json['type']?.toString() ?? '-',
      from: json['from']?.toString() ?? '-',
      to: json['to']?.toString() ?? '-',
      days: json['days']?.toString() ?? '-',
      reason: json['reason']?.toString() ?? '-',
      status: json['status']?.toString() ?? '-',
      regulationDate: json['regulation_date']?.toString() ?? '-',
      permissionTiming: json['permission_timing']?.toString() ?? '-',
      regulationStatus: json['regulation_status']?.toString() ?? '-',
    );
  }
}
