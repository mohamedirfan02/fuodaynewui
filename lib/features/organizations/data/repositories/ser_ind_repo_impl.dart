import 'package:fuoday/features/organizations/data/datasources/remote/ser_ind_datasource.dart';
import 'package:fuoday/features/organizations/domain/entities/ser_ind_entities.dart';
import 'package:fuoday/features/organizations/domain/repositories/ser_ind_repository.dart';

class ServicesAndIndustriesRepositoryImpl implements ServicesAndIndustriesRepository {
  final ServicesAndIndustriesDatasource datasource;

  ServicesAndIndustriesRepositoryImpl(this.datasource);

  @override
  Future<ServicesAndIndustriesEntity> getServicesAndIndustries(String webUserId) async {
    final model = await datasource.fetchServicesAndIndustries(webUserId);

    return ServicesAndIndustriesEntity(
      servicesDescription: model.servicesDescription,
      industriesDescription: model.industriesDescription,
      services: model.services
          .map((s) => ServiceEntity(name: s.name, description: s.description))
          .toList(),
      industries: model.industries
          .map((i) => IndustryEntity(name: i.name, description: i.description))
          .toList(),
    );
  }
}