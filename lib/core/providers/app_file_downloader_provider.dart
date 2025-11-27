import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:open_filex/open_filex.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';

class AppFileDownloaderProvider extends ChangeNotifier {
  bool _isDownloading = false;
  double? _progress;

  bool get isDownloading => _isDownloading;

  double? get progress => _progress;

  Future<void> downloadFile({
    required String url,
    required String fileName,
    VoidCallback? onCompleted,
    Function(String)? onError,
    bool autoOpen = true, // New parameter to control auto-opening
  }) async {
    _isDownloading = true;
    _progress = 0;
    notifyListeners();

    try {
      // Get app directory path (internal storage)
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final Directory fuodayDir = Directory(
        path.join(appDocDir.path, 'fuoday'),
      );

      // Create fuoday directory if it doesn't exist
      if (!await fuodayDir.exists()) {
        await fuodayDir.create(recursive: true);
      }

      FileDownloader.downloadFile(
        url: url,
        name: fileName,
        subPath: "fuoday",
        // Use subPath instead of destination
        onProgress: (fileName, progress) {
          _progress = progress;
          notifyListeners();
        },
        onDownloadCompleted: (filePath) async {
          _isDownloading = false;
          _progress = null;
          AppLoggerHelper.logInfo('Download completed: $filePath');
          notifyListeners();

          // Auto-open the file if enabled
          if (autoOpen && filePath.isNotEmpty) {
            try {
              final result = await OpenFilex.open(filePath);
              AppLoggerHelper.logInfo('File open result: ${result.message}');

              if (result.type != ResultType.done) {
                AppLoggerHelper.logWarning(
                  'Could not open file: ${result.message}',
                );
              }
            } catch (e) {
              AppLoggerHelper.logError('Error opening file: $e');
            }
          }

          if (onCompleted != null) onCompleted();
        },
        onDownloadError: (errorMessage) {
          _isDownloading = false;
          _progress = null;
          notifyListeners();
          if (onError != null) onError(errorMessage);
        },
      );
    } catch (e) {
      _isDownloading = false;
      _progress = null;
      notifyListeners();
      if (onError != null) onError(e.toString());
    }
  }
}
