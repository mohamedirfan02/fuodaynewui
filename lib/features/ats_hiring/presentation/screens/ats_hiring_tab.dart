import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_new_data_table.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/ats_candidate/widgets/k_ats_candidates_datatable.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class HiringTab extends StatefulWidget {
  const HiringTab({super.key});

  @override
  State<HiringTab> createState() => _HiringTabState();
}

class _HiringTabState extends State<HiringTab> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  // Sample data for candidates
  List<Map<String, dynamic>> applicantsData = [
    {
      'Name': 'Pristia Candra',
      'Job ID': '1001',
      'Contact': '89034 56787',
      'Role': 'Intern',
      'Stages': 'L1 Completed',
      'Feedback': 'Good communication, needs improvement in logic.',
      'Current CTC': '3.5 LPA',
      'Expected CTC': '5 LPA',
      'Action': 'View Profile',
    },
    {
      'Name': 'Rohit Sharma',
      'Job ID': '1002',
      'Contact': '79845 23412',
      'Role': 'Flutter Developer',
      'Stages': 'L2 Pending',
      'Feedback': 'Strong fundamentals and clean coding.',
      'Current CTC': '6 LPA',
      'Expected CTC': '8 LPA',
      'Action': 'View Profile',
    },
    {
      'Name': 'Jessica Martin',
      'Job ID': '1003',
      'Contact': '90341 12458',
      'Role': 'UI/UX Designer',
      'Stages': 'HR Done',
      'Feedback': 'Great creativity and prototyping flow.',
      'Current CTC': '5.2 LPA',
      'Expected CTC': '6.5 LPA',
      'Action': 'View Profile',
    },
    {
      'Name': 'Abdul Rahman',
      'Job ID': '1004',
      'Contact': '74586 90321',
      'Role': 'QA Tester',
      'Stages': 'L1 Completed',
      'Feedback': 'Needs more experience in automation.',
      'Current CTC': '4 LPA',
      'Expected CTC': '5.2 LPA',
      'Action': 'View Profile',
    },
    {
      'Name': 'Sofia Loren',
      'Job ID': '1005',
      'Contact': '81246 54789',
      'Role': 'Product Manager',
      'Stages': 'L2 Completed',
      'Feedback': 'Excellent leadership and planning.',
      'Current CTC': '14 LPA',
      'Expected CTC': '18 LPA',
      'Action': 'View Profile',
    },
    {
      'Name': 'Karthik Kumar',
      'Job ID': '1006',
      'Contact': '93421 90754',
      'Role': 'Backend Developer',
      'Stages': 'L1 Completed',
      'Feedback': 'Strong in Node.js and PostgreSQL.',
      'Current CTC': '7.5 LPA',
      'Expected CTC': '10 LPA',
      'Action': 'View Profile',
    },
    {
      'Name': 'Maria Isabel',
      'Job ID': '1007',
      'Contact': '67543 21098',
      'Role': 'Digital Marketer',
      'Stages': 'HR Pending',
      'Feedback': 'Expert in paid ads and strategy.',
      'Current CTC': '5 LPA',
      'Expected CTC': '7 LPA',
      'Action': 'View Profile',
    },
    {
      'Name': 'Daniel Scott',
      'Job ID': '1008',
      'Contact': '90812 45123',
      'Role': 'Data Analyst',
      'Stages': 'L2 Completed',
      'Feedback': 'Excellent analytical thinking and reporting.',
      'Current CTC': '9 LPA',
      'Expected CTC': '12 LPA',
      'Action': 'View Profile',
    },
    {
      'Name': 'Neha Verma',
      'Job ID': '1009',
      'Contact': '70234 44521',
      'Role': 'HR Executive',
      'Stages': 'HR Done',
      'Feedback': 'Good people handling and HR policies knowledge.',
      'Current CTC': '4.5 LPA',
      'Expected CTC': '6 LPA',
      'Action': 'View Profile',
    },
    {
      'Name': 'Michael Jordan',
      'Job ID': '1010',
      'Contact': '89012 55678',
      'Role': 'DevOps Engineer',
      'Stages': 'L2 Completed',
      'Feedback': 'Expert in CI/CD and AWS DevOps.',
      'Current CTC': '12 LPA',
      'Expected CTC': '16 LPA',
      'Action': 'View Profile',
    },
  ];
  late List<String> _selectedStages;
  final List<String> stageOptions = [
    'L2 Completed',
    'HR Done',
    'HR Pending',
    'L1 Completed',
    'L2 Pending',
  ];
  @override
  void initState() {
    super.initState();
    // Store stages with unique keys (using name+jobId as key)
    _selectedStages = applicantsData.map((e) => e['Stages'] as String).toList();
  }

  // Build DataGridRows from applicantsData
  // Build DataGridRows from applicantsData
  List<DataGridRow> _buildRows() => applicantsData.asMap().entries.map((entry) {
    int index = entry.key; // row index
    var data = entry.value;
    return DataGridRow(
      cells: [
        DataGridCell<int>(columnName: 'SNo', value: index + 1),
        DataGridCell<String>(columnName: 'Name', value: data['Name']),
        DataGridCell<String>(columnName: 'JobID', value: data['Job ID']),
        DataGridCell<String>(columnName: 'Contact', value: data['Contact']),
        DataGridCell<String>(columnName: 'Role', value: data['Role']),
        DataGridCell<String>(columnName: 'Stages', value: data['Stages']),
        DataGridCell<String>(columnName: 'Feedback', value: data['Feedback']),
        DataGridCell<String>(
          columnName: 'CurrentCTC',
          value: data['Current CTC'],
        ),
        DataGridCell<String>(
          columnName: 'ExpectedCTC',
          value: data['Expected CTC'],
        ),
        DataGridCell<String>(columnName: 'Action', value: data['Action']),
      ],
    );
  }).toList();

  //==================================================================
  // Columns
  // DataGrid Columns
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
      GridColumn(columnName: 'SNo', width: 70, label: header('S.No')),
      GridColumn(columnName: 'Name', width: 160, label: header('Name')),
      GridColumn(columnName: 'JobID', width: 120, label: header('Job ID')),
      GridColumn(columnName: 'Contact', width: 140, label: header('Contact')),
      GridColumn(columnName: 'Role', width: 130, label: header('Role')),
      GridColumn(columnName: 'Stages', width: 150, label: header('Stages')),
      GridColumn(columnName: 'Feedback', width: 200, label: header('Feedback')),
      GridColumn(
        columnName: 'CurrentCTC',
        width: 140,
        label: header('Current CTC'),
      ),
      GridColumn(
        columnName: 'ExpectedCTC',
        width: 140,
        label: header('Expected CTC'),
      ),
      GridColumn(columnName: 'Action', width: 130, label: header('Action')),
    ];
  }

  // Getter methods for pagination

  // Calculate display text for showing entries

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    //final hiveService = getIt<HiveStorageService>();
    //final employeeDetails = hiveService.employeeDetails;
    // final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    // final name = employeeDetails?['name'] ?? "No Name";
    // final email = employeeDetails?['email'] ?? "No Email";
    // final String currentRoute =
    //     AppRouteConstants.hiringScreen; // Replace with actual current route

    // Grid Attendance Data - Updated with dynamic counts
    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'icon': AppAssetsConstants.downloadIcon, // ✅ SVG path
        'title': 'CC & Banking ',
        'numberOfCount': "1512",
        //  'growth': "+5.1%",
      },
      {
        'title': 'Amazon',
        'numberOfCount': "825",
        //   'growth': "+5.1%",
        'icon': AppAssetsConstants.pecIcon, // ✅ SVG path
      },
      {
        'title': 'Trade India',
        'numberOfCount': "252",
        //  'growth': "+5.1%",
        'icon': AppAssetsConstants.pecIcon, // ✅ SVG path
      },
      {
        'title': 'Tech',
        'numberOfCount': "582",
        // 'growth': "+5.1%",
        'icon': AppAssetsConstants.pecIcon, // ✅ SVG path
      },
      // {
      //   'title': 'Flipkart',
      //   'numberOfCount': "1,504",
      //   // 'growth': "+5.1%",
      //   'icon': AppAssetsConstants.pecIcon, // ✅ SVG path
      // },
      // {
      //   'title': 'BD',
      //   'numberOfCount': "1,504",
      //   // 'growth': "+5.1%",
      //   'icon': AppAssetsConstants.pecIcon, // ✅ SVG path
      // },
    ];
    final rows = _buildRows();
    final columns = _buildColumns();
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: theme.cardColor, //ATS Background Color,
        child: Padding(
          padding: EdgeInsets.all(16.w),
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
                  // padding: EdgeInsets.all(18.47.w),
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
                          top: 11.h,
                          left: 18.47.w,
                          right: 18.46.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: KText(
                                text: "Hiring List",
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                //color: AppColors.titleColor,
                              ),
                            ),
                            Expanded(
                              child: KAtsGlowButton(
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
                            ),
                          ],
                        ),
                      ),
                      KVerticalSpacer(height: 16.h),

                      /// New Data Table
                      newData_table(
                        columns,
                        rows,
                        applicantsData,
                        _selectedStages,
                        stageOptions,
                        context,
                        (index, newStage) {
                          setState(() {
                            _selectedStages[index] = newStage;
                            applicantsData[index]['Stages'] = newStage;
                          });
                        },
                      ),
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
  List<String> selectedStages,
  List<String> stageOptions,
  BuildContext context,
  void Function(int index, String newStage) onStageChanged,
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

      //App Theme Data
      // final isDark = theme.brightness == Brightness.dark;
      // final atsPrimaryColor = Theme.of(context).colorScheme.primary;

      // Always use REAL API DATA
      if (actualDataIndex >= applicantsData.length) {
        return const SizedBox(); // prevents RangeError
      }
      final value = cell.value;

      ///Stages
      if (cell.columnName == 'Stages') {
        final status = selectedStages[actualDataIndex];

        // 🔹 Color mapping for container & text

        return Container(
          // height: 20.h,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            // color: bgColor, // 🔹 Container background color
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButton<String>(
            value: status,
            underline: const SizedBox.shrink(),
            isExpanded: true,
            dropdownColor: theme
                .secondaryHeaderColor, // 🔹 White background for dropdown menu
            iconEnabledColor: theme.textTheme.headlineLarge?.color?.withValues(
              alpha: 0.5,
            ), //AppColors.titleColor,, // 🔹  arrow icon
            selectedItemBuilder: (context) {
              // 🔹 This controls how the selected item appears in the container
              return stageOptions.map((stage) {
                return Center(
                  child: Text(
                    stage,
                    style: TextStyle(
                      //color: textColor, // 🔹 Colored text for selected item
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                );
              }).toList();
            },
            items: stageOptions.map((stage) {
              return DropdownMenuItem(
                value: stage,
                child: Text(
                  stage,
                  style: TextStyle(
                    color: theme
                        .textTheme
                        .headlineLarge
                        ?.color, // 🔹 Black text in dropdown items
                  ),
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                onStageChanged(actualDataIndex, val); // call the callback
              }
            },
          ),
        );
      }

      ///ATS Score

      /// Action Column
      if (cell.columnName == 'Action') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButtonWidget(
              color: AppColors.checkInColor.withValues(alpha: 0.8),
              icon: AppAssetsConstants.checkIcon,
              onTap: () {},
            ),
            SizedBox(width: 8.w),
            ActionButtonWidget(
              color: isDark
                  ? AppColors.checkOutColorDark
                  : AppColors.checkOutColor,
              icon: AppAssetsConstants.cancelIcon,
              onTap: () async {
                // Show confirmation dialog
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
