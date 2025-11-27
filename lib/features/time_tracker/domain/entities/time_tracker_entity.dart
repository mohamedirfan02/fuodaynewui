class TimeTrackerEntity {
  final List<Attendance> attendances;
  final List<Project> projects;
  TimeTrackerEntity({required this.attendances, required this.projects});
}

class Attendance {
  final String date, firstLogin, lastLogout, totalHours;
  Attendance({required this.date, this.firstLogin = '-', this.lastLogout = '-', required this.totalHours});
}

class Project {
  final String progress, deadline;
  final List<String> teamInitials;
  Project({required this.progress, required this.deadline, required this.teamInitials});
}
