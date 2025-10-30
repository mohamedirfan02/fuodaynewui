//=============================================
// Data Layer: REPOSITORY IMPLEMENTATION
//=============================================

import 'package:fuoday/features/team_leader/data/datasource/AllRoleLateArrivalsReportRemoteDataSource.dart';
import 'package:fuoday/features/team_leader/domain/entities/late_arrivals_entity.dart';
import 'package:fuoday/features/team_leader/domain/repository/late_arrivals_repository.dart';

class LateArrivalsRepositoryImpl implements LateArrivalsRepository {
  final LateArrivalsRemoteDataSource remoteDataSource;

  LateArrivalsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<LateArrivalsEntity> getAllLateArrivals() async {
    final model = await remoteDataSource.getAllLateArrivals();
    return model.toEntity();
  }
}
