import 'package:fuoday/features/organizations/domain/entities/ser_ind_entities.dart';

abstract class ServicesAndIndustriesRepository {
  Future<ServicesAndIndustriesEntity> getServicesAndIndustries(String webUserId);
}