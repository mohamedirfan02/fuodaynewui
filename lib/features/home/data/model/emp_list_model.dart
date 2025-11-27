class EmployeeModel {
  final int id; // Changed from webUserId to id
  final String name; // Changed from empName to name
  final String empId;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.empId,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      // Match the actual API response field names
      id: json['id'] ?? 0, // API returns 'id', not 'web_user_id'
      name: json['name']?.toString() ?? 'Unknown Employee', // API returns 'name', not 'emp_name'
      empId: json['emp_id']?.toString() ?? 'NO_ID', // This matches
    );
  }

  // Getter for backward compatibility if needed elsewhere
  int get webUserId => id;
  String get empName => name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'emp_id': empId,
    };
  }

  @override
  String toString() {
    return 'EmployeeModel(id: $id, name: $name, empId: $empId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EmployeeModel &&
        other.id == id &&
        other.name == name &&
        other.empId == empId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ empId.hashCode;
  }
}