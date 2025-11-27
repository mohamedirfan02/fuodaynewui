import 'package:fuoday/features/organizations/domain/entities/organization_about_entity.dart';

abstract class OrganizationAboutRepository {
  Future<OrganizationAboutEntity> getAbout(String webUserId);
}