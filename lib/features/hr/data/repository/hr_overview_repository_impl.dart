
import 'package:fuoday/features/hr/data/datasources/hr_overview_remote_datasource.dart';
import 'package:fuoday/features/hr/domain/entities/hr_overview_entity.dart';
import 'package:fuoday/features/hr/domain/repository/hr_overview_repository.dart';

class HROverviewRepositoryImpl implements HROverviewRepository {
  final HROverviewRemoteDataSource remoteDataSource;

  HROverviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<HROverviewEntity> getHROverview(int webUserId) {
    return remoteDataSource.getHROverview(webUserId);
  }
}
