import 'package:fuoday/features/teams/domain/entities/team_reportees_entity.dart';

class TeamReporteesModel extends TeamReporteesEntity {
  TeamReporteesModel({
    required super.id,
    required super.name,
    required super.designation,
    required super.profile,
    required super.department,
    required super.parentId,
  });

  factory TeamReporteesModel.fromJson(Map<String, dynamic> json) {
    return TeamReporteesModel(
      id: json['id'],
      name: json['name'],
      designation: json['designation'],
      profile: json['profile'],
      department: json['department'],
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'profile': profile,
      'department': department,
      'parentId': parentId,
    };
  }
}
