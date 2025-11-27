import 'package:fuoday/features/teams/domain/entities/team_project_entity.dart';

class TeamProjectModel extends TeamProjectEntity {
  TeamProjectModel({
    required super.name,
    required super.domain,
    required super.deadline,
    required super.teamMembers,
  });

  factory TeamProjectModel.fromJson(Map<String, dynamic> json) {
    return TeamProjectModel(
      name: json['name'] ?? '',
      domain: json['domain'] ?? '',
      deadline: json['deadline'] ?? '',
      teamMembers: (json['team_members'] as List<dynamic>)
          .map((e) => TeamProjectMemberEntity(
        name: e['name'] ?? '',
        role: e['role'] ?? '',
      ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'domain': domain,
      'deadline': deadline,
      'team_members': teamMembers
          .map((e) => {
        'name': e.name,
        'role': e.role,
      })
          .toList(),
    };
  }
}
