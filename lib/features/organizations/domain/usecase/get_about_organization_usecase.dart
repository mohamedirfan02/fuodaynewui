import 'package:fuoday/features/organizations/domain/entities/organization_about_entity.dart';
import 'package:fuoday/features/organizations/domain/repositories/organization_about_repository.dart';

class GetAboutOrganizationUseCase {
  final OrganizationAboutRepository repository;

  GetAboutOrganizationUseCase(this.repository);

  Future<OrganizationAboutEntity> call(String webUserId) {
    return repository.getAbout(webUserId);
  }
}