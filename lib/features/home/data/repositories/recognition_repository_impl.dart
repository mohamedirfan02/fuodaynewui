import 'package:fuoday/features/home/data/datasources/remote/recognition_remote_data_source.dart';
import 'package:fuoday/features/home/data/model/recognition_model.dart';
import 'package:fuoday/features/home/domain/entities/recognition_entity.dart';
import 'package:fuoday/features/home/domain/repositories/recognition_repository.dart';

class RecognitionRepositoryImpl implements RecognitionRepository {
  final RecognitionRemoteDataSource remoteDataSource;

  RecognitionRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> saveRecognitions({
    required int webUserId,
    required List<RecognitionEntity> badges,
  }) {
    // Convert Entity → Model
    final models = badges.map((b) {
      if (b is RecognitionModel) {
        return b; // already a model
      } else {
        return RecognitionModel(
          id: b.id,
          title: b.title,
          count: b.count,
          imageUrl: b.imageUrl,
          // 👇 keep null here since Entity doesn’t know local path
          imagePath: null,
        );
      }
    }).toList();

    return remoteDataSource.saveRecognitions(webUserId: webUserId, badges: models);
  }
}
