import 'package:fuoday/features/auth/data/models/employee_data_model.dart';
import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';

class EmployeeAuthModel extends EmployeeAuthEntity {
  EmployeeAuthModel({
    required super.status,
    required super.message,
    required EmployeeDataModel super.data,
    required super.token,
  });

  factory EmployeeAuthModel.fromJson(Map<String, dynamic> json) {
    return EmployeeAuthModel(
      status: json['status'],
      message: json['message'],
      data: EmployeeDataModel.fromJson(json['data']),
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': (data as EmployeeDataModel).toJson(),
      'token': token,
    };
  }
}
