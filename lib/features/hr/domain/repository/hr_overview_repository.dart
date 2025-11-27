
import 'package:fuoday/features/hr/domain/entities/hr_overview_entity.dart';

abstract class HROverviewRepository {
  Future<HROverviewEntity> getHROverview(int webUserId);
}
