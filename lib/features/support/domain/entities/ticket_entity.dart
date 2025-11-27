class Ticket {
  final int webUserId;
  final String ticket;
  final String category;
  final int assignedToId;
  final String assignedTo;
  final String priority;
  final String date;

  Ticket({
    required this.webUserId,
    required this.ticket,
    required this.category,
    required this.assignedToId,
    required this.assignedTo,
    required this.priority,
    required this.date,
  });
}
