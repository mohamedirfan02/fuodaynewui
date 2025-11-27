class EmployeeProfileModel {
  final String name;
  final String? about;
  final String dob;
  final String? address;
  final String email;
  final String personalContactNo;
  final String department;
  final String designation;
  final String dateOfJoining;
  final String reportingManagerName;
  final String empId;

  EmployeeProfileModel({
    required this.name,
    this.about,
    required this.dob,
    this.address,
    required this.email,
    required this.personalContactNo,
    required this.department,
    required this.designation,
    required this.dateOfJoining,
    required this.reportingManagerName,
    required this.empId,
  });

  factory EmployeeProfileModel.fromJson(Map<String, dynamic> json) {
    return EmployeeProfileModel(
      name: json['name'],
      about: json['about'],
      dob: json['dob'],
      address: json['address'],
      email: json['email'],
      personalContactNo: json['personal_contact_no'],
      department: json['department'],
      designation: json['designation'],
      dateOfJoining: json['date_of_joining'],
      reportingManagerName: json['reporting_manager_name'],
      empId: json['emp_id'],
    );
  }
}
