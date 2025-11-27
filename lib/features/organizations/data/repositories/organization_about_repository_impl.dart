import 'package:fuoday/features/organizations/data/datasources/remote/organization_about_datasource.dart';
import 'package:fuoday/features/organizations/domain/entities/organization_about_entity.dart';
import 'package:fuoday/features/organizations/domain/repositories/organization_about_repository.dart';

class OrganizationAboutRepositoryImpl implements OrganizationAboutRepository {
  final OrganizationAboutDatasource datasource;

  OrganizationAboutRepositoryImpl(this.datasource);

  @override
  Future<OrganizationAboutEntity> getAbout(String webUserId) {
    return datasource.getAbout(webUserId);
  }
}