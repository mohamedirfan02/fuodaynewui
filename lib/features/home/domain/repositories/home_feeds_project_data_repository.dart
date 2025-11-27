

import 'package:fuoday/features/home/domain/entities/home_feeds_project_data_entity.dart';

abstract class HomeFeedsProjectDataRepository {
  Future<HomeFeedsProjectDataEntity> getHomeFeeds(String webUserId);
}
