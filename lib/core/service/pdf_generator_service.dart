import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';

class PdfGeneratorService {
  Future<File> generateAndSavePdf({
    required List<Map<String, String>> data,
    required List<String> columns, // 👈 add this
    String? title,
    String filename = 'attendance_report.pdf',
  }) async {
    try {
      AppLoggerHelper.logInfo('📄 Starting PDF generation: $filename');

      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(24),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (title != null)
                  pw.Text(
                    title,
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                pw.SizedBox(height: 12),

                // ✅ Fix: Use columns to order row values
                pw.Table.fromTextArray(
                  headers: columns,
                  data: data.map((row) =>
                      columns.map((col) => row[col] ?? "-").toList()).toList(),
                  cellStyle: pw.TextStyle(fontSize: 10),
                  headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  border: pw.TableBorder.all(),
                ),
              ],
            );
          },
        ),
      );

      final outputDir = await getTemporaryDirectory();
      final file = File('${outputDir.path}/$filename');
      await file.writeAsBytes(await pdf.save());

      AppLoggerHelper.logInfo('✅ PDF generated and saved to: ${file.path}');
      return file;
    } catch (e) {
      AppLoggerHelper.logError('❌ PDF generation failed: $e');
      rethrow;
    }
  }
}

