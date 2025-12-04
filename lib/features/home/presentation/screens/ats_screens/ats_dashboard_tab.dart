import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_app_new_data_table.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_filter_button.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:fuoday/features/home/presentation/widgets/k_calendar.dart';
import 'package:fuoday/features/home/presentation/widgets/requirement_stats_card.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../core/constants/router/app_route_constants.dart';

class DashoardTab extends StatefulWidget {
  const DashoardTab({super.key});

  @override
  State<DashoardTab> createState() => _DashoardTabState();
}

class _DashoardTabState extends State<DashoardTab> {
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
      'jobId': '1001',
    },
    {
      'name': 'Hanna Baptista',
      'email': 'hanna@gmail.com,pristia@gmail.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '01 May 2025',
      'avatarColor': AppColors.greyColor,
      'jobId': '1002',
    },
    {
      'name': 'John Doe',
      'email': 'john@gmail.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.approvedColor,
      'jobId': '1003',
    },
    {
      'name': 'James George',
      'email': 'james@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.unactive,
      'jobId': '1004',
    },
    {
      'name': 'Miracle Geidt',
      'email': 'miracle@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.titleColor,
      'jobId': '1005',
    },
    {
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
      'jobId': '1006',
    },
    {
      'name': 'Alex Johnson',
      'email': 'alex@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '03 May 2025',
      'avatarColor': AppColors.titleColor,
      'jobId': '1007',
    },
    {
      'name': 'Sarah Wilson',
      'email': 'sarah@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '03 May 2025',
      'avatarColor': AppColors.secondaryColor,
      'jobId': '1008',
    },
    {
      'name': 'Mike Davis',
      'email': 'mike@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '04 May 2025',
      'avatarColor': AppColors.greyColor,
      'jobId': '1009',
    },
    {
      'name': 'Emma Thompson',
      'email': 'emma@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '04 May 2025',
      'avatarColor': AppColors.authTextFieldSuffixIconColor,
      'jobId': '1001',
    },
    {
      'name': 'David Brown',
      'email': 'david@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '05 May 2025',
      'avatarColor': AppColors.unactive,
      'jobId': '1001',
    },
    {
      'name': 'Lisa Garcia',
      'email': 'lisa@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '05 May 2025',
      'avatarColor': AppColors.pending,
      'jobId': '1001',
    },
    {
      'name': 'Tom Anderson',
      'email': 'tom@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '06 May 2025',
      'avatarColor': AppColors.checkInColor,
      'jobId': '1001',
    },
    {
      'name': 'Rachel Miller',
      'email': 'rachel@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '06 May 2025',
      'avatarColor': AppColors.authUnderlineBorderColor,
      'jobId': '1001',
    },
    {
      'name': 'Kevin Taylor',
      'email': 'kevin@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '07 May 2025',
      'avatarColor': AppColors.approvedColor,
      'jobId': '1001',
    },
    {
      'name': 'Jessica Lee',
      'email': 'jessica@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '07 May 2025',
      'avatarColor': AppColors.primaryColor,
      'jobId': '1001',
    },
    {
      'name': 'Ryan Clark',
      'email': 'ryan@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '08 May 2025',
      'avatarColor': AppColors.titleColor,
      'jobId': '1001',
    },
    {
      'name': 'Amanda White',
      'email': 'amanda@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '08 May 2025',
      'avatarColor': AppColors.greyColor,
      'jobId': '1001',
    },
    {
      'name': 'Chris Martinez',
      'email': 'chris@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '09 May 2025',
      'avatarColor': AppColors.pending,
      'jobId': '1001',
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
        //App Theme Data
        final theme = Theme.of(context);
        // final isDark = theme.brightness == Brightness.dark;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: theme.primaryColor,
              onPrimary: theme.secondaryHeaderColor, //AppColors.secondaryColor
              onSurface:
                  theme.textTheme.headlineLarge?.color ??
                  AppColors.titleColor, //AppColors.titleColor,
              surface: theme.secondaryHeaderColor,
              surfaceContainer: theme.secondaryHeaderColor,
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
      width: 25.w,
      height: 25.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: IconButton(
        onPressed: onTap,
        icon: SvgPicture.asset(
          icon,
          height: 10.h,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
        DataGridCell<String>(columnName: 'JobID', value: data['jobId']),
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
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    const headerStyle = TextStyle(
      fontWeight: FontWeight.normal,
      color: AppColors.greyColor,
    );
    Widget header(String text) => Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: KText(
        text: text,
        fontWeight: FontWeight.normal,
        fontSize: 12.sp,
        color: theme.textTheme.bodyLarge?.color,
      ),
    );

    return [
      GridColumn(columnName: 'SNo', width: 70, label: header('S.No')),
      GridColumn(columnName: 'Email', width: 200, label: header('Name')),
      GridColumn(columnName: 'JobID', width: 70, label: header('Job ID')),
      GridColumn(columnName: 'Phone', label: header('Phone Number')),
      GridColumn(columnName: 'CV', label: header('CV')),
      GridColumn(columnName: 'CreatedDate', label: header('CreatedDate')),
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
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
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
        'backgroundImage': AppAssetsConstants.atsHomeCardImg1,
      },
      {
        'title': 'Total Closed Position',
        'numberOfCount': "1,540",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
        'backgroundImage': AppAssetsConstants.atsHomeCardImg2,
      },
      {
        'title': 'Total Employee',
        'numberOfCount': "500",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
        'backgroundImage': AppAssetsConstants.atsHomeCardImg3,
      },
      {
        'title': 'Shortlisted',
        'numberOfCount': "1,504",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
        'backgroundImage': AppAssetsConstants.atsHomeCardImg4,
      },
      {
        'title': 'On Hold',
        'numberOfCount': "562",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
        'backgroundImage': AppAssetsConstants.atsHomeCardImg5,
      },
      {
        'title': 'Onboarding',
        'numberOfCount': "850",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
        'backgroundImage': AppAssetsConstants.atsHomeCardImg6,
      },
    ];

    return Scaffold(
      key: _scaffoldKey,
      // appBar: AtsKAppBarWithDrawer(
      //   userName: "",
      //   cachedNetworkImageUrl: profilePhoto,
      //   userDesignation: "",
      //   showUserInfo: true,
      //   onDrawerPressed: _openDrawer,
      //   onNotificationPressed: () {},
      // ),
      // drawer: KAtsDrawer(
      //   userEmail: email,
      //   userName: name,
      //   profileImageUrl: profilePhoto,
      //   currentRoute: currentRoute, // This will highlight the current screen
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: theme.cardColor, //ATS Background Color
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Home Page Title
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       KText(
                //         text: "Hello $name",
                //         fontWeight: FontWeight.w600,
                //         fontSize: 24.sp,
                //         color: AppColors.titleColor,
                //       ),
                //       const SizedBox(
                //         width: 8,
                //       ), // spacing between text and emoji
                //       const Text(
                //         "👋",
                //         style: TextStyle(fontSize: 24), // match text size
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 8.h),
                // KText(
                //   text: "Welcome back to Recruiter Dashboard",
                //   fontWeight: FontWeight.w600,
                //   fontSize: 12.sp,
                //   color: AppColors.greyColor,
                // ),
                //SizedBox(height: 20.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
                      backgroundImage: item['backgroundImage'],
                      empTextColors: AppColors.secondaryColor,
                      avatarBgColors: theme.secondaryHeaderColor,
                    );
                  },
                ),

                SizedBox(height: 16.h),

                RequirementStatsCard(
                  dataMap: {
                    "Pending": 36,
                    "Completed": 6,
                    "Application Conversion Rate": 98,
                  },
                  colorMap: {
                    "Pending": isDark
                        ? AppColors.pendingColorDark
                        : AppColors.pending,
                    "Completed": isDark
                        ? AppColors.unactiveDark
                        : AppColors.unactive,
                    "Application Conversion Rate": isDark
                        ? AppColors.closedDark
                        : AppColors.closed,
                  },
                ),
                SizedBox(height: 16.h),
                //Applicant details Container
                Container(
                  // padding: EdgeInsets.all(18.47.w),
                  // padding: EdgeInsets.symmetric(
                  //   horizontal: 18.47.w,
                  //   vertical: 16.h,
                  // ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.77.w,
                      color:
                          theme.textTheme.bodyLarge?.color?.withValues(
                            alpha: 0.3,
                          ) ??
                          AppColors.greyColor.withValues(
                            alpha: 0.3,
                          ), //BORDER COLOR,//AppColors.greyColor.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(7.69.r),
                    color:
                        theme.secondaryHeaderColor, //AppColors.secondaryColor
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
                                  text: "Applicant details",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  // color: AppColors.titleColor,
                                ),
                              ],
                            ),
                            KVerticalSpacer(height: 16.h),

                            // Date and Export Row
                            Row(
                              spacing: 20.w,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Start Date
                                Expanded(
                                  child: KAtsGlowButton(
                                    text: "Date",
                                    textColor:
                                        theme.textTheme.bodyLarge?.color ??
                                        AppColors
                                            .greyColor, //AppColors.greyColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    icon: SvgPicture.asset(
                                      AppAssetsConstants.dateIcon,
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.contain,
                                      //SVG IMAGE COLOR
                                      colorFilter: ColorFilter.mode(
                                        theme.textTheme.headlineLarge?.color ??
                                            Colors.black,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    onPressed: () {
                                      selectDate(context, dateController);
                                    },
                                    backgroundColor: theme
                                        .secondaryHeaderColor, //AppColors.secondaryColor
                                  ),
                                ),

                                // Export file
                                Expanded(
                                  child: KAtsGlowButton(
                                    text: "Export",
                                    textColor: theme
                                        .secondaryHeaderColor, //AppColors.secondaryColor
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    icon: SvgPicture.asset(
                                      AppAssetsConstants.downloadIcon,
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.contain,
                                      //SVG IMAGE COLOR
                                      colorFilter: ColorFilter.mode(
                                        theme.secondaryHeaderColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    onPressed: () {
                                      print("Export button tapped");
                                      // context.pushNamed(
                                      //   AppRouteConstants.atsTrackerScreen,
                                      // );
                                      // GoRouter.of(
                                      //   context,
                                      // ).pushNamed(AppRouteConstants.atsTrackerScree n);
                                    },
                                    backgroundColor: theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            KVerticalSpacer(height: 16.h),

                            // Filter Field
                            KFilterBtn(
                              text: "Filter",
                              textColor:
                                  theme.textTheme.headlineLarge?.color ??
                                  AppColors.titleColor, //AppColors.titleColor,
                              backgroundColor: theme
                                  .secondaryHeaderColor, //AppColors.secondaryColor
                              borderColor: const Color.fromRGBO(
                                233,
                                234,
                                236,
                                1,
                              ),
                              borderRadius: BorderRadius.circular(10.r),

                              onPressed: () {
                                debugPrint("Filter pressed");
                              },
                              icon: SvgPicture.asset(
                                AppAssetsConstants.filterIcon,
                                height: 16.h,
                                width: 16.w,
                                //SVG IMAGE COLOR
                                colorFilter: ColorFilter.mode(
                                  theme.textTheme.headlineLarge?.color ??
                                      Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),

                            KVerticalSpacer(height: 10.h),
                          ],
                        ),
                      ),

                      ///<!---------- Data Table
                      newData_table(columns, rows),
                    ],
                  ),
                ),
                SizedBox(height: 16.w),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.47.w,
                    vertical: 10.0.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.77.w,
                      color:
                          theme.textTheme.bodyLarge?.color?.withOpacity(0.3) ??
                          AppColors.greyColor, //BORDER COLOR
                    ),
                    borderRadius: BorderRadius.circular(7.69.r),
                    color:
                        theme.secondaryHeaderColor, //AppColors.secondaryColor
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      CalendarHeader(),

                      SizedBox(height: 10.h),

                      // TODAY Section
                      TodaySection(),

                      SizedBox(height: 16.h),

                      // UPCOMING Section
                      UpcomingSection(),
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

  ReusableDataGrid newData_table(
    List<GridColumn> columns,
    List<DataGridRow> rows,
  ) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final atsPrimaryColor = Theme.of(context).colorScheme.primary;

    return ReusableDataGrid(
      allowSorting: false, // 🔹 Enable sorting
      title: 'Applicants',
      columns: columns,
      rows: rows,
      totalRows: rows.length,
      initialRowsPerPage: 5,
      cellBuilder: (cell, rowIndex, actualDataIndex) {
        final value = cell.value;
        if (cell.columnName == 'SNo') {
          return Container(
            alignment: Alignment.center, // Centers horizontally and vertically
            child: Text(cell.value.toString(), textAlign: TextAlign.center),
          );
        }
        if (cell.columnName == 'JobID') {
          return Container(
            alignment: Alignment.center, // Centers horizontally and vertically
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
                  backgroundColor: AppColors.checkInColor.withValues(
                    alpha: 0.1,
                  ),
                  radius: 12.r,
                  child: KText(
                    text: getInitials(fullName),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.checkInColor,
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
                          //  color: AppColors.titleColor,
                          textAlign: TextAlign.center,
                        ),
                        KText(
                          text: email,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: theme
                              .textTheme
                              .bodyLarge
                              ?.color, //AppColors.greyColor,
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
                Icons.sim_card_download_outlined,
                size: 16.sp,
                color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,,
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
                color: atsPrimaryColor,
                icon: AppAssetsConstants.editIcon,
                onTap: () {},
              ),
              SizedBox(width: 8.w),
              _actionButton(
                color: isDark ? AppColors.softRedDark : AppColors.softRed,
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
    );
  }
}
