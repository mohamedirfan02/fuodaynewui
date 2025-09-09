
import 'package:fuoday/features/home/domain/entities/badge_entity.dart';

abstract class BadgeRepository {
  Future<List<BadgeEntity>> getBadges(int webUserId);
}
