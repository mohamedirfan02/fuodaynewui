class HomeAddTaskEntity {
  final int webUserId;
  final String date;
  final String description;
  final String assignedBy;
  final int assignedById;
  final String assignedTo;
  final String assignedToId;
  final String priority;
  final String deadline;
  final String project;

  HomeAddTaskEntity({
    required this.webUserId,
    required this.date,
    required this.description,
    required this.assignedBy,
    required this.assignedById,
    required this.assignedTo,
    required this.assignedToId,
    required this.priority,
    required this.deadline,
    required this.project,
  });
}
