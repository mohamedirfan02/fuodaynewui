// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:fuoday/commons/widgets/k_text.dart';
// import 'package:fuoday/core/constants/app_assets_constants.dart';
// import 'package:fuoday/core/themes/app_colors.dart';
//
// class KAtsDataTable extends StatelessWidget {
//   final List<String> columnTitles;
//   final List<Map<String, dynamic>> rowData;
//   final double? headerHeight;
//   final Color? headerColor;
//   final EdgeInsets? headerPadding;
//   final double? rowSpacing;
//   final Function(int index, String action)? onAction; // Generic action handler
//
//   const KAtsDataTable({
//     super.key,
//     required this.columnTitles,
//     required this.rowData,
//     this.headerHeight,
//     this.headerColor,
//     this.headerPadding,
//     this.rowSpacing,
//     this.onAction,
//   });
//
//   /// Build header similar to ApplicantItem.buildHeader()
//   Widget _buildHeader() {
//     return Container(
//       padding: headerPadding ?? EdgeInsets.symmetric(horizontal: 25.w),
//       height: headerHeight ?? 56.h,
//       color: headerColor ?? AppColors.atsHomepageBg,
//       child: Row(
//         children: columnTitles.map((title) {
//           double width = _getColumnWidth(title);
//           return SizedBox(
//             width: width,
//             child: KText(
//               text: title,
//               fontWeight: FontWeight.w500,
//               fontSize: 12.sp,
//               color: AppColors.greyColor,
//               textAlign: _getTextAlign(title),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   /// Get column width based on column title
//   double _getColumnWidth(String columnTitle) {
//     switch (columnTitle.toLowerCase()) {
//       case 's.no':
//       case 'sno':
//         return 60.w;
//       case 'name':
//         return 200.w;
//       case 'phone':
//       case 'phone number':
//         return 100.w;
//       case 'cv':
//         return 100.w;
//       case 'created date':
//       case 'date':
//         return 120.w;
//       case 'stages':
//       case 'stage':
//         return 100.w;
//       case 'action':
//       case 'actions':
//         return 120.w;
//       default:
//         return 100.w; // Default width
//     }
//   }
//
//   /// Get text alignment based on column
//   TextAlign _getTextAlign(String columnTitle) {
//     switch (columnTitle.toLowerCase()) {
//       case 'name':
//         return TextAlign.start;
//       default:
//         return TextAlign.center;
//     }
//   }
//
//   /// Build individual row
//   Widget _buildRow(Map<String, dynamic> row, int index) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
//           child: Row(
//             children: columnTitles.map((columnTitle) {
//               double width = _getColumnWidth(columnTitle);
//               return SizedBox(
//                 width: width,
//                 child: _buildCell(columnTitle, row[columnTitle], row, index),
//               );
//             }).toList(),
//           ),
//         ),
//         SizedBox(height: rowSpacing ?? 10.h),
//         Divider(
//           thickness: 1,
//           color: AppColors.primaryColor.withOpacity(0.10),
//         ),
//       ],
//     );
//   }
//
//   /// Build individual cell based on column type
//   Widget _buildCell(String columnTitle, dynamic cellValue, Map<String, dynamic> row, int index) {
//     switch (columnTitle.toLowerCase()) {
//       case 's.no':
//       case 'sno':
//         return Center(
//           child: KText(
//             text: cellValue?.toString() ?? "-",
//             fontSize: 12.sp,
//             fontWeight: FontWeight.w400,
//             color: AppColors.titleColor,
//             textAlign: TextAlign.center,
//           ),
//         );
//
//       case 'name':
//         return _buildNameCell(row);
//
//       case 'phone':
//       case 'phone number':
//         return Center(
//           child: KText(
//             text: cellValue?.toString() ?? "-",
//             fontSize: 12.sp,
//             fontWeight: FontWeight.w400,
//             color: AppColors.titleColor,
//             textAlign: TextAlign.center,
//           ),
//         );
//
//       case 'cv':
//         return _buildCVCell(cellValue);
//
//       case 'created date':
//       case 'date':
//         return Center(
//           child: KText(
//             text: cellValue?.toString() ?? "-",
//             fontSize: 12.sp,
//             fontWeight: FontWeight.w400,
//             color: AppColors.titleColor,
//             textAlign: TextAlign.center,
//           ),
//         );
//
//       case 'stages':
//       case 'stage':
//         return _buildStageCell(cellValue, index);
//
//       case 'action':
//       case 'actions':
//         return _buildActionCell(index);
//
//       default:
//       // Handle custom widgets or default text
//         if (cellValue is Widget) {
//           return cellValue;
//         } else {
//           return Center(
//             child: KText(
//               text: cellValue?.toString() ?? "-",
//               fontSize: 12.sp,
//               fontWeight: FontWeight.w400,
//               color: AppColors.titleColor,
//               textAlign: TextAlign.center,
//             ),
//           );
//         }
//     }
//   }
//
//   /// Build name cell with avatar and email
//   Widget _buildNameCell(Map<String, dynamic> row) {
//     String name = row['name']?.toString() ?? '';
//     String email = row['email']?.toString() ?? '';
//     String? initials = row['initials']?.toString();
//     Color avatarColor = row['avatarColor'] ?? AppColors.primaryColor;
//     bool showInitials = row['showInitials'] ?? false;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               width: 24.w,
//               height: 24.w,
//               decoration: BoxDecoration(
//                 color: avatarColor,
//                 borderRadius: BorderRadius.circular(16.r),
//               ),
//               child: showInitials && initials != null
//                   ? Center(
//                 child: KText(
//                   text: initials,
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.white,
//                 ),
//               )
//                   : ClipRRect(
//                 borderRadius: BorderRadius.circular(16.r),
//                 child: Image.asset(
//                   AppAssetsConstants.personPlaceHolderImg,
//                 ),
//               ),
//             ),
//             SizedBox(width: 16.w),
//             Expanded(
//               child: KText(
//                 text: name,
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.titleColor,
//               ),
//             ),
//           ],
//         ),
//         if (email.isNotEmpty) ...[
//           SizedBox(height: 2.h),
//           Padding(
//             padding: EdgeInsets.only(left: 40.w),
//             child: KText(
//               text: email,
//               fontSize: 12.sp,
//               color: AppColors.greyColor,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ],
//       ],
//     );
//   }
//
//   /// Build CV cell with download icon
//   Widget _buildCVCell(dynamic cellValue) {
//     String cvText = cellValue?.toString() ?? '';
//
//     return Center(
//       child: (cvText.isNotEmpty && cvText != '-')
//           ? Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Flexible(
//             child: KText(
//               text: cvText,
//               fontSize: 12.sp,
//               color: AppColors.titleColor,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           SizedBox(width: 4.w),
//           Icon(
//             Icons.download_outlined,
//             size: 16.sp,
//             color: AppColors.greyColor,
//           ),
//         ],
//       )
//           : KText(
//         text: "-",
//         fontSize: 12.sp,
//         color: AppColors.greyColor,
//         fontWeight: FontWeight.w400,
//         textAlign: TextAlign.center,
//       ),
//     );
//   }
//
//   /// Build stage dropdown cell
//   Widget _buildStageCell(dynamic cellValue, int index) {
//     String? currentStage = cellValue?.toString();
//
//     return SizedBox(
//       width: 100.w,
//       child: DropdownButton<String>(
//         value: currentStage,
//         isExpanded: true,
//         underline: Container(),
//         hint: KText(
//           text: "Select Stage",
//           fontSize: 10.sp,
//           color: AppColors.greyColor,
//           fontWeight: FontWeight.w400,
//         ),
//         items: _availableStages.map((String stage) {
//           return DropdownMenuItem<String>(
//             value: stage,
//             child: KText(
//               text: stage,
//               fontSize: 10.sp,
//               fontWeight: FontWeight.w400,
//               color: AppColors.titleColor,
//             ),
//           );
//         }).toList(),
//         onChanged: (String? newStage) {
//           if (newStage != null) {
//             onAction?.call(index, 'stage_change:$newStage');
//           }
//         },
//       ),
//     );
//   }
//
//   /// Build action buttons cell
//   Widget _buildActionCell(int index) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // Edit button
//         Container(
//           width: 30.w,
//           height: 30.h,
//           decoration: BoxDecoration(
//             color: AppColors.primaryColor,
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: IconButton(
//             onPressed: () => onAction?.call(index, 'edit'),
//             icon: SvgPicture.asset(
//               AppAssetsConstants.editIcon,
//               height: 13.h,
//               width: 11.67.w,
//               fit: BoxFit.contain,
//               color: Colors.white,
//             ),
//             padding: EdgeInsets.zero,
//           ),
//         ),
//         SizedBox(width: 8.w),
//         // Delete button
//         Container(
//           width: 30.w,
//           height: 30.h,
//           decoration: BoxDecoration(
//             color: AppColors.softRed,
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: IconButton(
//             onPressed: () => onAction?.call(index, 'delete'),
//             icon: SvgPicture.asset(
//               AppAssetsConstants.deleteIcon,
//               height: 12.07.h,
//               width: 11.66.w,
//               fit: BoxFit.contain,
//               color: Colors.white,
//             ),
//             padding: EdgeInsets.zero,
//           ),
//         ),
//       ],
//     );
//   }
//
//   /// Available stages for dropdown
//   static const List<String> _availableStages = [
//     'Applied',
//     'Screening',
//     '1st Interview',
//     '2nd Interview',
//     'Hiring',
//     'Rejected',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Header
//         _buildHeader(),
//
//         // Rows
//         ...rowData.asMap().entries.map((entry) {
//           int index = entry.key;
//           Map<String, dynamic> row = entry.value;
//           return _buildRow(row, index);
//         }).toList(),
//       ],
//     );
//   }
// }