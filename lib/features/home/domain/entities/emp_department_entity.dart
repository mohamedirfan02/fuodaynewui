class EmployeeDepartmentEntity {
  final String message;
  final String status;
  final List<EmployeeModelEntity> data;
  final List<EmployeeModelEntity> sameDepartment;
  final String userDepartment;

  EmployeeDepartmentEntity({
    required this.message,
    required this.status,
    required this.data,
    required this.sameDepartment,
    required this.userDepartment,
  });
}

class EmployeeModelEntity {
  final int webUserId;
  final String empName;
  final String empId;
  final String department;

  EmployeeModelEntity({
    required this.webUserId,
    required this.empName,
    required this.empId,
    required this.department,
  });
  @override
  String toString() {
    return 'EmployeeModelEntity(empName: $empName, empId: $empId, dept: $department)';
  }
}
