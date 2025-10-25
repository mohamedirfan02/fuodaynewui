import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_app_new_data_table.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_filter_button.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/home/presentation/screens/ats_screens/ats_follow_up_call_tab.dart';
import 'package:fuoday/features/home/presentation/screens/ats_screens/ats_non_responsive_call_tab.dart';
import 'package:fuoday/features/home/presentation/screens/ats_screens/ats_total_call_log_tab.dart';
import 'package:fuoday/features/home/presentation/screens/ats_screens/ats_dashboard_tab.dart';
import 'package:fuoday/features/home/presentation/screens/ats_screens/ats_yesterday_call_tab.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:fuoday/features/home/presentation/widgets/k_ats_applicatitem.dart';
import 'package:fuoday/features/home/presentation/widgets/k_calendar.dart';
import 'package:fuoday/features/home/presentation/widgets/requirement_stats_card.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../core/constants/router/app_route_constants.dart';
import '../../../../ats_hiring/presentation/screens/ats_onboarding_tab.dart';

class HomeRecruiterScreen extends StatefulWidget {
  const HomeRecruiterScreen({super.key});

  @override
  State<HomeRecruiterScreen> createState() => _HomeRecruiterScreenState();
}

class _HomeRecruiterScreenState extends State<HomeRecruiterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController dateController = TextEditingController();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  // Pagination state
  int currentPage = 1;
  int itemsPerPage = 6; // Change this to show how many items per page
  int pageWindowStart = 1; // first page in current window
  int pageWindowSize = 5; // show 5 numbers at a time

  List<Map<String, dynamic>> applicantsData = [
    {
      'name': 'Pristia Candra',
      'email': 'pristia@gmail.com,pristia@gmail.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '01 May 2025',
      'avatarColor': AppColors.primaryColor,
    },
    {
      'name': 'Hanna Baptista',
      'email': 'hanna@gmail.com,pristia@gmail.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '01 May 2025',
      'avatarColor': AppColors.greyColor,
    },
    {
      'name': 'John Doe',
      'email': 'john@gmail.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.approvedColor,
    },
    {
      'name': 'James George',
      'email': 'james@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.unactive,
    },
    {
      'name': 'Miracle Geidt',
      'email': 'miracle@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.titleColor,
    },
    {
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },
    {
      'name': 'Alex Johnson',
      'email': 'alex@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '03 May 2025',
      'avatarColor': AppColors.titleColor,
    },
    {
      'name': 'Sarah Wilson',
      'email': 'sarah@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '03 May 2025',
      'avatarColor': AppColors.secondaryColor,
    },
    {
      'name': 'Mike Davis',
      'email': 'mike@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '04 May 2025',
      'avatarColor': AppColors.greyColor,
    },
    {
      'name': 'Emma Thompson',
      'email': 'emma@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '04 May 2025',
      'avatarColor': AppColors.authTextFieldSuffixIconColor,
    },
    {
      'name': 'David Brown',
      'email': 'david@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '05 May 2025',
      'avatarColor': AppColors.unactive,
    },
    {
      'name': 'Lisa Garcia',
      'email': 'lisa@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '05 May 2025',
      'avatarColor': AppColors.pending,
    },
    {
      'name': 'Tom Anderson',
      'email': 'tom@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '06 May 2025',
      'avatarColor': AppColors.checkInColor,
    },
    {
      'name': 'Rachel Miller',
      'email': 'rachel@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '06 May 2025',
      'avatarColor': AppColors.authUnderlineBorderColor,
    },
    {
      'name': 'Kevin Taylor',
      'email': 'kevin@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '07 May 2025',
      'avatarColor': AppColors.approvedColor,
    },
    {
      'name': 'Jessica Lee',
      'email': 'jessica@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '07 May 2025',
      'avatarColor': AppColors.primaryColor,
    },
    {
      'name': 'Ryan Clark',
      'email': 'ryan@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '08 May 2025',
      'avatarColor': AppColors.titleColor,
    },
    {
      'name': 'Amanda White',
      'email': 'amanda@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '08 May 2025',
      'avatarColor': AppColors.greyColor,
    },
    {
      'name': 'Chris Martinez',
      'email': 'chris@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '09 May 2025',
      'avatarColor': AppColors.pending,
    },
    {
      'name': 'Nicole Rodriguez',
      'email': 'nicole@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '09 May 2025',
      'avatarColor': AppColors.unactive,
    },
  ];

  // Getter methods for pagination
  int get totalPages => (applicantsData.length / itemsPerPage).ceil();

  List<Map<String, dynamic>> get paginatedApplicants {
    int totalPagesCount = (applicantsData.length / itemsPerPage).ceil();

    // Ensure currentPage is within range
    if (currentPage > totalPagesCount) currentPage = totalPagesCount;
    if (currentPage < 1) currentPage = 1;

    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    if (startIndex >= applicantsData.length) return []; // safe guard
    if (endIndex > applicantsData.length) endIndex = applicantsData.length;

    return applicantsData.sublist(startIndex, endIndex);
  }

  // Calculate display text for showing entries
  String get entriesDisplayText {
    if (applicantsData.isEmpty) return "Showing 0 to 0 of 0 entries";

    int startIndex = (currentPage - 1) * itemsPerPage + 1;
    int endIndex = currentPage * itemsPerPage;
    if (endIndex > applicantsData.length) endIndex = applicantsData.length;

    return "Showing $startIndex to $endIndex of ${applicantsData.length} entries";
  }

  // Select Date
  Future<void> selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.day,
      helpText: 'Select Date',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.secondaryColor,
              onSurface: AppColors.titleColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  //New Data Tbale Headers
  // List<DataGridRow> _buildRows() => List.generate(
  //   200,
  //   (i) => DataGridRow(
  //     cells: [
  //       DataGridCell<int>(columnName: 'ID', value: i + 1),
  //       DataGridCell<String>(columnName: 'Name', value: 'Item ${i + 1}'),
  //       DataGridCell<double>(columnName: 'Price', value: (i + 1) * 10.5),
  //       DataGridCell<String>(
  //         columnName: 'Nameq',
  //         value: 'Item cccccccc${i + 1}',
  //       ),
  //       DataGridCell<String>(
  //         columnName: 'Namec',
  //         value: 'Item vvvvvvvvv${i + 1}',
  //       ),
  //     ],
  //   ),
  // );

  // // ✅ Columns
  // List<GridColumn> _buildColumns() {
  //   const headerStyle = TextStyle(fontWeight: FontWeight.bold);
  //
  //   Widget header(String text) => Container(
  //     padding: const EdgeInsets.all(8),
  //     alignment: Alignment.center,
  //     child: Text(text, style: headerStyle),
  //   );
  //
  //   return [
  //     GridColumn(columnName: 'ID', label: header('ID')),
  //     GridColumn(columnName: 'Name', label: header('Name')),
  //     GridColumn(columnName: 'Price', width: 180, label: header('Actions')),
  //     GridColumn(columnName: 'Namew', width: 200, label: header('Test1')),
  //     GridColumn(columnName: 'Namec', width: 180, label: header('Actions')),
  //   ];
  // }
  // Track selected stage per row
  late List<String> _selectedStages;
  Widget _actionButton({
    required Color color,
    required String icon,
    VoidCallback? onTap,
  }) {
    return Container(
      width: 30.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          icon,
          height: 14.h,
          fit: BoxFit.contain,
          color: Colors.white,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  final List<String> stageOptions = [
    'Select Stage',
    'Applied',
    'Screening',
    '1st Interview',
    '2nd Interview',
    'Hiring',
    'Rejected',
  ];
  //==================================================================
  // Build DataGridRows from applicantsData
  // Build DataGridRows from applicantsData
  List<DataGridRow> _buildRows() => applicantsData.asMap().entries.map((entry) {
    int index = entry.key; // row index
    var data = entry.value;
    return DataGridRow(
      cells: [
        // S.No column
        DataGridCell<int>(columnName: 'SNo', value: index + 1),
        DataGridCell<String>(columnName: 'Email', value: data['email']),
        DataGridCell<String>(columnName: 'Phone', value: data['phone']),
        DataGridCell<String>(columnName: 'CV', value: data['cv']),
        DataGridCell<String>(
          columnName: 'CreatedDate',
          value: data['createdDate'],
        ),
        DataGridCell<String>(columnName: 'Stage', value: 'New'),
        DataGridCell<String>(columnName: 'Action', value: 'ss'),
      ],
    );
  }).toList();

  //==================================================================
  // Columns
  List<GridColumn> _buildColumns() {
    const headerStyle = TextStyle(
      fontWeight: FontWeight.normal,
      color: AppColors.greyColor,
    );
    Widget header(String text) => Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(text, style: headerStyle),
    );

    return [
      GridColumn(columnName: 'SNo', width: 70, label: header('S.No')),
      GridColumn(columnName: 'Email', width: 200, label: header('Name')),
      GridColumn(columnName: 'Phone', label: header('Phone Number')),
      GridColumn(columnName: 'CV', label: header('CV')),
      GridColumn(columnName: 'CreatedDate', label: header('Date')),
      GridColumn(columnName: 'Stage', width: 140, label: header('Stage')),
      GridColumn(columnName: 'Action', width: 100, label: header('Action')),
    ];
  }

  @override
  void initState() {
    super.initState();
    _selectedStages = List.generate(
      applicantsData.length,
      (_) => 'Select Stage',
    );
  }

  @override
  Widget build(BuildContext context) {
    final rows = _buildRows();
    final columns = _buildColumns();
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Safe extraction of employee details
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "No Email";
    final String currentRoute =
        AppRouteConstants.homeRecruiter; // Replace with actual current route

    // Grid Attendance Data - Updated with dynamic counts
    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
        'title': 'Total Opening Position',
        'numberOfCount': "3,540",
        'growth': "+5.1%",
      },
      {
        'title': 'Total Closed Position',
        'numberOfCount': "1,540",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
      },
      {
        'title': 'Total Employee',
        'numberOfCount': "500",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
      },
      {
        'title': 'Shortlisted',
        'numberOfCount': "1,504",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
      },
      {
        'title': 'On Hold',
        'numberOfCount': "562",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
      },
      {
        'title': 'Onboarding',
        'numberOfCount': "850",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
      },
    ];

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AtsKAppBarWithDrawer(
          userName: "",
          cachedNetworkImageUrl: profilePhoto,
          userDesignation: "",
          showUserInfo: true,
          onDrawerPressed: _openDrawer,
          onNotificationPressed: () {},
        ),
        drawer: KAtsDrawer(
          userName: name,
          userEmail: email,
          currentRoute: currentRoute, // This will highlight the current screen
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.atsHomepageBg,
          child: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        KText(
                          text: "Hello $name",
                          fontWeight: FontWeight.w600,
                          fontSize: 24.sp,
                          color: AppColors.titleColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ), // spacing between text and emoji
                        const Text(
                          "👋",
                          style: TextStyle(fontSize: 24), // match text size
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: KText(
                      text: "Welcome back to Recruiter Dashboard",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 0,
                          top: 20.h,
                          bottom: 20.h,
                        ),
                        child: TabBar(
                          isScrollable: true,
                          tabAlignment: TabAlignment.start, // left align
                          dividerColor: AppColors.atsHomepageBg,
                          unselectedLabelColor: AppColors.greyColor,
                          indicatorColor: AppColors.primaryColor,
                          labelColor: AppColors.titleColor,
                          tabs: [
                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppAssetsConstants.dashboardIcon,
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text("Dashboard"),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppAssetsConstants.callLogIcon,
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text("Total Call Made Today"),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppAssetsConstants.clockIcon,
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text("Yesterday Call Progress"),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppAssetsConstants.incommingcallIcon,
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text("Follow Up Call Today"),
                                ],
                              ),
                            ),
                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppAssetsConstants.rejectCallIcon,
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text("Non Responsive Calls"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: TabBarView(
                          children: [
                            DashoardTab(),
                            TotalCallTab(),
                            YesterdayCallTab(),
                            FollowUpCallTab(),
                            NonResponsiveCallTab(),
                          ],
                        ),
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

  Padding newData_table(List<GridColumn> columns, List<DataGridRow> rows) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ReusableDataGrid(
        title: 'Applicants',
        columns: columns,
        rows: rows,
        totalRows: rows.length,
        initialRowsPerPage: 5,
        cellBuilder: (cell, rowIndex, actualDataIndex) {
          final value = cell.value;
          if (cell.columnName == 'SNo') {
            return Container(
              alignment:
                  Alignment.center, // Centers horizontally and vertically
              child: Text(cell.value.toString(), textAlign: TextAlign.center),
            );
          }
          if (cell.columnName == 'Email') {
            final applicant = applicantsData[actualDataIndex];
            final fullName = applicant['name'] ?? "";
            final email = applicant['email'] ?? "";
            final color = applicant['avatarColor'] ?? Colors.grey;

            // Get initials from full name
            String getInitials(String name) {
              final parts = name.split(' ');
              if (parts.length == 1) return parts[0][0].toUpperCase();
              return (parts[0][0] + parts[1][0]).toUpperCase();
            }

            return Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color,
                    radius: 12.r,
                    child: KText(
                      text: getInitials(fullName),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KText(
                            text: fullName,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.titleColor,
                            textAlign: TextAlign.center,
                          ),
                          KText(
                            text: email,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          //  CV column
          if (cell.columnName == 'CV') {
            final applicant = applicantsData[actualDataIndex];
            final cv = applicant['cv'] ?? "";
            return Row(
              children: [
                Text(cv),
                SizedBox(width: 4.w),
                Icon(
                  Icons.download_outlined,
                  size: 16.sp,
                  color: AppColors.greyColor,
                ),
              ],
            );
          }

          // Stage dropdown column
          if (cell.columnName == 'Stage') {
            final applicant = applicantsData[actualDataIndex];
            return DropdownButton<String>(
              value: _selectedStages[rowIndex],
              underline: const SizedBox.shrink(),
              items: stageOptions.map((stage) {
                return DropdownMenuItem(
                  value: stage,
                  child: Text(stage, style: TextStyle(fontSize: 12.sp)),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _selectedStages[rowIndex] = val);
                }
              },
            );
          }

          if (cell.columnName == 'Action') {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _actionButton(
                  color: AppColors.primaryColor,
                  icon: AppAssetsConstants.editIcon,
                  onTap: () {},
                ),
                SizedBox(width: 8.w),
                _actionButton(
                  color: AppColors.softRed,
                  icon: AppAssetsConstants.deleteIcon,
                  onTap: () {},
                ),
              ],
            );
          }

          // Default text cells
          return Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Text(value.toString(), style: TextStyle(fontSize: 12.sp)),
          );
        },
      ),
    );
  }

  Widget _buildPageNumbersRow() {
    int windowEnd = (pageWindowStart + pageWindowSize - 1);
    if (windowEnd > totalPages) windowEnd = totalPages;

    List<Widget> pageButtons = [];

    // Previous window arrow
    pageButtons.add(
      IconButton(
        icon: Icon(Icons.chevron_left, size: 16.sp),
        onPressed: pageWindowStart > 1
            ? () {
                setState(() {
                  pageWindowStart -= pageWindowSize;
                  currentPage = pageWindowStart;
                });
              }
            : null,
      ),
    );

    // Page numbers
    for (int i = pageWindowStart; i <= windowEnd; i++) {
      pageButtons.add(
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: _buildPageNumber(i),
        ),
      );
    }

    // Next window arrow
    pageButtons.add(
      IconButton(
        icon: Icon(Icons.chevron_right, size: 16.sp),
        onPressed: windowEnd < totalPages
            ? () {
                setState(() {
                  pageWindowStart += pageWindowSize;
                  currentPage = pageWindowStart;
                });
              }
            : null,
      ),
    );

    return Row(children: pageButtons);
  }

  Widget _buildPageNumber(int pageNum) {
    final isActive = pageNum == currentPage;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentPage = pageNum;
        });
      },
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: isActive ? Color(0xFFF8F8F8) : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Center(
          child: KText(
            text: pageNum.toString(),
            fontSize: 12.sp,
            color: isActive ? Colors.black : AppColors.titleColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _showItemsPerPageSelector() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KText(
                text: "Candidate per page",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
              ),
              SizedBox(height: 16.h),
              ...([5, 6, 10, 15, 20].map(
                (count) => ListTile(
                  title: KText(
                    text: "Show $count Candidate",
                    fontSize: 14.sp,
                    color: AppColors.titleColor,
                    fontWeight: FontWeight.w500,
                  ),
                  trailing: itemsPerPage == count
                      ? Icon(Icons.check, color: AppColors.primaryColor)
                      : null,
                  onTap: () {
                    setState(() {
                      itemsPerPage = count;
                      currentPage = 1; // Reset to first page
                      pageWindowStart = 1; // Reset pagination window
                    });
                    Navigator.pop(context);
                  },
                ),
              )),
            ],
          ),
        );
      },
    );
  }
}
