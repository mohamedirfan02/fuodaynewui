class EmployeeModel {
  final int webUserId;
  final String empName;
  final String empId;
  final String department;

  EmployeeModel({
    required this.webUserId,
    required this.empName,
    required this.empId,
    required this.department,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      webUserId: json['web_user_id'],
      empName: json['emp_name'],
      empId: json['emp_id'],
      department: json['department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'web_user_id': webUserId,
      'emp_name': empName,
      'emp_id': empId,
      'department': department,
    };
  }
}

class EmployeeDepartmentResponse {
  final String message;
  final String status;
  final List<EmployeeModel> data;
  final List<EmployeeModel> sameDepartment;
  final String userDepartment;

  EmployeeDepartmentResponse({
    required this.message,
    required this.status,
    required this.data,
    required this.sameDepartment,
    required this.userDepartment,
  });

  factory EmployeeDepartmentResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeDepartmentResponse(
      message: json['message'],
      status: json['status'],
      data: (json['data'] as List)
          .map((e) => EmployeeModel.fromJson(e))
          .toList(),
      sameDepartment: (json['same_department'] as List)
          .map((e) => EmployeeModel.fromJson(e))
          .toList(),
      userDepartment: json['user_department'],
    );
  }
}
