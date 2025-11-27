//=============================================
// Domain Layer: USE CASE
//=============================================

import 'package:fuoday/features/team_leader/domain/entities/late_arrivals_entity.dart';
import 'package:fuoday/features/team_leader/domain/repository/late_arrivals_repository.dart';

class GetLateArrivalsUseCase {
  final LateArrivalsRepository repository;

  GetLateArrivalsUseCase({required this.repository});

  Future<LateArrivalsEntity> call() {
    return repository.getAllLateArrivals();
  }
}
