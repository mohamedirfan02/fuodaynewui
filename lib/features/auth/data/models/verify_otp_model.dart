import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';

class VerifyOtpModel extends VerifyOtpEntity {
  VerifyOtpModel({required super.status, required super.message});

  // Factory constructor to convert JSON response into model
  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(status: json['status'], message: json['message']);
  }

  // Convert model to JSON if needed (e.g., request body)
  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message};
  }
}
