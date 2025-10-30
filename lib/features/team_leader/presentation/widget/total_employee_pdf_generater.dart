import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';

class TotalEmpPdfGeneratorService {
  Future<File> generateAndSavePdf({
    required List<Map<String, String>> data,
    required List<String> columns,
    String? title,
    String filename = 'attendance_report.pdf',
  }) async {
    try {
      AppLoggerHelper.logInfo('📄 Starting PDF generation: $filename');

      final pdf = pw.Document();

      // ✅ Use landscape orientation for wider tables
      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4.landscape,
          margin: const pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return [
              // Title
              if (title != null)
                pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 20),
                  child: pw.Text(
                    title,
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

              // Table with proper column widths
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey400),
                columnWidths: {
                  0: const pw.FixedColumnWidth(40), // S.No
                  1: const pw.FlexColumnWidth(1.5), // Employee Id
                  2: const pw.FlexColumnWidth(2), // Name
                  3: const pw.FlexColumnWidth(3), // Email
                  4: const pw.FlexColumnWidth(1.5), // Role
                },
                children: [
                  // Header row
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
                    children: columns.map((col) {
                      return pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          col,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 10,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),

                  // Data rows
                  ...data.map((row) {
                    return pw.TableRow(
                      children: columns.map((col) {
                        return pw.Container(
                          padding: const pw.EdgeInsets.all(6),
                          child: pw.Text(
                            row[col] ?? '-',
                            style: const pw.TextStyle(fontSize: 9),
                            textAlign: col == 'S.No'
                                ? pw.TextAlign.center
                                : pw.TextAlign.left,
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ],
              ),

              // Footer with record count
              pw.SizedBox(height: 20),
              pw.Text(
                'Total Records: ${data.length}',
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ];
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

/*Key Changes Made:

Landscape Orientation 📄

Changed from pw.Page to pw.MultiPage with PdfPageFormat.a4.landscape
This gives more horizontal space for the email column


Custom Column Widths 📏

Set specific widths for each column to prevent truncation
Email column gets the most space (FlexColumnWidth: 3)
S.No gets fixed width (40 points)


Manual Table Building 🔧

Replaced Table.fromTextArray() with manual pw.Table()
This gives better control over styling and layout


Better Styling 🎨

Header row with grey background
Proper padding for readability
Center-aligned S.No, left-aligned other columns


MultiPage Support 📑

If data exceeds one page, it automatically flows to the next page



If you still have issues, the problem might be in how you're calling the function. Make sure in your screen file (line 166-178) you're passing the data correctly:*/
