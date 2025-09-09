
import 'package:fuoday/features/home/domain/entities/recognition_entity.dart';

abstract class RecognitionRepository {
  Future<void> saveRecognitions({
    required int webUserId,
    required List<RecognitionEntity> badges,
  });
}
