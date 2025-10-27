// forgot_password_model.dart

import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';

class ForgotPasswordModel extends ForgotPasswordEntity {
  ForgotPasswordModel({
    required super.status,
    required super.message,
    required super.debug,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      status: json['status'],
      message: json['message'],
      debug: ForgotPasswordDebugEntity(
        otp: json['debug']['otp'],
        email: json['debug']['email'],
        mailDriver: json['debug']['mail_driver'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'debug': {
        'otp': debug.otp,
        'email': debug.email,
        'mail_driver': debug.mailDriver,
      },
    };
  }
}
