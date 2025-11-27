class ServiceModel {
  final String name;
  final String description;

  ServiceModel({required this.name, required this.description});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class IndustryModel {
  final String name;
  final String description;

  IndustryModel({required this.name, required this.description});

  factory IndustryModel.fromJson(Map<String, dynamic> json) {
    return IndustryModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class ServicesAndIndustriesModel {
  final String servicesDescription;
  final List<ServiceModel> services;
  final String industriesDescription;
  final List<IndustryModel> industries;

  ServicesAndIndustriesModel({
    required this.servicesDescription,
    required this.services,
    required this.industriesDescription,
    required this.industries,
  });

  factory ServicesAndIndustriesModel.fromJson(Map<String, dynamic> json) {
    return ServicesAndIndustriesModel(
      servicesDescription: json['services_description'] ?? '',
      services: (json['services'] as List?)?.map((e) => ServiceModel.fromJson(e)).toList() ?? [],
      industriesDescription: json['industries_description'] ?? '',
      industries: (json['industries'] as List?)?.map((e) => IndustryModel.fromJson(e)).toList() ?? [],
    );
  }
}