/*
import 'package:fuoday/features/performance/domain/entities/performance_summary_entity.dart';

class PerformanceSummaryModel extends PerformanceSummaryEntity {
  const PerformanceSummaryModel({
    super.tasks,
    super.totalCompleted,
    super.completedTasks,
    super.totalPending,
    super.pendingGoals,
    super.goalProgressPercentage,
    super.goalProgress,
    super.performanceScore,
    super.performanceRatingOutOf5,
    super.totalCompletedProjects,
    super.completedProjects,
    super.totalUpcomingProjects,
    super.upcomingProjects,
    super.averageMonthlyAttendance,
  });

  factory PerformanceSummaryModel.fromJson(Map<String, dynamic> json) {
    return PerformanceSummaryModel(
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => TaskModel.fromJson(e))
          .toList(),
      totalCompleted: json['total_completed'],
      completedTasks: (json['completed_tasks'] as List<dynamic>?)
          ?.map((e) => TaskModel.fromJson(e))
          .toList(),
      totalPending: json['total_pending'],
      pendingGoals: (json['pending_goals'] as List<dynamic>?)
          ?.map((e) => GoalModel.fromJson(e))
          .toList(),
      goalProgressPercentage: (json['goal_progress_percentage'] as num?)
          ?.toDouble(),
      goalProgress: (json['goal_progress'] as List<dynamic>?)
          ?.map((e) => GoalModel.fromJson(e))
          .toList(),
      performanceScore: json['performance_score'],
      performanceRatingOutOf5: json['performance_rating_out_of_5'],
      totalCompletedProjects: json['total_completed_projects'],
      completedProjects: (json['completed_projects'] as List<dynamic>?)
          ?.map((e) => ProjectModel.fromJson(e))
          .toList(),
      totalUpcomingProjects: json['total_upcoming_projects'],
      upcomingProjects: (json['upcoming_projects'] as List<dynamic>?)
          ?.map((e) => ProjectModel.fromJson(e))
          .toList(),
      averageMonthlyAttendance: (json['average_monthly_attendance'] as num?)
          ?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'tasks': tasks?.map((e) => (e as TaskModel).toJson()).toList(),
    'total_completed': totalCompleted,
    'completed_tasks': completedTasks
        ?.map((e) => (e as TaskModel).toJson())
        .toList(),
    'total_pending': totalPending,
    'pending_goals': pendingGoals
        ?.map((e) => (e as GoalModel).toJson())
        .toList(),
    'goal_progress_percentage': goalProgressPercentage,
    'goal_progress': goalProgress
        ?.map((e) => (e as GoalModel).toJson())
        .toList(),
    'performance_score': performanceScore,
    'performance_rating_out_of_5': performanceRatingOutOf5,
    'total_completed_projects': totalCompletedProjects,
    'completed_projects': completedProjects
        ?.map((e) => (e as ProjectModel).toJson())
        .toList(),
    'total_upcoming_projects': totalUpcomingProjects,
    'upcoming_projects': upcomingProjects
        ?.map((e) => (e as ProjectModel).toJson())
        .toList(),
    'average_monthly_attendance': averageMonthlyAttendance,
  };
}

class TaskModel extends Task {
  const TaskModel({
    super.description,
    super.assignedBy,
    super.project,
    super.priority,
    super.status,
    super.progressNote,
    super.deadline,
    super.date,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      description: json['description'],
      assignedBy: json['assigned_by'],
      project: json['project'],
      priority: json['priority'],
      status: json['status'],
      progressNote: json['progress_note'],
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'])
          : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'description': description,
    'assigned_by': assignedBy,
    'project': project,
    'priority': priority,
    'status': status,
    'progress_note': progressNote,
    'deadline': deadline?.toIso8601String(),
    'date': date?.toIso8601String(),
  };
}

class GoalModel extends Goal {
  const GoalModel({
    super.id,
    super.webUserId,
    super.empName,
    super.empId,
    super.date,
    super.description,
    super.assignedBy,
    super.assignedById,
    super.assignedTo,
    super.assignedToId,
    super.project,
    super.priority,
    super.status,
    super.progressNote,
    super.deadline,
    super.comment,
    super.createdAt,
    super.updatedAt,
    super.projectTeamBy,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'],
      webUserId: json['web_user_id'],
      empName: json['emp_name'],
      empId: json['emp_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      description: json['description'],
      assignedBy: json['assigned_by'],
      assignedById: json['assigned_by_id'],
      assignedTo: json['assigned_to'],
      assignedToId: json['assigned_to_id'],
      project: json['project'],
      priority: json['priority'],
      status: json['status'],
      progressNote: json['progress_note'],
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'])
          : null,
      comment: json['comment'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      projectTeamBy: json['project_team_by'] != null
          ? ProjectTeamModel.fromJson(json['project_team_by'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'web_user_id': webUserId,
    'emp_name': empName,
    'emp_id': empId,
    'date': date?.toIso8601String(),
    'description': description,
    'assigned_by': assignedBy,
    'assigned_by_id': assignedById,
    'assigned_to': assignedTo,
    'assigned_to_id': assignedToId,
    'project': project,
    'priority': priority,
    'status': status,
    'progress_note': progressNote,
    'deadline': deadline?.toIso8601String(),
    'comment': comment,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'project_team_by': (projectTeamBy as ProjectTeamModel?)?.toJson(),
  };
}

class ProjectTeamModel extends ProjectTeam {
  const ProjectTeamModel({
    super.id,
    super.projectId,
    super.projectName,
    super.webUserId,
    super.empName,
    super.empId,
    super.member,
    super.role,
    super.progress,
    super.status,
    super.comment,
    super.createdAt,
    super.updatedAt,
  });

  factory ProjectTeamModel.fromJson(Map<String, dynamic> json) {
    return ProjectTeamModel(
      id: json['id'],
      projectId: json['project_id'],
      projectName: json['project_name'],
      webUserId: json['web_user_id'],
      empName: json['emp_name'],
      empId: json['emp_id'],
      member: json['member'],
      role: json['role'],
      progress: json['progress'],
      status: json['status'],
      comment: json['comment'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'project_id': projectId,
    'project_name': projectName,
    'web_user_id': webUserId,
    'emp_name': empName,
    'emp_id': empId,
    'member': member,
    'role': role,
    'progress': progress,
    'status': status,
    'comment': comment,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class ProjectModel extends Project {
  const ProjectModel({
    super.id,
    super.adminUserId,
    super.companyName,
    super.name,
    super.domain,
    super.projectManagerId,
    super.projectManagerName,
    super.progress,
    super.client,
    super.comment,
    super.deadline,
    super.createdAt,
    super.updatedAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      adminUserId: json['admin_user_id'],
      companyName: json['company_name'],
      name: json['name'],
      domain: json['domain'],
      projectManagerId: json['project_manager_id'],
      projectManagerName: json['project_manager_name'],
      progress: json['progress'],
      client: json['client'],
      comment: json['comment'],
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'admin_user_id': adminUserId,
    'company_name': companyName,
    'name': name,
    'domain': domain,
    'project_manager_id': projectManagerId,
    'project_manager_name': projectManagerName,
    'progress': progress,
    'client': client,
    'comment': comment,
    'deadline': deadline?.toIso8601String(),
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
*/
import 'package:fuoday/features/performance/domain/entities/performance_summary_entity.dart';

class PerformanceSummaryModel extends PerformanceSummaryEntity {
  const PerformanceSummaryModel({
    super.tasks,
    super.totalCompleted,
    super.completedTasks,
    super.totalPending,
    super.pendingGoals,
    super.goalProgressPercentage,
    super.goalProgress,
    super.performanceScore,
    super.performanceRatingOutOf5,
    super.totalCompletedProjects,
    super.completedProjects,
    super.totalUpcomingProjects,
    super.upcomingProjects,
    super.averageMonthlyAttendance,
  });

  factory PerformanceSummaryModel.fromJson(Map<String, dynamic> json) {
    return PerformanceSummaryModel(
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => TaskModel.fromJson(e))
          .toList(),
      totalCompleted: json['total_completed'] is int
          ? json['total_completed']
          : int.tryParse(json['total_completed']?.toString() ?? ''),
      completedTasks: (json['completed_tasks'] as List<dynamic>?)
          ?.map((e) => TaskModel.fromJson(e))
          .toList(),
      totalPending: json['total_pending'] is int
          ? json['total_pending']
          : int.tryParse(json['total_pending']?.toString() ?? ''),
      pendingGoals: (json['pending_goals'] as List<dynamic>?)
          ?.map((e) => GoalModel.fromJson(e))
          .toList(),
      goalProgressPercentage: (json['goal_progress_percentage'] as num?)
          ?.toDouble(),
      goalProgress: (json['goal_progress'] as List<dynamic>?)
          ?.map((e) => GoalModel.fromJson(e))
          .toList(),
      performanceScore: json['performance_score'] is int
          ? json['performance_score']
          : int.tryParse(json['performance_score']?.toString() ?? ''),
      performanceRatingOutOf5: json['performance_rating_out_of_5'] is int
          ? json['performance_rating_out_of_5']
          : int.tryParse(json['performance_rating_out_of_5']?.toString() ?? ''),
      totalCompletedProjects: json['total_completed_projects'] is int
          ? json['total_completed_projects']
          : int.tryParse(json['total_completed_projects']?.toString() ?? ''),
      completedProjects: (json['completed_projects'] as List<dynamic>?)
          ?.map((e) => ProjectModel.fromJson(e))
          .toList(),
      totalUpcomingProjects: json['total_upcoming_projects'] is int
          ? json['total_upcoming_projects']
          : int.tryParse(json['total_upcoming_projects']?.toString() ?? ''),
      upcomingProjects: (json['upcoming_projects'] as List<dynamic>?)
          ?.map((e) => ProjectModel.fromJson(e))
          .toList(),
      averageMonthlyAttendance: (json['average_monthly_attendance'] as num?)
          ?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'tasks': tasks?.map((e) => (e as TaskModel).toJson()).toList(),
    'total_completed': totalCompleted,
    'completed_tasks': completedTasks
        ?.map((e) => (e as TaskModel).toJson())
        .toList(),
    'total_pending': totalPending,
    'pending_goals': pendingGoals
        ?.map((e) => (e as GoalModel).toJson())
        .toList(),
    'goal_progress_percentage': goalProgressPercentage,
    'goal_progress': goalProgress
        ?.map((e) => (e as GoalModel).toJson())
        .toList(),
    'performance_score': performanceScore,
    'performance_rating_out_of_5': performanceRatingOutOf5,
    'total_completed_projects': totalCompletedProjects,
    'completed_projects': completedProjects
        ?.map((e) => (e as ProjectModel).toJson())
        .toList(),
    'total_upcoming_projects': totalUpcomingProjects,
    'upcoming_projects': upcomingProjects
        ?.map((e) => (e as ProjectModel).toJson())
        .toList(),
    'average_monthly_attendance': averageMonthlyAttendance,
  };
}

class TaskModel extends Task {
  const TaskModel({
    super.description,
    super.assignedBy,
    super.project,
    super.priority,
    super.status,
    super.progressNote,
    super.deadline,
    super.date,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      description: json['description'],
      assignedBy: json['assigned_by'],
      project: json['project'],
      priority: json['priority'],
      status: json['status'],
      progressNote: json['progress_note'],
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'])
          : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'description': description,
    'assigned_by': assignedBy,
    'project': project,
    'priority': priority,
    'status': status,
    'progress_note': progressNote,
    'deadline': deadline?.toIso8601String(),
    'date': date?.toIso8601String(),
  };
}

class GoalModel extends Goal {
  const GoalModel({
    super.id,
    super.webUserId,
    super.empName,
    super.empId,
    super.date,
    super.description,
    super.assignedBy,
    super.assignedById,
    super.assignedTo,
    super.assignedToId,
    super.project,
    super.priority,
    super.status,
    super.progressNote,
    super.deadline,
    super.comment,
    super.createdAt,
    super.updatedAt,
    super.projectTeamBy,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      webUserId: json['web_user_id'] is int
          ? json['web_user_id']
          : int.tryParse(json['web_user_id']?.toString() ?? ''),
      empName: json['emp_name'],
      empId: json['emp_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      description: json['description'],
      assignedBy: json['assigned_by'],
      assignedById: json['assigned_by_id'] is int
          ? json['assigned_by_id']
          : int.tryParse(json['assigned_by_id']?.toString() ?? ''),
      assignedTo: json['assigned_to'],
      assignedToId: json['assigned_to_id'] is int
          ? json['assigned_to_id']
          : int.tryParse(json['assigned_to_id']?.toString() ?? ''),
      project: json['project'],
      priority: json['priority'],
      status: json['status'],
      progressNote: json['progress_note'],
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'])
          : null,
      comment: json['comment'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      projectTeamBy: json['project_team_by'] != null
          ? ProjectTeamModel.fromJson(json['project_team_by'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'web_user_id': webUserId,
    'emp_name': empName,
    'emp_id': empId,
    'date': date?.toIso8601String(),
    'description': description,
    'assigned_by': assignedBy,
    'assigned_by_id': assignedById,
    'assigned_to': assignedTo,
    'assigned_to_id': assignedToId,
    'project': project,
    'priority': priority,
    'status': status,
    'progress_note': progressNote,
    'deadline': deadline?.toIso8601String(),
    'comment': comment,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'project_team_by': (projectTeamBy as ProjectTeamModel?)?.toJson(),
  };
}

class ProjectTeamModel extends ProjectTeam {
  const ProjectTeamModel({
    super.id,
    super.projectId,
    super.projectName,
    super.webUserId,
    super.empName,
    super.empId,
    super.member,
    super.role,
    super.progress,
    super.status,
    super.comment,
    super.createdAt,
    super.updatedAt,
  });

  factory ProjectTeamModel.fromJson(Map<String, dynamic> json) {
    return ProjectTeamModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      projectId: json['project_id'] is int
          ? json['project_id']
          : int.tryParse(json['project_id']?.toString() ?? ''),
      projectName: json['project_name'],
      webUserId: json['web_user_id'] is int
          ? json['web_user_id']
          : int.tryParse(json['web_user_id']?.toString() ?? ''),
      empName: json['emp_name'],
      empId: json['emp_id'],
      member: json['member'],
      role: json['role'],
      progress: json['progress'],
      status: json['status'],
      comment: json['comment'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'project_id': projectId,
    'project_name': projectName,
    'web_user_id': webUserId,
    'emp_name': empName,
    'emp_id': empId,
    'member': member,
    'role': role,
    'progress': progress,
    'status': status,
    'comment': comment,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class ProjectModel extends Project {
  const ProjectModel({
    super.id,
    super.adminUserId,
    super.companyName,
    super.name,
    super.domain,
    super.projectManagerId,
    super.projectManagerName,
    super.progress,
    super.client,
    super.comment,
    super.deadline,
    super.createdAt,
    super.updatedAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
      adminUserId: json['admin_user_id'] is int
          ? json['admin_user_id']
          : int.tryParse(json['admin_user_id']?.toString() ?? ''),
      companyName: json['company_name'],
      name: json['name'],
      domain: json['domain'],
      projectManagerId: json['project_manager_id'],
      projectManagerName: json['project_manager_name'],
      progress: json['progress'],
      client: json['client'],
      comment: json['comment'],
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'admin_user_id': adminUserId,
    'company_name': companyName,
    'name': name,
    'domain': domain,
    'project_manager_id': projectManagerId,
    'project_manager_name': projectManagerName,
    'progress': progress,
    'client': client,
    'comment': comment,
    'deadline': deadline?.toIso8601String(),
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}
