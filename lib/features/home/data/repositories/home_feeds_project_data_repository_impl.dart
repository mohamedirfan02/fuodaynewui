import 'package:fuoday/features/home/data/datasources/remote/home_feeds_project_remote_data_source.dart';
import 'package:fuoday/features/home/domain/entities/home_feeds_project_data_entity.dart';
import 'package:fuoday/features/home/domain/repositories/home_feeds_project_data_repository.dart';

class HomeFeedsProjectDataRepositoryImpl
    implements HomeFeedsProjectDataRepository {
  final HomeFeedsProjectRemoteDataSource remoteDataSource;

  HomeFeedsProjectDataRepositoryImpl(this.remoteDataSource);

  @override
  Future<HomeFeedsProjectDataEntity> getHomeFeeds(String webUserId) async {
    final model = await remoteDataSource.getFeeds(webUserId);
    return HomeFeedsProjectDataEntity(
      assigned: model.assigned
          .map(
            (e) => HomeFeedEntity(
              id: e.id, // 👈 added this
              date: e.date,
              description: e.description,
              assignedBy: e.assignedBy,
              assignedTo: e.assignedTo,
              projectName: e.projectName,
              progress: e.progress,
              deadline: e.deadline,
              comment: e.comment,             // ✅
              progressNote: e.progressNote,
            ),
          )
          .toList(),
      pending: model.pending
          .map(
            (e) => HomeFeedEntity(
              id: e.id, // 👈 added this
              date: e.date,
              description: e.description,
              assignedBy: e.assignedBy,
              assignedTo: e.assignedTo,
              projectName: e.projectName,
              progress: e.progress,
              deadline: e.deadline,
              comment: e.comment,             // ✅
              progressNote: e.progressNote,
            ),
          )
          .toList(),
    );
  }
}
