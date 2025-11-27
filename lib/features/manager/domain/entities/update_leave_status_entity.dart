class UpdateLeaveStatusEntity {
  final String? message;
  final String? status;
  final String? access;
  final UpdatedLeaveEntity? data;

  UpdateLeaveStatusEntity({this.message, this.status, this.access,this.data});
}

class UpdatedLeaveEntity {
  final int? id;
  final String? empName;
  final String? type;
  final String? from;
  final String? to;
  final String? reason;
  final String? status;

  UpdatedLeaveEntity({
    this.id,
    this.empName,
    this.type,
    this.from,
    this.to,
    this.reason,
    this.status,
  });
}
