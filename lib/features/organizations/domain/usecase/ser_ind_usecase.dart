import 'package:fuoday/features/organizations/domain/entities/ser_ind_entities.dart';
import 'package:fuoday/features/organizations/domain/repositories/ser_ind_repository.dart';

class GetServicesAndIndustriesUseCase {
  final ServicesAndIndustriesRepository repository;

  GetServicesAndIndustriesUseCase(this.repository);

  Future<ServicesAndIndustriesEntity> call(String webUserId) {
    return repository.getServicesAndIndustries(webUserId);
  }
}