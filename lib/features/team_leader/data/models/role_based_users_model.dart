import 'package:fuoday/features/team_leader/domain/entities/role_based_users_entity.dart';

/// Model for role-based users (raw API data → Model → Entity)
class RoleBasedUsersModel {
  final RoleGroupModel hr;
  final RoleGroupModel manager;
  final RoleGroupModel teams;

  RoleBasedUsersModel({
    required this.hr,
    required this.manager,
    required this.teams,
  });

  /// Factory constructor to parse JSON from API response
  factory RoleBasedUsersModel.fromJson(Map<String, dynamic> json) {
    return RoleBasedUsersModel(
      hr: RoleGroupModel.fromJson(json['hr'] ?? {}),
      manager: RoleGroupModel.fromJson(json['manager'] ?? {}),
      teams: RoleGroupModel.fromJson(json['teams'] ?? {}),
    );
  }

  /// Convert model → domain entity
  RoleBasedUsersEntity toEntity() => RoleBasedUsersEntity(
    hr: hr.toEntity(),
    manager: manager.toEntity(),
    teams: teams.toEntity(),
  );
}

/// Represents a group (e.g., HR, Manager, Teams)
class RoleGroupModel {
  final int totalCount;
  final List<UserModel> data;

  RoleGroupModel({required this.totalCount, required this.data});

  factory RoleGroupModel.fromJson(Map<String, dynamic> json) {
    return RoleGroupModel(
      totalCount: json['total_count'] ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => UserModel.fromJson(e))
          .toList(),
    );
  }

  RoleGroup toEntity() => RoleGroup(
    totalCount: totalCount,
    data: data.map((e) => e.toEntity()).toList(),
  );
}

/// Represents an individual user (raw API layer)
class UserModel {
  final int webUserId;
  final String empId;
  final String email;
  final String empName;
  final String role;
  final String? reportingManagerId;
  final String? reportingManagerName;

  UserModel({
    required this.webUserId,
    required this.empId,
    required this.email,
    required this.empName,
    required this.role,
    this.reportingManagerId,
    this.reportingManagerName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      webUserId: json['web_user_id'] ?? json['webUserId'] ?? 0,
      empId: json['emp_id'] ?? json['empId'] ?? '',
      email: json['email'] ?? '',
      empName: json['emp_name'] ?? json['empName'] ?? '',
      role: json['role'] ?? '',
      reportingManagerId:
          json['reporting_manager_id'] ?? json['reportingManagerId'],
      reportingManagerName:
          json['reporting_manager_name'] ?? json['reportingManagerName'],
    );
  }

  UserEntity toEntity() => UserEntity(
    webUserId: webUserId,
    empId: empId,
    email: email,
    empName: empName,
    role: role,
    reportingManagerId: reportingManagerId,
    reportingManagerName: reportingManagerName,
  );
}
