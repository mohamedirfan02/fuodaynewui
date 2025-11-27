class GetTicketDetails {
  final int id;
  final int webUserId;
  final String empName;
  final String ticket;
  final String category;
  final int? assignedToId;
  final String? assignedTo;
  final String assignedBy;
  final String priority;
  final String date;
  final String status;

  GetTicketDetails({
    required this.id,
    required this.webUserId,
    required this.empName,
    required this.ticket,
    required this.category,
    this.assignedToId,
    this.assignedTo,
    required this.assignedBy,
    required this.priority,
    required this.date,
    required this.status,
  });
}
