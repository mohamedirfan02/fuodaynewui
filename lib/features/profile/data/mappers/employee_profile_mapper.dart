import '../../domain/entities/employee_profile_entity.dart';
import '../models/employee_profile_model.dart';

class EmployeeProfileMapper {
  static EmployeeProfileEntity toEntity(EmployeeProfileModel model) {
    final names = model.name.split(' ');
    final firstName = names.first;
    final lastName = names.length > 1 ? names.sublist(1).join(' ') : "";

    return EmployeeProfileEntity(
      firstName: firstName,
      lastName: lastName,
      about: model.about,
      dob: model.dob,
      address: model.address,
      email: model.email,
      contactNumber: model.personalContactNo,
      department: model.department,
      designation: model.designation,
      dateOfJoining: model.dateOfJoining,
      reportingManagerName: model.reportingManagerName,
      empId: model.empId,
    );
  }
}
