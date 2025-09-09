import 'package:fuoday/features/home/domain/entities/recognition_entity.dart';

class RecognitionModel extends RecognitionEntity {
  final String? imagePath; // local path for upload

  RecognitionModel({
    String? id,
    required String title,
    required int count,
    this.imagePath,
    String? imageUrl,
  }) : super(
    id: id,
    title: title,
    count: count,
    imageUrl: imageUrl,
  );
}
