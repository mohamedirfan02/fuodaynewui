class DepartmentMemberModel {
  final int webUserId;
  final String name;
  final String empId;
  final String email;
  final String role;
  final String department;
  final String designation;

  DepartmentMemberModel({
    required this.webUserId,
    required this.name,
    required this.empId,
    required this.email,
    required this.role,
    required this.department,
    required this.designation,
  });

  factory DepartmentMemberModel.fromJson(Map<String, dynamic> json) {
    return DepartmentMemberModel(
      webUserId: json['web_user_id'],
      name: json['name'],
      empId: json['emp_id'],
      email: json['email'],
      role: json['role'],
      department: json['department'],
      designation: json['designation'],
    );
  }
}
