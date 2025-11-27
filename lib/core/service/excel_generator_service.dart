import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';

class ExcelGeneratorService {
  Future<File> generateAndSaveExcel({
    required List<Map<String, String>> data,
    required List<String> columns, // 👈 add this
    String sheetName = 'Attendance',
    String filename = 'attendance_report.xlsx',
  }) async {
    try {
      AppLoggerHelper.logInfo('📊 Starting Excel generation: $filename');

      final excel = Excel.createExcel();
      final Sheet sheet = excel[sheetName];

      // Write headers
      if (data.isNotEmpty) {
        sheet.appendRow(
          data.first.keys.map((key) => TextCellValue(key)).toList(),
        );
      }

      // Write data rows
      for (final row in data) {
        sheet.appendRow(
          row.values.map((value) => TextCellValue(value)).toList(),
        );
      }

      // Save to file
      final outputDir = await getTemporaryDirectory();
      final filePath = '${outputDir.path}/$filename';
      final file = File(filePath);

      final bytes = excel.save();
      if (bytes == null) {
        throw Exception('Excel.save() returned null');
      }

      file.writeAsBytesSync(bytes);
      AppLoggerHelper.logInfo('✅ Excel generated and saved to: $filePath');

      return file;
    } catch (e, stackTrace) {
      AppLoggerHelper.logError('❌ Excel generation failed: $e');
      rethrow;
    }
  }
}
