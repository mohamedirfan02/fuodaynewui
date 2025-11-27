class TeamTreeModel {
  final int managerId;
  final String managerName;
  final List<EmployeeModel> employees;

  TeamTreeModel({
    required this.managerId,
    required this.managerName,
    required this.employees,
  });

  factory TeamTreeModel.fromJson(Map<String, dynamic> json) {
    return TeamTreeModel(
      managerId: int.tryParse(json['manager_id'].toString()) ?? 0,
      managerName: json['manager_name'] ?? '',
      employees: (json['employees'] as List)
          .map((e) => EmployeeModel.fromJson(e))
          .toList(),
    );
  }

  // Helper method to check if this is a valid assigned manager
  bool get isAssignedManager {
    return managerId > 0 &&
        managerName.toLowerCase() != 'unassigned' &&
        employees.isNotEmpty;
  }

  // Static method to filter team tree data
  static List<TeamTreeModel> filterAssignedManagers(List<TeamTreeModel> teamData) {
    return teamData.where((team) => team.isAssignedManager).toList();
  }
}

class EmployeeModel {
  final int id;
  final String empName;
  final String empId;
  final String designation;
  final String department;
  final String doj;
  final String? profilePhoto;
  final String status;

  EmployeeModel({
    required this.id,
    required this.empName,
    required this.empId,
    required this.designation,
    required this.department,
    required this.doj,
    required this.profilePhoto,
    required this.status,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      empName: json['emp_name'] ?? '',
      empId: json['emp_id'].toString(),
      designation: json['designation'] ?? '',
      department: json['department'] ?? '',
      doj: json['doj'] ?? '',
      profilePhoto: json['profile_photo'],
      status: json['status'] ?? '',
    );
  }
}