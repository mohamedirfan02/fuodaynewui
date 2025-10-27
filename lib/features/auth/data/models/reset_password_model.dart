import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';

class ResetPasswordModel extends ResetPasswordEntity {
  ResetPasswordModel({required super.status, required super.message});

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message};
  }
}
