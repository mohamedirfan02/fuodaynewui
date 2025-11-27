class PerformanceSummaryEntity {
  final List<Task>? tasks;
  final int? totalCompleted;
  final List<Task>? completedTasks;
  final int? totalPending;
  final List<Goal>? pendingGoals;
  final double? goalProgressPercentage;
  final List<Goal>? goalProgress;
  final int? performanceScore;
  final int? performanceRatingOutOf5;
  final int? totalCompletedProjects;
  final List<Project>? completedProjects;
  final int? totalUpcomingProjects;
  final List<Project>? upcomingProjects;
  final double? averageMonthlyAttendance;

  const PerformanceSummaryEntity({
    this.tasks,
    this.totalCompleted,
    this.completedTasks,
    this.totalPending,
    this.pendingGoals,
    this.goalProgressPercentage,
    this.goalProgress,
    this.performanceScore,
    this.performanceRatingOutOf5,
    this.totalCompletedProjects,
    this.completedProjects,
    this.totalUpcomingProjects,
    this.upcomingProjects,
    this.averageMonthlyAttendance,
  });
}

class Task {
  final String? description;
  final String? assignedBy;
  final String? project;
  final String? priority;
  final String? status;
  final String? progressNote;
  final DateTime? deadline;
  final DateTime? date;

  const Task({
    this.description,
    this.assignedBy,
    this.project,
    this.priority,
    this.status,
    this.progressNote,
    this.deadline,
    this.date,
  });
}

class Goal {
  final int? id;
  final int? webUserId;
  final String? empName;
  final String? empId;
  final DateTime? date;
  final String? description;
  final String? assignedBy;
  final int? assignedById;
  final String? assignedTo;
  final int? assignedToId;
  final String? project;
  final String? priority;
  final String? status;
  final String? progressNote;
  final DateTime? deadline;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProjectTeam? projectTeamBy;

  const Goal({
    this.id,
    this.webUserId,
    this.empName,
    this.empId,
    this.date,
    this.description,
    this.assignedBy,
    this.assignedById,
    this.assignedTo,
    this.assignedToId,
    this.project,
    this.priority,
    this.status,
    this.progressNote,
    this.deadline,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.projectTeamBy,
  });
}

class ProjectTeam {
  final int? id;
  final int? projectId;
  final String? projectName;
  final int? webUserId;
  final String? empName;
  final String? empId;
  final String? member;
  final String? role;
  final String? progress;
  final String? status;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProjectTeam({
    this.id,
    this.projectId,
    this.projectName,
    this.webUserId,
    this.empName,
    this.empId,
    this.member,
    this.role,
    this.progress,
    this.status,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });
}

class Project {
  final int? id;
  final int? adminUserId;
  final String? companyName;
  final String? name;
  final String? domain;
  final String? projectManagerId;
  final String? projectManagerName;
  final String? progress;
  final String? client;
  final String? comment;
  final DateTime? deadline;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Project({
    this.id,
    this.adminUserId,
    this.companyName,
    this.name,
    this.domain,
    this.projectManagerId,
    this.projectManagerName,
    this.progress,
    this.client,
    this.comment,
    this.deadline,
    this.createdAt,
    this.updatedAt,
  });
}
