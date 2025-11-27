

import 'package:fuoday/features/home/domain/entities/recognition_entity.dart';
import 'package:fuoday/features/home/domain/repositories/recognition_repository.dart';

class SaveRecognitionsUseCase {
  final RecognitionRepository repository;

  SaveRecognitionsUseCase(this.repository);

  Future<void> call({
    required int webUserId,
    required List<RecognitionEntity> badges,
  }) async {
    return repository.saveRecognitions(
      webUserId: webUserId,
      badges: badges,
    );
  }
}
