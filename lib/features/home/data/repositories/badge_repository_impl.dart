
import 'package:fuoday/features/home/data/datasources/remote/badge_remote_data_source.dart';
import 'package:fuoday/features/home/domain/entities/badge_entity.dart';
import 'package:fuoday/features/home/domain/repositories/badge_repository.dart';

class BadgeRepositoryImpl implements BadgeRepository {
  final BadgeRemoteDataSource remoteDataSource;

  BadgeRepositoryImpl(this.remoteDataSource);

  @override
  @override
  Future<List<BadgeEntity>> getBadges(int webUserId) async {
    final badges = await remoteDataSource.getBadges(webUserId);
    return badges.cast<BadgeEntity>(); // ✅ upcast List<BadgeModel> -> List<BadgeEntity>
  }

}
