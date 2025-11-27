
import 'package:fuoday/features/time_tracker/domain/entities/time_tracker_entity.dart';

class TrackerModel {
  final List<AttendanceModel> attendance;
  final List<ProjectModel> projects;

  TrackerModel({required this.attendance, required this.projects});

  factory TrackerModel.fromJson(Map<String, dynamic> json) {
    return TrackerModel(
      attendance: (json['attendances_this_week'] as List)
          .map((e) => AttendanceModel.fromJson(e)).toList(),
      projects: (json['projects'] as List)
          .map((e) => ProjectModel.fromJson(e)).toList(),
    );
  }

  TimeTrackerEntity toEntity() => TimeTrackerEntity(
    attendances: attendance.map((m) => m.toEntity()).toList(),
    projects: projects.map((m) => m.toEntity()).toList(),
  );
}

class AttendanceModel {
  final String date, firstLogin, lastLogout, totalHours;
  AttendanceModel({required this.date, required this.firstLogin, required this.lastLogout, required this.totalHours});
  factory AttendanceModel.fromJson(Map<String, dynamic> j) => AttendanceModel(
      date: j['date'], firstLogin: j['first_login'] ?? '-', lastLogout: j['last_logout'] ?? '-', totalHours: j['total_hours']);
  Attendance toEntity() => Attendance(date: date, firstLogin: firstLogin, lastLogout: lastLogout, totalHours: totalHours);
}

class ProjectModel {
  final String progress, deadline;
  final List<String> teamInitials;
  ProjectModel({required this.progress, required this.deadline, required this.teamInitials});
  factory ProjectModel.fromJson(Map<String, dynamic> j) {
    final initials = (j['project_team'] as List)
        .map((e) => (e['emp_name'] as String).trim()[0]) // FIXED
        .toList();
    return ProjectModel(progress: j['progress'], deadline: j['deadline'], teamInitials: initials);
  }
  Project toEntity() => Project(progress: progress, deadline: deadline, teamInitials: teamInitials);
}
