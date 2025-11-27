

import 'package:fuoday/features/home/domain/entities/home_feeds_project_data_entity.dart';
import 'package:fuoday/features/home/domain/repositories/home_feeds_project_data_repository.dart';

class GetHomeFeedsProjectDataUseCase {
  final HomeFeedsProjectDataRepository repository;

  GetHomeFeedsProjectDataUseCase(this.repository);

  Future<HomeFeedsProjectDataEntity> call(String webUserId) {
    return repository.getHomeFeeds(webUserId);
  }
}
