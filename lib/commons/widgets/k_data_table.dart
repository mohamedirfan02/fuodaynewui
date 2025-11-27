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
      columnSpacing: 5, // Reduced from 16 to minimize space between columns
      horizontalMargin: 12,
      minWidth: 1000, // Reduced from 1600 to fit better
      headingRowColor: WidgetStateProperty.all(
        isDark ? theme.secondaryHeaderColor : Colors.blueGrey.shade50,
      ),
      columns: columnTitles
          .map(
            (title) => DataColumn2(
              label: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              size: ColumnSize.S, // Auto-size columns to content
            ),
          )
          .toList(),
      rows: rowData.map((row) {
        // Fixed the typo here
        return DataRow(
          cells: columnTitles.map((col) {
            final cellValue = row[col];
            if (cellValue is Widget) {
              return DataCell(cellValue);
            } else {
              return DataCell(
                Text(
                  cellValue?.toString() ?? '-',
                  overflow: TextOverflow.ellipsis, // Handle long text
                ),
              );
            }
          }).toList(),
        );
      }).toList(),
    );
  }
}
