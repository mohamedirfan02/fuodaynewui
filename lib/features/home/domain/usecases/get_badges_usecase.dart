

import 'package:fuoday/features/home/domain/entities/badge_entity.dart';
import 'package:fuoday/features/home/domain/repositories/badge_repository.dart';

class GetBadgesUseCase {
  final BadgeRepository repository;

  GetBadgesUseCase(this.repository);

  Future<List<BadgeEntity>> call(int webUserId) async {
    return await repository.getBadges(webUserId);
  }
}
