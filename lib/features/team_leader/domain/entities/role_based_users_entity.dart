import 'dart:convert';

/// Root entity that holds HR, Manager, and Teams group data
class RoleBasedUsersEntity {
  final RoleGroup hr;
  final RoleGroup manager;
  final RoleGroup teams;

  RoleBasedUsersEntity({
    required this.hr,
    required this.manager,
    required this.teams,
  });

  /// ✅ Easy accessors for UI or business logic
  List<UserEntity> get hrList => hr.data;
  List<UserEntity> get managerList => manager.data;
  List<UserEntity> get teamsList => teams.data;

  /// ✅ Deserialize (internal use only, not direct API parsing)
  factory RoleBasedUsersEntity.fromJson(Map<String, dynamic> json) {
    return RoleBasedUsersEntity(
      hr: RoleGroup.fromJson(json['hr'] ?? {}),
      manager: RoleGroup.fromJson(json['manager'] ?? {}),
      teams: RoleGroup.fromJson(json['teams'] ?? {}),
    );
  }

  /// ✅ Serialize (for caching or debug)
  Map<String, dynamic> toJson() => {
    'hr': hr.toJson(),
    'manager': manager.toJson(),
    'teams': teams.toJson(),
  };

  @override
  String toString() {
    final encoder = const JsonEncoder.withIndent('  ');
    return 'RoleBasedUsersEntity:\n${encoder.convert(toJson())}';
  }
}

/// Represents a group of users (e.g. HR group)
class RoleGroup {
  final int totalCount;
  final List<UserEntity> data;

  RoleGroup({required this.totalCount, required this.data});

  factory RoleGroup.fromJson(Map<String, dynamic> json) {
    return RoleGroup(
      totalCount: json['total_count'] ?? json['totalCount'] ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => UserEntity.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'total_count': totalCount,
    'data': data.map((e) => e.toJson()).toList(),
  };

  @override
  String toString() =>
      'RoleGroup(totalCount: $totalCount, dataCount: ${data.length})';
}

/// Represents a single user in the domain layer
class UserEntity {
  final int webUserId;
  final String empId;
  final String email;
  final String empName;
  final String role;
  final String? reportingManagerId;
  final String? reportingManagerName;

  UserEntity({
    required this.webUserId,
    required this.empId,
    required this.email,
    required this.empName,
    required this.role,
    this.reportingManagerId,
    this.reportingManagerName,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
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

  Map<String, dynamic> toJson() => {
    'web_user_id': webUserId,
    'emp_id': empId,
    'email': email,
    'emp_name': empName,
    'role': role,
    'reporting_manager_id': reportingManagerId,
    'reporting_manager_name': reportingManagerName,
  };

  @override
  String toString() => 'UserEntity(${jsonEncode(toJson())})';
}
