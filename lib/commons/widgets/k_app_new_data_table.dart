import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'k_text.dart';

import 'package:syncfusion_flutter_core/theme.dart'; // 🔹 Add this import

class ReusableDataGrid extends StatefulWidget {
  final List<GridColumn> columns;
  final List<DataGridRow> rows;
  final int totalRows;
  final int initialRowsPerPage;
  final String title;
  final Widget Function(DataGridCell cell, int rowIndex, int actualDataIndex)?
  cellBuilder;
  final bool allowSorting; // 🔹 New parameter
  final Color? selectionColor; // 🔹 New parameterS

  const ReusableDataGrid({
    super.key,
    required this.columns,
    required this.rows,
    required this.totalRows,
    this.initialRowsPerPage = 8,
    this.title = "",
    this.cellBuilder,
    this.allowSorting = false, // 🔹 Enable sorting by default
    this.selectionColor, // 🔹 Optional custom selection color
  });

  @override
  State<ReusableDataGrid> createState() => _ReusableDataGridState();
}

class _ReusableDataGridState extends State<ReusableDataGrid> {
  late GenericDataSource _dataSource;
  final DataPagerController _pagerController = DataPagerController();
  late int _rowsPerPage;

  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.initialRowsPerPage;
    _dataSource = GenericDataSource(
      rows: widget.rows,
      rowsPerPage: _rowsPerPage,
      cellBuilder: widget.cellBuilder,
      selectionColor: widget.selectionColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    final pageCount = (_rowsPerPage >= widget.totalRows)
        ? 1
        : (widget.totalRows / _rowsPerPage).ceil();

    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text(
        //     widget.title,
        //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        //   ),
        // ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
          ),
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              gridLineColor: theme.textTheme.bodyLarge?.color?.withValues(
                alpha: 0.15,
              ),

              // headerColor: isDark ? AppColors.greyColor : Colors.white,
              selectionColor:
                  // widget.selectionColor ??
                  theme.primaryColor.withValues(
                    alpha: 0.15,
                  ), // 🔹 Selection color
              currentCellStyle: DataGridCurrentCellStyle(
                // borderColor: widget.selectionColor ?? AppColors.primaryColor,
                borderColor: theme.primaryColor,
                borderWidth: 2,
              ),
            ),
            child: SfDataGrid(
              source: _dataSource,
              showHorizontalScrollbar: true,
              showVerticalScrollbar: false,
              verticalScrollPhysics: const NeverScrollableScrollPhysics(),
              horizontalScrollPhysics: const AlwaysScrollableScrollPhysics(),
              gridLinesVisibility: GridLinesVisibility.horizontal,
              headerGridLinesVisibility: GridLinesVisibility.horizontal,
              columnWidthMode: ColumnWidthMode.auto,
              allowColumnsResizing: true,
              columnResizeMode: ColumnResizeMode.onResize,
              highlightRowOnHover: true,
              navigationMode: GridNavigationMode.cell,
              selectionMode: SelectionMode.single,
              shrinkWrapRows: true,
              rowsPerPage: _rowsPerPage,
              columns: widget.columns,
              allowSorting: widget.allowSorting,
              allowMultiColumnSorting: false, // Single column sorting
              allowTriStateSorting:
                  true, // Allows: ascending → descending → none
              sortingGestureType: SortingGestureType.tap,
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       if (pageCount > 1)
        //         SfDataPager(
        //           lastPageItemVisible: false,
        //           firstPageItemVisible: false,
        //           delegate: _dataSource,
        //           controller: _pagerController,
        //           visibleItemsCount: 5,
        //           pageCount: pageCount.toDouble(),
        //           onPageNavigationStart: (int pageIndex) {
        //             setState(() {});
        //           },
        //         ),
        //     ],
        //   ),
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pageCount > 1)
              SfDataPager(
                lastPageItemVisible: false,
                firstPageItemVisible: false,
                delegate: _dataSource,
                controller: _pagerController,
                visibleItemsCount: 3,
                pageCount: pageCount.toDouble(),
                onPageNavigationStart: (int pageIndex) {
                  setState(() {});
                },
                onPageNavigationEnd: (int pageIndex) {
                  setState(() {});
                },
                pageItemBuilder: (String pageNumber) {
                  // Handle navigation items (Previous, Next, etc.)
                  final pageIndex = int.tryParse(pageNumber);
                  if (pageIndex == null) {
                    return null;
                  }

                  // Both pageIndex and selectedPageIndex are 0-based, so direct comparison
                  final isSelected =
                      _pagerController.selectedPageIndex == pageIndex;

                  return ClipRRect(
                    borderRadius: BorderRadius.zero,
                    child: Material(
                      //shadowColor: Colors.red,

                      // Make the internal material fully transparent and non-rounded
                      // color: theme.primaryColor.withValues(
                      //   alpha: 0.9,
                      // ), //Colors.transparent, //
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        alignment: Alignment.center,
                        // your custom decoration controls only what's visible
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.textTheme.bodyLarge?.color?.withValues(
                                  alpha: 0.1,
                                )
                              : theme
                                    .secondaryHeaderColor, //AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(
                            5,
                          ), // ensure rectangle
                          // add border if you want: border: Border.all(...)
                        ),
                        child: Text(
                          (pageIndex + 1).toString(),
                          style: TextStyle(
                            color: theme
                                .textTheme
                                .headlineLarge
                                ?.color, //AppColors.titleColor,,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 16.h, left: 18.47.w, right: 18.47.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KText(
                text:
                    'Showing ${_pagerController.selectedPageIndex * _rowsPerPage + 1} to ${(_pagerController.selectedPageIndex + 1) * _rowsPerPage} of ${widget.totalRows} entries',
                fontSize: 12
                    .sp, // responsive font......MediaQuery.of(context).size.width * 0.03
                color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
                fontWeight: FontWeight.w500,
              ),
              GestureDetector(
                onTap: () => _showRowsPerPageBottomSheet(context),
                child: Container(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.02,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.8,
                      color:
                          theme.textTheme.bodyLarge?.color ??
                          AppColors.greyColor.withValues(alpha: 0.1),
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color:
                        theme.secondaryHeaderColor, //AppColors.secondaryColor
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      KText(
                        text: _rowsPerPage >= widget.totalRows
                            ? 'Show All'
                            : 'Show $_rowsPerPage',
                        fontSize: 10.sp,
                        // color: AppColors.titleColor,
                        fontWeight: FontWeight.w500,
                      ),
                      //const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 15.h,
                        color: theme
                            .textTheme
                            .headlineLarge
                            ?.color, //AppColors.titleColor,,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showRowsPerPageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final options = [5, 8, 10, 15, widget.totalRows];

        return StatefulBuilder(
          builder: (context, setModalState) {
            //App Theme Data
            final theme = Theme.of(context);
            // final isDark = theme.brightness == Brightness.dark;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ===== Top handle =====
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 50,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
                // ===== Title =====
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Rows per page",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                // ===== Options =====
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final item = options[index];
                    final isSelected =
                        _rowsPerPage == item ||
                        (_rowsPerPage >= widget.totalRows &&
                            item == widget.totalRows);

                    final displayText = item >= widget.totalRows
                        ? 'Show All (${widget.totalRows} items)'
                        : 'Show $item items';

                    return ListTile(
                      title: Text(displayText),
                      trailing: isSelected
                          ? Icon(Icons.check, color: theme.primaryColor)
                          : null,
                      onTap: () {
                        Navigator.pop(ctx);
                        setState(() {
                          _rowsPerPage = item;
                          _dataSource.updateRowsPerPage(
                            _rowsPerPage,
                            showAll: item >= widget.totalRows,
                          );
                          _pagerController.selectedPageIndex = 0;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        );
      },
    );
  }
}

//==============================================================
// GenericDataSource supporting optional cellBuilder
//==============================================================

class GenericDataSource extends DataGridSource {
  int _rowsPerPage;
  final List<DataGridRow> _allRows;
  List<DataGridRow> _paginatedRows = [];
  final Widget Function(DataGridCell cell, int rowIndex, int actualDataIndex)?
  cellBuilder;
  final Color? selectionColor;
  int _currentPageIndex = 0;

  GenericDataSource({
    required List<DataGridRow> rows,
    required int rowsPerPage,
    this.cellBuilder,
    this.selectionColor, // 🔹 Accept custom selection color
  }) : _allRows = rows,
       _rowsPerPage = rowsPerPage {
    _updatePaginatedRows(0);
  }

  void _updatePaginatedRows(int pageIndex) {
    _currentPageIndex = pageIndex;
    if (_rowsPerPage >= _allRows.length) {
      _paginatedRows = List.from(_allRows);
    } else {
      final startIndex = pageIndex * _rowsPerPage;
      final endIndex = (startIndex + _rowsPerPage > _allRows.length)
          ? _allRows.length
          : startIndex + _rowsPerPage;
      _paginatedRows = _allRows.getRange(startIndex, endIndex).toList();
    }
  }

  void updateRowsPerPage(int newRowsPerPage, {bool showAll = false}) {
    _rowsPerPage = newRowsPerPage;
    if (showAll) {
      _paginatedRows = List.from(_allRows);
    } else {
      _updatePaginatedRows(0);
    }
    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => _paginatedRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    //App Theme Data

    final rowIndex = _paginatedRows.indexOf(row);
    final actualDataIndex = (_currentPageIndex * _rowsPerPage) + rowIndex;
    return DataGridRowAdapter(
      color: Colors.transparent,
      //selectedColor: selectionColor ?? AppColors.primaryColor.withOpacity(0.15),
      cells: row.getCells().map((cell) {
        if (cellBuilder != null) {
          return cellBuilder!(cell, rowIndex, actualDataIndex);
        }
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Text(cell.value.toString(), overflow: TextOverflow.ellipsis),
        );
      }).toList(),
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    _updatePaginatedRows(newPageIndex);
    notifyListeners();
    return true;
  }
}
