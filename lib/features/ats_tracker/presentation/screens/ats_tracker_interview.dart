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

class InterviewScreen extends StatefulWidget {
  const InterviewScreen({super.key});

  @override
  State<InterviewScreen> createState() => _InterviewScreenState();
}

class _InterviewScreenState extends State<InterviewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Sample data for candidates
  // ================= SAMPLE DATA ==================
  List<Map<String, dynamic>> applicantsData = [
    {
      'name': 'Pristia Candra',
      'jobId': '1001',
      'recruitmentId': 'R-501',
      'contact': '89034 56787',
      'Role': 'Bangalore',
      'role': 'Intern',
      'Interview Stage': '(L1 80%)',
      'Performance Scored': '90%',
      'atsScore': '89%',
      'feedback': 'I do not know how to spell a lot of things.',
      'action': 'View Profile',
    },
    {
      'name': 'Rohit Sharma',
      'jobId': '1002',
      'recruitmentId': 'R-502',
      'contact': '79845 23412',
      'Role': 'Hyderabad',
      'role': 'Flutter Developer',
      'Interview Stage': '(L2 70%)',
      'Performance Scored': '88%',
      'atsScore': '92%',
      'feedback': 'Strong fundamentals and fast learner.',
      'action': 'View Profile',
    },
    {
      'name': 'Jessica Martin',
      'jobId': '1003',
      'recruitmentId': 'R-503',
      'contact': '90341 12458',
      'Role': 'Chennai',
      'role': 'UI/UX Designer',
      'Interview Stage': '(HR Done)',
      'Performance Scored': '79%',
      'atsScore': '81%',
      'feedback': 'Creative approach to design problems.',
      'action': 'View Profile',
    },
    {
      'name': 'Abdul Rahman',
      'jobId': '1004',
      'recruitmentId': 'R-504',
      'contact': '74586 90321',
      'Role': 'Delhi',
      'role': 'QA Tester',
      'Interview Stage': '(L1 60%)',
      'Performance Scored': '74%',
      'atsScore': '76%',
      'feedback': 'Good but needs more automation knowledge.',
      'action': 'View Profile',
    },
    {
      'name': 'Sofia Loren',
      'jobId': '1005',
      'recruitmentId': 'R-505',
      'contact': '81246 54789',
      'Role': 'Pune',
      'role': 'Product Manager',
      'Interview Stage': '(L2 82%)',
      'Performance Scored': '91%',
      'atsScore': '94%',
      'feedback': 'Excellent leadership and communication.',
      'action': 'View Profile',
    },
    {
      'name': 'Karthik Kumar',
      'jobId': '1006',
      'recruitmentId': 'R-506',
      'contact': '93421 90754',
      'Role': 'Mumbai',
      'role': 'Backend Developer',
      'Interview Stage': '(L1 72%)',
      'Performance Scored': '83%',
      'atsScore': '87%',
      'feedback': 'Strong in Node.js & databases.',
      'action': 'View Profile',
    },
    {
      'name': 'Maria Isabel',
      'jobId': '1007',
      'recruitmentId': 'R-507',
      'contact': '67543 21098',
      'Role': 'Kolkata',
      'role': 'Digital Marketer',
      'Interview Stage': '(HR 100%)',
      'Performance Scored': '85%',
      'atsScore': '81%',
      'feedback': 'Excellent campaign strategy knowledge.',
      'action': 'View Profile',
    },
    {
      'name': 'Daniel Scott',
      'jobId': '1008',
      'recruitmentId': 'R-508',
      'contact': '90812 45123',
      'Role': 'Remote',
      'role': 'Data Analyst',
      'Interview Stage': '(L2 78%)',
      'Performance Scored': '89%',
      'atsScore': '90%',
      'feedback': 'Very strong analytical thinking.',
      'action': 'View Profile',
    },
    {
      'name': 'Neha Verma',
      'jobId': '1009',
      'recruitmentId': 'R-509',
      'contact': '70234 44521',
      'Role': 'Noida',
      'role': 'HR Executive',
      'Interview Stage': '(HR Done)',
      'Performance Scored': '82%',
      'atsScore': '80%',
      'feedback': 'Good HR knowledge and employee handling.',
      'action': 'View Profile',
    },
    {
      'name': 'Michael Jordan',
      'jobId': '1010',
      'recruitmentId': 'R-510',
      'contact': '89012 55678',
      'Role': 'Coimbatore',
      'role': 'DevOps Engineer',
      'Interview Stage': '(L2 85%)',
      'Performance Scored': '92%',
      'atsScore': '95%',
      'feedback': 'Expert in CI/CD and AWS.',
      'action': 'View Profile',
    },
  ];
  late List<String> _selectedStages;
  final List<String> stageOptions = [
    '(L1 60%)',
    '(L1 72%)',
    '(L1 80%)',
    '(L2 70%)',
    '(L2 82%)',
    '(L2 78%)',
    '(L2 85%)',
    '(HR Done)',
    '(HR 100%)',
  ];
  @override
  void initState() {
    super.initState();
    // Store stages with unique keys (using name+jobId as key)
    _selectedStages = applicantsData
        .map((e) => e['Interview Stage'] as String)
        .toList();
  }

  // =============== BUILD ROWS ===================
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
        DataGridCell<String>(columnName: 'Contact', value: data['contact']),
        DataGridCell<String>(columnName: 'Location', value: data['Role']),
        DataGridCell<String>(columnName: 'Role', value: data['role']),
        DataGridCell<String>(
          columnName: 'InterviewStage',
          value: data['Interview Stage'],
        ),
        DataGridCell<String>(
          columnName: 'PerformanceScore',
          value: data['Performance Scored'],
        ),
        DataGridCell<String>(columnName: 'ATSScore', value: data['atsScore']),
        DataGridCell<String>(columnName: 'Feedback', value: data['feedback']),
        DataGridCell<String>(columnName: 'Action', value: data['action']),
      ],
    );
  }).toList();

  // =============== BUILD COLUMNS ===================
  List<GridColumn> _buildColumns() {
    final theme = Theme.of(context);
    final headerStyle = TextStyle(
      fontWeight: FontWeight.normal,
      color: theme.textTheme.bodyLarge?.color,
    );

    Widget header(String title) => Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(title, style: headerStyle),
    );

    return [
      GridColumn(columnName: 'SNo', width: 60, label: header('S.No')),
      GridColumn(columnName: 'Name', width: 140, label: header('Name')),
      GridColumn(columnName: 'JobID', width: 100, label: header('Job ID')),
      GridColumn(
        columnName: 'RecruitmentID',
        width: 130,
        label: header('Recruitment ID'),
      ),
      GridColumn(columnName: 'Contact', width: 130, label: header('Contact')),
      GridColumn(columnName: 'Location', width: 130, label: header('Location')),
      GridColumn(columnName: 'Role', width: 160, label: header('Role')),
      GridColumn(
        columnName: 'InterviewStage',
        width: 150,
        label: header('Interview Stage'),
      ),
      GridColumn(
        columnName: 'PerformanceScore',
        width: 150,
        label: header('Performance Score'),
      ),
      GridColumn(
        columnName: 'ATSScore',
        width: 110,
        label: header('ATS Score'),
      ),
      GridColumn(columnName: 'Feedback', width: 160, label: header('Feedback')),
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
        'icon': AppAssetsConstants.personCardIcon, // ✅ SVG path
        'title': 'Interview  Today',
        'numberOfCount': "13,540",
        'growth': "+5.1%",
      },
      {
        'title': 'L1 Round',
        'numberOfCount': "708",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.webIcon, // ✅ SVG path
      },
      {
        'title': 'L2 Round',
        'numberOfCount': "958",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.cupIconIcon, // ✅ SVG path
      },
      {
        'title': 'Yet to be start',
        'numberOfCount': "1,504",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.addCardIcon, // ✅ SVG path
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
                                  text: "Interview List",
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

                            KVerticalSpacer(height: 16.h),
                          ],
                        ),
                      ),

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
                            applicantsData[index]['Interview Stage'] = newStage;
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
      if (cell.columnName == 'InterviewStage') {
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

/*
        /// Status Column
        */
