import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AppFilePickerProvider extends ChangeNotifier {
  final Map<String, PlatformFile?> _pickedFiles = {};

  PlatformFile? getFile(String key) => _pickedFiles[key];

  bool isPicked(String key) => _pickedFiles[key] != null;

  Future<void> pickFile(String key) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
    );

    if (result != null && result.files.isNotEmpty) {
      _pickedFiles[key] = result.files.first;
    } else {
      _pickedFiles[key] = null;
    }

    notifyListeners();
  }

  // ✅ NEW METHOD
  void removeFile(String key) {
    _pickedFiles[key] = null;
    notifyListeners();
  }
}
