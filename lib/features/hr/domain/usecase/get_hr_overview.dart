

import 'package:fuoday/features/hr/domain/entities/hr_overview_entity.dart';
import 'package:fuoday/features/hr/domain/repository/hr_overview_repository.dart';

class GetHROverview {
  final HROverviewRepository repository;

  GetHROverview(this.repository);

  Future<HROverviewEntity> call(int webUserId) async {
    return await repository.getHROverview(webUserId);
  }
}
