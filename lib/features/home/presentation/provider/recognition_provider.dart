import 'package:flutter/material.dart';
import 'package:fuoday/features/home/data/model/recognition_model.dart';
import 'package:fuoday/features/home/domain/usecases/save_recognitions_usecase.dart';

class RecognitionProvider with ChangeNotifier {
  final SaveRecognitionsUseCase saveRecognitionsUseCase;

  RecognitionProvider({required this.saveRecognitionsUseCase});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> saveRecognitions({
    required int webUserId,
    required List<RecognitionModel> badges,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await saveRecognitionsUseCase(webUserId: webUserId, badges: badges);
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
