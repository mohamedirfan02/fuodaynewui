import 'package:fuoday/features/teams/domain/entities/team_member_entity.dart';

class TeamMemberModel extends TeamMemberEntity {
  TeamMemberModel({
    required super.empId,
    required super.name,
    required super.email,
    required super.department,
    required super.designation,
    required super.location,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) {
    return TeamMemberModel(
      empId: json['emp_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      department: json['department'] ?? '',
      designation: json['designation'] ?? '',
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emp_id': empId,
      'name': name,
      'email': email,
      'department': department,
      'designation': designation,
      'location': location,
    };
  }
}
