import 'package:fuoday/features/home/domain/entities/home_addtask_entity.dart';

class HomeAddTaskModel {
  final String date;
  final String description;
  final String assignedBy;
  final String assignedById;
  final String assignedTo;
  final String assignedToId;
  final String priority;
  final String deadline;
  final String project;
  final int webUserId;

  HomeAddTaskModel({
    required this.date,
    required this.description,
    required this.assignedBy,
    required this.assignedById,
    required this.assignedTo,
    required this.assignedToId,
    required this.priority,
    required this.deadline,
    required this.project,
    required this.webUserId,
  });

  Map<String, dynamic> toJson() => {
    "date": date,
    "description": description,
    "assigned_by": assignedBy,
    "assigned_by_id": assignedById,
    "assigned_to": assignedTo,
    "assigned_to_id": assignedToId,
    "priority": priority,
    "deadline": deadline,
    "project": project,
    'web_user_id': webUserId,
  };

  factory HomeAddTaskModel.fromEntity(HomeAddTaskEntity entity) {
    return HomeAddTaskModel(
      date: entity.date,
      description: entity.description,
      assignedBy: entity.assignedBy,
      assignedById: entity.assignedById.toString(),
      assignedTo: entity.assignedTo,
      assignedToId: entity.assignedToId.toString(),
      priority: entity.priority,
      deadline: entity.deadline,
      project: entity.project,
      webUserId: entity.webUserId,
    );
  }
}