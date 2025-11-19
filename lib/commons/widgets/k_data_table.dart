import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class KDataTable extends StatelessWidget {
  final List<String> columnTitles;
  final List<Map<String, dynamic>> rowData;

  const KDataTable({
    super.key,
    required this.columnTitles,
    required this.rowData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return DataTable2(
      headingTextStyle: TextStyle(color: theme.textTheme.headlineLarge?.color),
      columnSpacing: 16,
      horizontalMargin: 12,
      minWidth: 1600,
      headingRowColor: WidgetStateProperty.all(
        isDark ? const Color(0xFF2A2D32) : Colors.blueGrey.shade50,
      ),
      columns: columnTitles
          .map(
            (title) => DataColumn(
              label: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
          .toList(),
      rows: rowData.map((row) {
        return DataRow(
          cells: columnTitles.map((col) {
            final cellValue = row[col];
            if (cellValue is Widget) {
              return DataCell(cellValue);
            } else {
              return DataCell(Text(cellValue?.toString() ?? '-'));
            }
          }).toList(),
        );
      }).toList(),
    );
  }
}
