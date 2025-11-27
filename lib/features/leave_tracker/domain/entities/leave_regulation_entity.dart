class LeaveRegulationEntity {
  final int webUserId;
  final String fromDate;
  final String toDate;
  final String reason;
  final String comment;

  const LeaveRegulationEntity({
    required this.webUserId,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.comment,
  });
}
