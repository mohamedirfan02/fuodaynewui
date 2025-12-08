import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_new_data_table.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/ats_candidate/presentation/provider/draft_provider.dart';
import 'package:fuoday/features/ats_candidate/widgets/k_ats_candidates_datatable.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DraftScreen extends StatefulWidget {
  const DraftScreen({super.key});

  @override
  State<DraftScreen> createState() => _DraftScreenState();
}

class _DraftScreenState extends State<DraftScreen> {
  late List<Map<String, dynamic>> _drafts;

  /// Columns to show
  final List<String> draftColumns = [
    "Candidate Name",
    "Date",
    "Job Title",
    "Job ID",
    "Mobile",
    "Email",
    "Present Organization",
    "Current Location",
    "Preferred Location",
    "Offer in Hand",
    "Last CTC",
    "Expected CTC",
    "Education Qualification",
    "Recruiter Name",
    "Disposition",
    "Interview Date",
    "Recruiter Score",
    "Feedback",
    "Total Experience",
    "Relevant Experience",
    "Organization Type",
    "Notice Period",
    "Acknowledgement",
    "Process",
    "Email Status",
    "Candidate Status",
    "DV By",
    "Interview Status",
  ];

  @override
  void initState() {
    super.initState();
    final draftProvider = context.read<DraftProvider>();
    _drafts = draftProvider.draftList;
  }

  List<DataGridRow> _buildRows() {
    return _drafts.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;

      final cells = <DataGridCell>[];
      cells.add(DataGridCell<int>(columnName: 'SNo', value: index + 1));
      for (var col in draftColumns) {
        final value =
            data[col] != null && data[col].toString().trim().isNotEmpty
            ? data[col].toString()
            : "-";
        cells.add(DataGridCell<String>(columnName: col, value: value));
      }

      // Action column
      cells.add(DataGridCell<String>(columnName: 'Action', value: 'Delete'));
      return DataGridRow(cells: cells);
    }).toList();
  }

  List<GridColumn> _buildColumns(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: theme.textTheme.bodyLarge?.color,
    );

    Widget header(String text) => Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(text, style: headerStyle),
    );

    List<GridColumn> columns = [];
    columns.add(
      GridColumn(columnName: 'SNo', width: 60, label: header('S.No')),
    );
    for (var col in draftColumns) {
      columns.add(GridColumn(columnName: col, width: 140, label: header(col)));
    }
    columns.add(
      GridColumn(columnName: 'Action', width: 100, label: header('Action')),
    );
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    final draftProvider = context.watch<DraftProvider>();
    _drafts = draftProvider.draftList;

    if (_drafts.isEmpty) {
      return const Scaffold(body: Center(child: Text("No draft available")));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Saved Drafts")),
      body: ReusableDataGrid(
        title: 'Draft Candidates',
        columns: _buildColumns(context),
        rows: _buildRows(),
        totalRows: _drafts.length,
        initialRowsPerPage: 5,
        cellBuilder: (cell, rowIndex, actualDataIndex) {
          final theme = Theme.of(context);
          final isDark = theme.brightness == Brightness.dark;

          // Safety check
          if (rowIndex >= _drafts.length) return Container();

          final rowData = _drafts[rowIndex];

          // Action column
          if (cell.columnName == 'Action') {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButtonWidget(
                  color: theme.primaryColor,
                  icon: AppAssetsConstants.editIcon,
                  onTap: () {
                    // Implement edit functionality
                  },
                ),
                SizedBox(width: 8.w),
                ActionButtonWidget(
                  color: isDark ? AppColors.softRedDark : AppColors.softRed,
                  icon: AppAssetsConstants.deleteIcon,
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Candidate'),
                        content: const Text('Are you sure you want to delete?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Delete by unique Job ID
                              draftProvider.deleteDraftById(rowData['Job ID']);
                              Navigator.pop(context, true);
                              setState(() {}); // Rebuild after deletion
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          }

          // Show value or "-"
          final value =
              cell.value != null && cell.value.toString().trim().isNotEmpty
              ? cell.value.toString()
              : "-";

          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(value, style: const TextStyle(fontSize: 12)),
          );
        },
      ),
    );
  }
}
