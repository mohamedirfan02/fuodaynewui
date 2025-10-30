import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:fuoday/core/helper/app_logger_helper.dart';

/// A reusable PDF generation service for any table-based data.
/// Works on Android, iOS, and Web (with optional web download).
class PdfGeneratorServiceReusableWidget {
  /// Generates a table-style PDF report and saves it locally.
  ///
  /// - [data] : List of maps, each representing a table row.
  /// - [columns] : The table column names.
  /// - [title] : Optional document title.
  /// - [filename] : Output file name (default: 'report.pdf')
  /// - [landscape] : Use landscape orientation (default: true).
  /// - [addFooterInfo] : Whether to add page numbers and generated date.
  /// - [adjustColumnWidth] : Auto-adjust column widths (default: true).
  Future<File> generateAndSavePdf({
    required List<Map<String, String>> data,
    required List<String> columns,
    String? title,
    String filename = 'report.pdf',
    bool landscape = true,
    bool addFooterInfo = true,
    bool adjustColumnWidth = true,
  }) async {
    try {
      AppLoggerHelper.logInfo('📄 Starting PDF generation: $filename');

      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat:
          landscape ? PdfPageFormat.a4.landscape : PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          footer: addFooterInfo
              ? (context) => _buildFooter(context, data.length)
              : null,
          build: (context) => [
            if (title != null) _buildTitle(title),
            if (data.isEmpty)
              _buildEmptyState()
            else
              _buildTable(columns, data, adjustColumnWidth),
          ],
        ),
      );

      return await _saveForMobile(pdf, filename);
    } catch (e) {
      AppLoggerHelper.logError('❌ PDF generation failed: $e');
      rethrow;
    }
  }

  /// 📑 Title section
  pw.Widget _buildTitle(String title) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Text(
        title,
        style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  /// 📭 Empty state
  pw.Widget _buildEmptyState() {
    return pw.Center(
      child: pw.Text(
        'No records available',
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.grey700,
        ),
      ),
    );
  }

  /// 🧾 Table builder with optional column adjustment
  pw.Widget _buildTable(
      List<String> columns, List<Map<String, String>> data, bool adjust) {
    // ✅ Determine column widths based on flag
    final Map<int, pw.TableColumnWidth> columnWidths = adjust
        ? {
      for (var col in columns)
        columns.indexOf(col): pw.FlexColumnWidth(
          col.toLowerCase().contains('email')
              ? 3
              : col.toLowerCase().contains('name')
              ? 2
              : 1.5,
        ),
    }
        : {
      for (var col in columns)
        columns.indexOf(col): const pw.FlexColumnWidth(1),
    };

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey400),
      columnWidths: columnWidths,
      children: [
        // Header
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey300),
          children: columns.map((col) {
            return pw.Padding(
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
        // Rows
        ...data.map((row) {
          return pw.TableRow(
            children: columns.map((col) {
              return pw.Padding(
                padding: const pw.EdgeInsets.all(6),
                child: pw.Text(
                  row[col] ?? '-',
                  style: const pw.TextStyle(fontSize: 9),
                  textAlign: col.toLowerCase().contains('no')
                      ? pw.TextAlign.center
                      : pw.TextAlign.left,
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  /// 📆 Footer with total and page number
  pw.Widget _buildFooter(pw.Context context, int totalRecords) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 10),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Total Records: $totalRecords',
            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}   |   Generated: '
                '${DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.now())}',
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
          ),
        ],
      ),
    );
  }

  /// 💾 Save locally (Android/iOS)
  Future<File> _saveForMobile(pw.Document pdf, String filename) async {
    final outputDir = await getTemporaryDirectory();
    final file = File('${outputDir.path}/$filename');
    await file.writeAsBytes(await pdf.save());
    AppLoggerHelper.logInfo('✅ PDF saved at: ${file.path}');
    return file;
  }
}
