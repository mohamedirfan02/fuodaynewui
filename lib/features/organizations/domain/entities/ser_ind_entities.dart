class ServiceEntity {
  final String name;
  final String description;
  ServiceEntity({required this.name, required this.description});
}

class IndustryEntity {
  final String name;
  final String description;
  IndustryEntity({required this.name, required this.description});
}

class ServicesAndIndustriesEntity {
  final String servicesDescription;
  final List<ServiceEntity> services;
  final String industriesDescription;
  final List<IndustryEntity> industries;

  ServicesAndIndustriesEntity({
    required this.servicesDescription,
    required this.services,
    required this.industriesDescription,
    required this.industries,
  });
}