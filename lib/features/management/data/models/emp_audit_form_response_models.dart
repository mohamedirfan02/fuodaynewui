class EmpAuditFormResponse {
  final String status;
  final String message;
  final List<ManagerWithEmployees> data;

  EmpAuditFormResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory EmpAuditFormResponse.fromJson(Map<String, dynamic> json) {
    return EmpAuditFormResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ManagerWithEmployees.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

class ManagerWithEmployees {
  final dynamic managerId;
  final String managerName;
  final List<EmployeeAuditData> employees;

  ManagerWithEmployees({
    required this.managerId,
    required this.managerName,
    required this.employees,
  });

  factory ManagerWithEmployees.fromJson(Map<String, dynamic> json) {
    return ManagerWithEmployees(
      managerId: json['manager_id'],
      managerName: json['manager_name'] ?? '',
      employees: (json['employees'] as List<dynamic>?)
          ?.map((e) => EmployeeAuditData.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

class EmployeeAuditData {
  final int id;
  final String empName;
  final String empId;
  final String designation;
  final String department;
  final String doj;
  final String? profilePhoto;
  final String status;

  EmployeeAuditData({
    required this.id,
    required this.empName,
    required this.empId,
    required this.designation,
    required this.department,
    required this.doj,
    this.profilePhoto,
    required this.status,
  });

  factory EmployeeAuditData.fromJson(Map<String, dynamic> json) {
    return EmployeeAuditData(
      id: json['id'] ?? 0,
      empName: json['emp_name'] ?? '',
      empId: json['emp_id'] ?? '',
      designation: json['designation'] ?? '',
      department: json['department'] ?? '',
      doj: json['doj'] ?? '',
      profilePhoto: json['profile_photo'],
      status: json['status'] ?? '',
    );
  }
}