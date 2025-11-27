import 'package:fuoday/features/auth/domain/entities/employee_auth_entities.dart';

class AdminUserModel extends AdminUserEntity {
  AdminUserModel({
    required super.id,
    required super.logo,
    required super.brandLogo,
    required super.companyName,
    required super.chatLogo,
    required super.companyWord,
  });

  factory AdminUserModel.fromJson(Map<String, dynamic> json) {
    return AdminUserModel(
      id: json['id'],
      logo: json['logo'],
      brandLogo: json['brand_logo'],
      companyName: json['company_name'],
      chatLogo: json['chat_logo'],
      companyWord: json['company_word'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo': logo,
      'brand_logo': brandLogo,
      'company_name': companyName,
      'chat_logo': chatLogo,
      'company_word': companyWord,
    };
  }
}
