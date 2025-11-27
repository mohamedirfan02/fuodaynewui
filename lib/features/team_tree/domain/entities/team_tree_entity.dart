class TeamTreeEntity {
  final int managerId;
  final String managerName;
  final List<EmployeeEntity> employees;

  TeamTreeEntity({
    required this.managerId,
    required this.managerName,
    required this.employees,
  });

  // Helper method to check if this is a valid assigned manager
  bool get isAssignedManager {
    return managerId > 0 &&
        managerName.toLowerCase() != 'unassigned' &&
        employees.isNotEmpty;
  }

  // Static method to filter team tree data
  static List<TeamTreeEntity> filterAssignedManagers(List<TeamTreeEntity> teamData) {
    return teamData.where((team) => team.isAssignedManager).toList();
  }
}

class EmployeeEntity {
  final int id;
  final String empName;
  final String empId;
  final String designation;
  final String department;
  final String doj;
  final String? profilePhoto;
  final String status;

  EmployeeEntity({
    required this.id,
    required this.empName,
    required this.empId,
    required this.designation,
    required this.department,
    required this.doj,
    required this.profilePhoto,
    required this.status,
  });
}