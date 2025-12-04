import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_new_data_table.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class YesterdayCallTab extends StatefulWidget {
  const YesterdayCallTab({super.key});

  @override
  State<YesterdayCallTab> createState() => _YesterdayCallTabState();
}

class _YesterdayCallTabState extends State<YesterdayCallTab> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  // Pagination state
  int currentPage = 1;
  int itemsPerPage = 6; // Change this to show how many items per page
  int pageWindowStart = 1; // first page in current window
  int pageWindowSize = 5; // show 5 numbers at a time

  // Sample data for candidates
  final List<Map<String, dynamic>> sampleData = [
    {
      "name": "Aarav Sharma",
      "jobId": "1001",
      "Designation": "Flutter Developer",
      "contact": "8903450998",
      "email": "aravsharma@example.com",
      "status": "Selected",
      "date": "07/10/2025",
      "createAt": "12/09/2025",
    },
    {
      "name": "Priya Verma",
      "jobId": "1002",
      "Designation": "Backend Developer",
      "contact": "9834512765",
      "email": "riyaverma@example.com",
      "status": "Holding",
      "date": "08/10/2025",
      "createAt": "13/09/2025",
    },
    {
      "name": "Rohan Gupta",
      "jobId": "1003",
      "Designation": "UI/UX Designer",
      "contact": "9876543210",
      "email": "ohangupta@example.com",
      "status": "Rejected",
      "date": "09/10/2025",
      "createAt": "14/09/2025",
    },
    {
      "name": "Neha Singh",
      "jobId": "1004",
      "Designation": "Full Stack Developer",
      "contact": "9123456780",
      "email": "nehasingh@example.com",
      "status": "Selected",
      "date": "10/10/2025",
      "createAt": "15/09/2025",
    },
    {
      "name": "Arjun Mehta",
      "jobId": "1005",
      "Designation": "QA Engineer",
      "contact": "9988776655",
      "email": "rjunmehta@example.com",
      "status": "Holding",
      "date": "11/10/2025",
      "createAt": "16/09/2025",
    },
    {
      "name": "Simran Kaur",
      "jobId": "1006",
      "Designation": "Project Manager",
      "contact": "9090909090",
      "email": "imrankaur@example.com",
      "status": "Rejected",
      "date": "12/10/2025",
      "createAt": "17/09/2025",
    },
    {
      "name": "Vikram Rao",
      "jobId": "1007",
      "Designation": "Data Analyst",
      "contact": "9797979797",
      "email": "ikramrao@example.com",
      "status": "Selected",
      "date": "13/10/2025",
      "createAt": "18/09/2025",
    },
    {
      "name": "Ananya Nair",
      "jobId": "1008",
      "Designation": "AI Engineer",
      "contact": "9685741230",
      "email": "nanyanair@example.com",
      "status": "Holding",
      "date": "14/10/2025",
      "createAt": "19/09/2025",
    },
    {
      "name": "Karan Patel",
      "jobId": "1009",
      "Designation": "DevOps Engineer",
      "contact": "9876501234",
      "email": "aranpatel@example.com",
      "status": "Rejected",
      "date": "15/10/2025",
      "createAt": "20/09/2025",
    },
    {
      "name": "Meera Iyer",
      "jobId": "1010",
      "Designation": "Business Analyst",
      "contact": "9765123409",
      "email": "meeraiyer@example.com",
      "status": "Selected",
      "date": "16/10/2025",
      "createAt": "21/09/2025",
    },
    {
      "name": "Rahul Kumar",
      "jobId": "1011",
      "Designation": "Mobile Developer",
      "contact": "9898989898",
      "email": "ahulkumar@example.com",
      "status": "Holding",
      "date": "17/10/2025",
      "createAt": "22/09/2025",
    },
    {
      "name": "Sneha Reddy",
      "jobId": "1012",
      "Designation": "Frontend Developer",
      "contact": "9080706050",
      "email": "nehareddy@example.com",
      "status": "Rejected",
      "date": "18/10/2025",
      "createAt": "23/09/2025",
    },
    {
      "name": "Amit Agarwal",
      "jobId": "1013",
      "Designation": "Tech Lead",
      "contact": "9001122334",
      "email": "mitagarwal@example.com",
      "status": "Selected",
      "date": "19/10/2025",
      "createAt": "24/09/2025",
    },
    {
      "name": "Pooja Jain",
      "jobId": "1014",
      "Designation": "Content Writer",
      "contact": "9911223344",
      "email": "oojajain@example.com",
      "status": "Holding",
      "date": "20/10/2025",
      "createAt": "25/09/2025",
    },
    {
      "name": "Rajesh Mishra",
      "jobId": "1015",
      "Designation": "System Admin",
      "contact": "9555667788",
      "email": "ajeshmishra@example.com",
      "status": "Rejected",
      "date": "21/10/2025",
      "createAt": "26/09/2025",
    },
    {
      "name": "Priya Verma",
      "jobId": "1016",
      "Designation": "Backend Developer",
      "contact": "9834512765",
      "email": "riyaverma@example.com",
      "status": "Selected",
      "date": "22/10/2025",
      "createAt": "27/09/2025",
    },
  ];
  // 🔹 Stage options for Status dropdown
  final List<String> stageOptions = ['Selected', 'Rejected', 'Holding'];

  // 🔹 Track selected status for each row
  late List<String> _selectedStages;

  @override
  void initState() {
    super.initState();
    // 🔹 Initialize selected stages from sampleData
    _selectedStages = sampleData.map((e) => e['status'] as String).toList();
  }

  // Build DataGridRows from applicantsData
  List<DataGridRow> _buildRows() => sampleData.asMap().entries.map((entry) {
    int index = entry.key; // row index
    var data = entry.value;
    return DataGridRow(
      cells: [
        // S.No column
        DataGridCell<int>(columnName: 'SNo', value: index + 1),
        DataGridCell<String>(columnName: 'Name', value: data['name']),
        DataGridCell<String>(columnName: 'JobId', value: data['jobId']),

        DataGridCell<String>(
          columnName: 'Designation',
          value: data['Designation'],
        ),
        DataGridCell<String>(columnName: 'Contact', value: data['contact']),
        DataGridCell<String>(columnName: 'Email', value: data['email']),
        DataGridCell<String>(
          columnName: 'Status',
          value: _selectedStages[index],
        ), // 🔹
        DataGridCell<String>(columnName: 'Date', value: data['date']),
        DataGridCell<String>(columnName: 'CreateAt', value: data['createAt']),
      ],
    );
  }).toList();

  //==================================================================
  // Columns
  List<GridColumn> _buildColumns() {
    //App Theme Data
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
      GridColumn(columnName: 'SNo', width: 90, label: header('S.No')),
      GridColumn(columnName: 'Name', width: 150, label: header('Name')),
      GridColumn(columnName: 'JobId', width: 90, label: header('Job ID')),
      GridColumn(columnName: 'Designation', label: header('Designation')),
      GridColumn(columnName: 'Contact', label: header('Contact')),
      GridColumn(columnName: 'Email', width: 220, label: header('Email')),
      GridColumn(columnName: 'Status', width: 150, label: header('Status')),
      GridColumn(columnName: 'Date', width: 120, label: header('Date')),
      GridColumn(
        columnName: 'CreateAt',
        width: 130,
        label: header('Created Date'),
      ),
    ];
  }

  // Getter methods for pagination

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final rows = _buildRows();
    final columns = _buildColumns();
    final hiveService = getIt<HiveStorageService>();

    // Grid Attendance Data - Updated with dynamic counts
    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'icon': AppAssetsConstants.phoneIcon, //   SVG path
        'title': 'Total Call Made Today',
        'numberOfCount': "150",
      },
      {
        'title': 'Yesterday Call Progress',
        'numberOfCount': "50",
        'icon': AppAssetsConstants.clockIcon, //   SVG path
      },
      {
        'title': 'Follow Up Call Today',
        'numberOfCount': "30",
        'icon': AppAssetsConstants.incommingcallIcon, //   SVG path
      },
      {
        'title': 'Non Responsive Calls',
        'numberOfCount': "70",
        'icon': AppAssetsConstants.rejectCallIcon, //   SVG path
      },
    ];

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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text: "Hiring Manager",
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              // color: AppColors.titleColor,
                            ),
                          ],
                        ),
                      ),
                      KVerticalSpacer(height: 10.h),

                      ///New Data Table
                      newDatatable(columns, rows),
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

  /// Data Table Widget
  ReusableDataGrid newDatatable(
    List<GridColumn> columns,
    List<DataGridRow> rows,
  ) {
    return ReusableDataGrid(
      title: 'Applicants',
      columns: columns,
      rows: rows,
      totalRows: rows.length,
      initialRowsPerPage: 10,
      allowSorting: true, // 🔹 Enable sorting
      selectionColor: Colors.red.withValues(alpha: 0.2),
      cellBuilder: (cell, rowIndex, actualDataIndex) {
        //App Theme Data
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        if (cell.columnName == 'Status') {
          final status = _selectedStages[actualDataIndex];

          // 🔹 Color mapping for container & text
          Color bgColor;
          Color textColor;
          switch (status.toLowerCase()) {
            case 'selected':
              bgColor = AppColors.checkInColor.withValues(alpha: .2);
              textColor = isDark
                  ? AppColors.checkInColorDark
                  : AppColors.checkInColor;
              break;
            case 'rejected':
              bgColor = AppColors.softRed.withValues(alpha: .2);
              textColor = isDark ? AppColors.softRedDark : AppColors.softRed;
              break;
            case 'holding':
              bgColor = Colors.yellow.withValues(alpha: .2);
              textColor = Colors.yellow.shade900;
              break;
            default:
              bgColor = Colors.grey.shade200;
              textColor = Colors.black;
          }

          return Container(
            // height: 20.h,
            margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: bgColor, // 🔹 Container background color
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButton<String>(
              value: status,
              underline: const SizedBox.shrink(),
              isExpanded: true,
              dropdownColor: theme
                  .secondaryHeaderColor, // 🔹 White background for dropdown menu
              iconEnabledColor:
                  theme.textTheme.headlineLarge?.color, // 🔹 Black arrow icon
              selectedItemBuilder: (context) {
                // 🔹 This controls how the selected item appears in the container
                return stageOptions.map((stage) {
                  return Center(
                    child: Text(
                      stage,
                      style: TextStyle(
                        color: textColor, // 🔹 Colored text for selected item
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
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
                          ?.color, //AppColors.titleColor,, // 🔹 Black text in dropdown items
                    ),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedStages[actualDataIndex] = val;
                    sampleData[actualDataIndex]['status'] = val;
                  });
                }
              },
            ),
          );
        }

        // Default cell display
        return Center(
          child: Text(
            cell.value?.toString() ?? '',
            style: TextStyle(fontSize: 12.sp),
          ),
        );
      },
    );
  }
}
