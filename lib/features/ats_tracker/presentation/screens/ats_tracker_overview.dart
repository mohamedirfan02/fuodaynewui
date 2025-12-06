import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_new_data_table.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/ats_candidate/widgets/k_ats_candidates_datatable.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AtsTrackerOverviewTab extends StatefulWidget {
  const AtsTrackerOverviewTab({super.key});

  @override
  State<AtsTrackerOverviewTab> createState() => _AtsTrackerOverviewTabState();
}

class _AtsTrackerOverviewTabState extends State<AtsTrackerOverviewTab> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  // Pagination state
  int currentPage = 1;
  int itemsPerPage = 6; // Change this to show how many items per page
  int pageWindowStart = 1; // first page in current window
  int pageWindowSize = 5; // show 5 numbers at a time

  // Sample data for candidates
  List<Map<String, dynamic>> applicantsData = [
    {
      'name': 'Pristia Candra',
      'jobId': '1001',
      'recruitmentId': 'R-501',
      'experience': '2 Years',
      'location': 'Bangalore',
      'role': 'Frontend Developer',
      'performanceScore': '92%',
      'feedback': 'Excellent',
      'atsScore': '89%',
      'action': 'View Profile',
    },
    {
      'name': 'Rahul Sharma',
      'jobId': '1002',
      'recruitmentId': 'R-502',
      'experience': '3 Years',
      'location': 'Chennai',
      'role': 'Backend Developer',
      'performanceScore': '85%',
      'feedback': 'Good',
      'atsScore': '82%',
      'action': 'View Profile',
    },
    {
      'name': 'Jennifer Wilson',
      'jobId': '1003',
      'recruitmentId': 'R-503',
      'experience': '4 Years',
      'location': 'Hyderabad',
      'role': 'UI/UX Designer',
      'performanceScore': '78%',
      'feedback': 'Average',
      'atsScore': '75%',
      'action': 'View Profile',
    },
    {
      'name': 'Mohammed Ali',
      'jobId': '1004',
      'recruitmentId': 'R-504',
      'experience': '5 Years',
      'location': 'Mumbai',
      'role': 'QA Engineer',
      'performanceScore': '88%',
      'feedback': 'Very Good',
      'atsScore': '84%',
      'action': 'View Profile',
    },
    {
      'name': 'Priya Singh',
      'jobId': '1005',
      'recruitmentId': 'R-505',
      'experience': '1 Year',
      'location': 'Delhi',
      'role': 'Business Analyst',
      'performanceScore': '72%',
      'feedback': 'Average',
      'atsScore': '70%',
      'action': 'View Profile',
    },
    {
      'name': 'John Carter',
      'jobId': '1006',
      'recruitmentId': 'R-506',
      'experience': '6 Years',
      'location': 'Pune',
      'role': 'Project Manager',
      'performanceScore': '94%',
      'feedback': 'Outstanding',
      'atsScore': '91%',
      'action': 'View Profile',
    },
    {
      'name': 'Ananya Roy',
      'jobId': '1007',
      'recruitmentId': 'R-507',
      'experience': '2 Years',
      'location': 'Kolkata',
      'role': 'HR Executive',
      'performanceScore': '80%',
      'feedback': 'Good',
      'atsScore': '76%',
      'action': 'View Profile',
    },
    {
      'name': 'Sanjay Kumar',
      'jobId': '1008',
      'recruitmentId': 'R-508',
      'experience': '3 Years',
      'location': 'Bangalore',
      'role': 'Security Analyst',
      'performanceScore': '86%',
      'feedback': 'Very Good',
      'atsScore': '83%',
      'action': 'View Profile',
    },
    {
      'name': 'Emma Davis',
      'jobId': '1009',
      'recruitmentId': 'R-509',
      'experience': '4 Years',
      'location': 'Chennai',
      'role': 'Content Writer',
      'performanceScore': '77%',
      'feedback': 'Average',
      'atsScore': '74%',
      'action': 'View Profile',
    },
    {
      'name': 'David Johnson',
      'jobId': '1010',
      'recruitmentId': 'R-510',
      'experience': '8 Years',
      'location': 'Hyderabad',
      'role': 'DevOps Engineer',
      'performanceScore': '90%',
      'feedback': 'Excellent',
      'atsScore': '88%',
      'action': 'View Profile',
    },
  ];

  // Build DataGridRows from applicantsData
  List<DataGridRow> _buildRows() => applicantsData.asMap().entries.map((entry) {
    int index = entry.key;
    var data = entry.value;

    return DataGridRow(
      cells: [
        DataGridCell<int>(columnName: 'SNo', value: index + 1),
        DataGridCell<String>(columnName: 'Name', value: data['name']),
        DataGridCell<String>(columnName: 'JobID', value: data['jobId']),
        DataGridCell<String>(
          columnName: 'RecruitmentID',
          value: data['recruitmentId'],
        ),
        DataGridCell<String>(
          columnName: 'Experience',
          value: data['experience'],
        ),
        DataGridCell<String>(columnName: 'Location', value: data['location']),
        DataGridCell<String>(columnName: 'Role', value: data['role']),
        DataGridCell<String>(
          columnName: 'PerformanceScore',
          value: data['performanceScore'],
        ),
        DataGridCell<String>(columnName: 'Feedback', value: data['feedback']),
        DataGridCell<String>(columnName: 'ATSScore', value: data['atsScore']),
        DataGridCell<String>(columnName: 'Action', value: data['action']),
      ],
    );
  }).toList();

  //==================================================================
  // Columns
  List<GridColumn> _buildColumns() {
    final theme = Theme.of(context);
    final headerStyle = TextStyle(
      fontWeight: FontWeight.normal,
      color: theme.textTheme.bodyLarge?.color,
    );

    Widget header(String text) => Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(text, style: headerStyle),
    );

    return [
      GridColumn(columnName: 'SNo', width: 60, label: header('S.No')),
      GridColumn(columnName: 'Name', width: 150, label: header('Name')),
      GridColumn(columnName: 'JobID', width: 100, label: header('Job ID')),
      GridColumn(
        columnName: 'RecruitmentID',
        width: 130,
        label: header('Recruitment ID'),
      ),
      GridColumn(
        columnName: 'Experience',
        width: 110,
        label: header('Experience'),
      ),
      GridColumn(columnName: 'Location', width: 120, label: header('Location')),
      GridColumn(columnName: 'Role', width: 150, label: header('Role')),
      GridColumn(
        columnName: 'PerformanceScore',
        width: 140,
        label: header('Performance Score'),
      ),
      GridColumn(columnName: 'Feedback', width: 120, label: header('Feedback')),
      GridColumn(
        columnName: 'ATSScore',
        width: 110,
        label: header('ATS Score'),
      ),
      GridColumn(columnName: 'Action', width: 140, label: header('Action')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // final hiveService = getIt<HiveStorageService>();
    // final employeeDetails = hiveService.employeeDetails;
    // final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    // final name = employeeDetails?['name'] ?? "No Name";
    // final email = employeeDetails?['email'] ?? "No Email";
    final String currentRoute =
        AppRouteConstants.atsTrackerScreen; // Replace with actual current route

    // Grid Attendance Data - Updated with dynamic counts
    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'icon': AppAssetsConstants.singleNoteIcon, // ✅ SVG path
        'title': 'Total Number Resume',
        'numberOfCount': "135",
        'growth': "+5.1%",
      },
      {
        'title': 'Above 80% Score',
        'numberOfCount': "708",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.pecIcon, // ✅ SVG path
      },
      {
        'title': '50% - 80% Score',
        'numberOfCount': "958",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.pecIcon, // ✅ SVG path
      },
      {
        'title': '40% Score',
        'numberOfCount': "1,504",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.pecIcon, // ✅ SVG path
      },
    ];
    final rows = _buildRows();
    final columns = _buildColumns();
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: theme.cardColor, //ATS Background Color
        child: Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: AppResponsive.responsiveCrossAxisCount(
                      context,
                    ),
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 155 / 113,
                  ),
                  itemCount: gridAttendanceData.length,
                  itemBuilder: (context, index) {
                    final item = gridAttendanceData[index];
                    return AtsTotalCountCard(
                      employeeCount: item['numberOfCount'].toString(),
                      employeeCardIcon: item['icon'],
                      employeeDescription: item['title'],
                      employeeIconColor: theme.primaryColor,
                      employeePercentageColor: isDark
                          ? AppColors.checkInColorDark
                          : AppColors.checkInColor,
                      growthText: item['growth'],
                    );
                  },
                ),
                SizedBox(height: 14.h),
                Container(
                  //padding: EdgeInsets.all(18.47.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.77.w,
                      color:
                          theme.textTheme.bodyLarge?.color?.withValues(
                            alpha: 0.3,
                          ) ??
                          AppColors.greyColor.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(7.69.r),
                    color: theme.secondaryHeaderColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Header
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.h,
                          left: 18.47.w,
                          right: 18.47.w,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                KText(
                                  text: "Candidate ATS List",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  // color: AppColors.titleColor,
                                ),
                                KAtsGlowButton(
                                  width: 110,
                                  text: "Filter",
                                  textColor:
                                      theme.textTheme.bodyLarge?.color ??
                                      AppColors.greyColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  icon: Icon(
                                    Icons.filter_alt_outlined,
                                    size: 20,
                                    color:
                                        theme.textTheme.bodyLarge?.color ??
                                        AppColors.greyColor,
                                  ),
                                  onPressed: () {
                                    print("Filter button tapped");
                                  },
                                  backgroundColor: theme.secondaryHeaderColor,
                                ),
                              ],
                            ),
                            // KVerticalSpacer(height: 16.h),
                            //
                            // // Date and Export Row
                            // Row(
                            //   spacing: 20.w,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     // Filter Button
                            //     Expanded(
                            //       child: KAtsGlowButton(
                            //         text: "Filter",
                            //         textColor:
                            //             theme.textTheme.bodyLarge?.color ??
                            //             AppColors.greyColor,
                            //         fontWeight: FontWeight.w600,
                            //         fontSize: 14,
                            //         icon: SvgPicture.asset(
                            //           AppAssetsConstants.filterIcon,
                            //           height: 15,
                            //           width: 15,
                            //           fit: BoxFit.contain,
                            //           //SVG IMAGE COLOR
                            //           colorFilter: ColorFilter.mode(
                            //             theme.textTheme.headlineLarge?.color ??
                            //                 Colors.black,
                            //             BlendMode.srcIn,
                            //           ),
                            //         ),
                            //         onPressed: () {
                            //           print("Filter button tapped");
                            //         },
                            //         backgroundColor: theme.secondaryHeaderColor,
                            //       ),
                            //     ),
                            //
                            //     // Export file
                            //     Expanded(
                            //       child: KAtsGlowButton(
                            //         text: "Interview",
                            //         fontWeight: FontWeight.w600,
                            //         fontSize: 13,
                            //         textColor: theme.secondaryHeaderColor,
                            //         icon: SvgPicture.asset(
                            //           AppAssetsConstants.addIcon,
                            //           height: 15,
                            //           width: 15,
                            //           fit: BoxFit.contain,
                            //           //SVG IMAGE COLOR
                            //           colorFilter: ColorFilter.mode(
                            //             theme.secondaryHeaderColor,
                            //             BlendMode.srcIn,
                            //           ),
                            //         ),
                            //         onPressed: () {
                            //           print("Candidates button tapped");
                            //         },
                            //         backgroundColor: theme.primaryColor,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            KVerticalSpacer(height: 16.h),
                          ],
                        ),
                      ),

                      /// New Data Table
                      newData_table(columns, rows, applicantsData, context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Data Table Widget
ReusableDataGrid newData_table(
  List<GridColumn> columns,
  List<DataGridRow> rows,
  List<Map<String, dynamic>> applicantsData,
  BuildContext context,
) {
  return ReusableDataGrid(
    title: 'Applicants',
    columns: columns,
    rows: rows,
    allowSorting: false,
    totalRows: rows.length,
    initialRowsPerPage: 5,
    cellBuilder: (cell, rowIndex, actualDataIndex) {
      //App Theme Data
      final theme = Theme.of(context);
      final isDark = theme.brightness == Brightness.dark;
      final atsPrimaryColor = Theme.of(context).colorScheme.primary;

      // Always use REAL API DATA
      if (actualDataIndex >= applicantsData.length) {
        return const SizedBox(); // prevents RangeError
      }
      final value = cell.value;

      ///Performance Score
      if (cell.columnName == 'PerformanceScore') {
        final status = cell.value.toString(); // ⬅️ take current row value
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            // width: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.checkInColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.checkInColor,
                ),
              ),
            ),
          ),
        );
      }

      ///ATS Score
      if (cell.columnName == 'ATSScore') {
        final status = cell.value.toString(); // ⬅️ take current row value
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            // width: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.checkInColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.checkInColor,
                ),
              ),
            ),
          ),
        );
      }

      /// Action Column
      if (cell.columnName == 'Action') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButtonWidget(
              color: AppColors.checkInColor.withValues(alpha: 0.8),
              icon: AppAssetsConstants.eyeIcon,
              onTap: () {},
            ),
            SizedBox(width: 8.w),
            ActionButtonWidget(
              color: atsPrimaryColor,
              icon: AppAssetsConstants.editIcon,
              onTap: () async {
                // if (confirm != true) return;

                //  final provider = context.read<CandidateActionProvider>();

                // Show loading
                // if (context.mounted) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text("Deleting candidate..."),
                //       duration: Duration(seconds: 1),
                //     ),
                //   );
                // }
              },
            ),
          ],
        );
      }

      /// Default Cell
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Text(value.toString(), style: TextStyle(fontSize: 12)),
      );
    },
  );
}

/*
        /// Status Column
        */
