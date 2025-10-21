import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';

// Action button configuration class
class ActionButton {
  final String icon;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final String? tooltip;
  final double? width;
  final double? height;

  ActionButton({
    required this.icon,
    required this.backgroundColor,
    required this.onPressed,
    this.tooltip,
    this.width,
    this.height,
  });
}

class KAtsDataTable extends StatelessWidget {
  final List<Widget> columnHeaders;
  final List<Map<String, dynamic>> rowData;
  final double minWidth;
  final Color headerColor;
  final List<ActionButton>? defaultActions; // Default actions for all rows
  final bool showActionsColumn; // Whether to show actions column
  final bool showStatusColumn; // Whether to show status column
  /// ✅ New feature: Custom width for each DataCell
  /// Example: [50.w, 200.w, 120.w, 160.w, 100.w, 160.w, 120.w, 150.w]
  final List<double>? columnWidths;

  const KAtsDataTable({
    super.key,
    required this.columnHeaders,
    required this.rowData,
    this.minWidth = 1000,
    this.headerColor = AppColors.atsHomepageBg,
    this.defaultActions,
    this.showActionsColumn = true,
    this.showStatusColumn = true,
    this.columnWidths, // default true
  });

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 1,
      horizontalMargin: 20,
      minWidth: minWidth,
      headingRowColor: MaterialStateProperty.all(headerColor),
      dataRowHeight: 60,

      columns: columnHeaders
          .map((headerWidget) => DataColumn(label: headerWidget))
          .toList(),

      rows: rowData.map((row) {
        return DataRow(
          cells: [
            // S.No
            DataCell(
              SizedBox(
                width: 50.w,
                child: Center(
                  child: KText(
                    text: row["sno"].toString(),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                ),
              ),
            ),

            // Name + Avatar + Email
            DataCell(
              SizedBox(
                width: 200.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (row["avatar"] != null)
                          Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              color: row["avatarColor"] ?? Colors.blue,
                              borderRadius: BorderRadius.circular(16.r),
                              image: row["avatarImage"] != null
                                  ? DecorationImage(
                                      image: NetworkImage(row["avatarImage"]),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                            child:
                                row["avatarImage"] == null &&
                                    row["initials"] != null
                                ? Center(
                                    child: KText(
                                      text: row["initials"],
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                        if (row["avatar"] != null) SizedBox(width: 16.w),

                        Flexible(
                          child: KText(
                            text: row["name"] ?? "-",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.titleColor,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    if (row["email"] != null &&
                        row["email"].toString().isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                          left: row["avatar"] != null ? 40.w : 0,
                        ),
                        child: KText(
                          text: row["email"],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Phone/Interview Date
            DataCell(
              SizedBox(
                width: 120.w,
                child: Center(
                  child: KText(
                    text: row["colum3"] ?? "-",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                ),
              ),
            ),

            // CV + Download/Attachment
            DataCell(
              SizedBox(
                width: 160.w,
                child:
                    (row["colum4"] != null &&
                        row["colum4"].toString().isNotEmpty)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: KText(
                              text: row["colum4"],
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.titleColor,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          // 🔥 Show icon only if explicitly enabled
                          if (row["showDownload"] == true)
                            Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: Icon(
                                Icons.download_outlined,
                                size: 16.sp,
                                color: AppColors.greyColor,
                              ),
                            ),
                        ],
                      )
                    : KText(
                        text: "-",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greyColor,
                      ),
              ),
            ),

            // Experience
            DataCell(
              SizedBox(
                width: 100.w,
                child: Center(
                  child: KText(
                    text: row["colum5"] ?? "-",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                ),
              ),
            ),

            // Role
            DataCell(
              SizedBox(
                width: 160.w,
                child: Center(
                  child: KText(
                    text: row["colum6"] ?? "-",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleColor,
                  ),
                ),
              ),
            ),

            // Status
            // Status (optional column)
            if (showStatusColumn)
              DataCell(
                Center(
                  child: SizedBox(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(row["colum7"]).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: KText(
                        text: row["colum7"] ?? "-",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: _getStatusColor(row["colum7"]),
                      ),
                    ),
                  ),
                ),
              ),
            // Action buttons - Now configurable
            if (showActionsColumn)
              DataCell(SizedBox(width: 150.w, child: _buildActionButtons(row))),
          ],
        );
      }).toList(),
    );
  }

  // Helper method to get status color
  Color _getStatusColor(String? status) {
    if (status == null) return AppColors.greyColor;

    switch (status.toLowerCase()) {
      case 'selected':
        return AppColors.checkInColor;
      case 'rejected':
        return AppColors.softRed;
      case 'on hold':
        return Colors.orange;
      case 'in progress':
        return Colors.blue;
      case 'hr round':
        return Colors.purple;
      default:
        if (status.contains('%')) {
          return Colors.amber;
        }
        return AppColors.checkInColor;
    }
  }

  // Build action buttons based on row data or default actions
  Widget _buildActionButtons(Map<String, dynamic> row) {
    List<ActionButton> actions = [];

    // Check if row has custom actions
    if (row["actions"] != null && row["actions"] is List<ActionButton>) {
      actions = row["actions"];
    } else if (defaultActions != null) {
      actions = defaultActions!;
    } else {
      // Default actions if none specified
      actions = [
        ActionButton(
          icon: AppAssetsConstants.eyeIcon,
          backgroundColor: AppColors.checkInColor,
          onPressed: () => _onViewPressed(row),
          tooltip: "View",
        ),
        ActionButton(
          icon: AppAssetsConstants.editIcon,
          backgroundColor: AppColors.primaryColor,
          onPressed: () => _onEditPressed(row),
          tooltip: "Edit",
        ),
        ActionButton(
          icon: AppAssetsConstants.deleteIcon,
          backgroundColor: AppColors.softRed,
          onPressed: () => _onDeletePressed(row),
          tooltip: "Delete",
        ),
      ];
    }

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: actions.map((action) {
          return Padding(
            padding: EdgeInsets.only(right: actions.last == action ? 0 : 8.w),
            child: Tooltip(
              message: action.tooltip ?? "",
              child: Container(
                width: action.width ?? 30.w,
                height: action.height ?? 30.h,
                decoration: BoxDecoration(
                  color: action.backgroundColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: IconButton(
                  onPressed: action.onPressed,
                  icon: SvgPicture.asset(
                    action.icon,
                    height: 13.h,
                    width: 11.67.w,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Default action handlers (can be overridden)
  void _onViewPressed(Map<String, dynamic> row) {
    print("View pressed for: ${row["name"]}");
  }

  void _onEditPressed(Map<String, dynamic> row) {
    print("Edit pressed for: ${row["name"]}");
  }

  void _onDeletePressed(Map<String, dynamic> row) {
    print("Delete pressed for: ${row["name"]}");
  }
}
