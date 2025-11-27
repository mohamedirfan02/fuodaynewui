import 'package:file_picker/file_picker.dart';

class AppFilePicker {
  Future<PlatformFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.first;
    }
    return null;
  }
}
