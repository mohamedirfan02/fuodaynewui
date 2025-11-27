import 'package:fuoday/features/organizations/domain/entities/organization_about_entity.dart';

class OrganizationAboutModel extends OrganizationAboutEntity {
  OrganizationAboutModel({
    required super.aboutDescription,
    required super.achievements,
    required super.values,
    required super.clientDescription,
    required super.clients,
  });

  factory OrganizationAboutModel.fromJson(Map<String, dynamic> json) {
    return OrganizationAboutModel(
      aboutDescription: json['about_description'] ?? '',
      achievements: List<String>.from(json['achievements'] ?? []),
      values: List<String>.from(json['values'] ?? []),
      clientDescription: json['client_description'] ?? '',
      clients: (json['clients'] as List?)?.map((e) => ClientModel.fromJson(e)).toList() ?? [],
    );
  }
}

class ClientModel extends ClientEntity {
  ClientModel({required super.name, required super.logo});

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
}