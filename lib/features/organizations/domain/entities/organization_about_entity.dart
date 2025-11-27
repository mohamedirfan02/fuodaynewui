class OrganizationAboutEntity {
  final String aboutDescription;
  final List<String> achievements;
  final List<String> values;
  final String clientDescription;
  final List<ClientEntity> clients;

  OrganizationAboutEntity({
    required this.aboutDescription,
    required this.achievements,
    required this.values,
    required this.clientDescription,
    required this.clients,
  });
}

class ClientEntity {
  final String name;
  final String logo;

  ClientEntity({required this.name, required this.logo});
}