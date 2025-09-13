import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class KAtsDataTable extends StatelessWidget {
  final List<Widget> columnHeaders; // ✅ now accepts widgets
  final List<Map<String, dynamic>> rowData;
  final double minWidth;
  final Color headerColor;

  const KAtsDataTable({
    super.key,
    required this.columnHeaders,
    required this.rowData,
    this.minWidth = 1000,
    this.headerColor = AppColors.atsHomepageBg,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 1,
      horizontalMargin: 12,
      minWidth: minWidth,
      headingRowColor: MaterialStateProperty.all(headerColor),

      /// 👇 increase row height here
      dataRowHeight: 60,
      // maximum height
      /// ✅ Customizable headers
      columns: columnHeaders
          .map((headerWidget) => DataColumn(label: headerWidget))
          .toList(),

      /// ✅ Custom rows
      rows: rowData.map((row) {
        return DataRow(
          cells: [
            // S.No
            // Inside your KAtsDataTable build row:
            DataCell(
              SizedBox(
                width: 50.w, // ✅ fix width so no extra space
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
                        if (row["avatar"] != null) // show avatar if exists
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

                        // Name
                        Expanded(
                          child: KText(
                            text: row["name"] ?? "-",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.titleColor,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    // Email below, indented if avatar exists
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
                          //  overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // Phone
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

            // CV + Download
            DataCell(
              SizedBox(
                width: 160.w,

                child:
                    (row["colum4"] != null &&
                        row["colum4"].toString().isNotEmpty)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          KText(
                              text: row["colum4"],
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.titleColor,
                              //overflow: TextOverflow.ellipsis,
                          ),
                          Icon(
                            Icons.download_outlined,
                            size: 16.sp,
                            color: AppColors.greyColor,
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

            // Created Date
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

            // Stage Dropdown
            DataCell(
              SizedBox(
                width: 100.w,
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

            DataCell(
              Center(
                child: SizedBox(
                  child: Container(
                    color: Colors.green.withOpacity(0.1),
                    child: KText(
                      text: row["colum7"] ?? "-",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.checkInColor,
                    ),
                  ),
                ),
              ),
            ),

            // Action buttons
            DataCell(
              SizedBox(
                width: 110.w, // make sure this fits within your cell
                child: FittedBox(
                  // ensures content scales down if needed
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Edit button
                      Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: AppColors.checkInColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppAssetsConstants.eyeIcon,
                            height: 13.h,
                            width: 11.67.w,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Another action button
                      Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppAssetsConstants.editIcon,
                            height: 13.h,
                            width: 11.67.w,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Delete button
                      Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: AppColors.softRed,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppAssetsConstants.deleteIcon,
                            height: 12.07.h,
                            width: 11.66.w,
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
