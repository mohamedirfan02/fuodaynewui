class EmpAuditFormEntity {
  final String status;
  final String message;
  final List<ManagerWithEmployeesEntity> data;

  EmpAuditFormEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}

class ManagerWithEmployeesEntity {
  final dynamic managerId;
  final String managerName;
  final List<EmployeeAuditEntity> employees;

  ManagerWithEmployeesEntity({
    required this.managerId,
    required this.managerName,
    required this.employees,
  });
}

class EmployeeAuditEntity {
  final int id;
  final String empName;
  final String empId;
  final String designation;
  final String department;
  final String doj;
  final String? profilePhoto;
  final String status;

  EmployeeAuditEntity({
    required this.id,
    required this.empName,
    required this.empId,
    required this.designation,
    required this.department,
    required this.doj,
    this.profilePhoto,
    required this.status,
  });

  // Helper method to check if status is submitted
  bool get isSubmitted => status.toLowerCase() == 'submitted';
}