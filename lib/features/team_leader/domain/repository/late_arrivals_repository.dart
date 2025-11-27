//=============================================
// Domain Layer: REPOSITORY
//=============================================

import 'package:fuoday/features/team_leader/domain/entities/late_arrivals_entity.dart';

abstract class LateArrivalsRepository {
  Future<LateArrivalsEntity> getAllLateArrivals();
}
