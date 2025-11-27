import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/features/home/data/model/recognition_model.dart';

abstract class RecognitionRemoteDataSource {
  Future<void> saveRecognitions({
    required int webUserId,
    required List<RecognitionModel> badges,
  });
}

class RecognitionRemoteDataSourceImpl implements RecognitionRemoteDataSource {
  final DioService dioService;

  RecognitionRemoteDataSourceImpl(this.dioService);

  @override
  Future<void> saveRecognitions({
    required int webUserId,
    required List<RecognitionModel> badges,
  }) async {
    final formData = FormData();
    formData.fields.add(MapEntry("web_user_id", webUserId.toString()));

    for (int i = 0; i < badges.length; i++) {
      final badge = badges[i];

      formData.fields.add(MapEntry("badges[$i][title]", badge.title));
      formData.fields.add(MapEntry("badges[$i][count]", badge.count.toString()));

      if (badge.imagePath != null && File(badge.imagePath!).existsSync()) {
        formData.files.add(
          MapEntry(
            "badges[$i][image]",
            await MultipartFile.fromFile(
              badge.imagePath!,
              filename: badge.imagePath!.split('/').last,
            ),
          ),
        );
      }
    }

    await dioService.post("/hrms/home/recognitions", data: formData);
  }
}
