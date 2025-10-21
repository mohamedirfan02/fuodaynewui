import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_new_data_table.dart';
import 'package:fuoday/commons/widgets/k_ats_data_table.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OnboardingTab extends StatefulWidget {
  const OnboardingTab({super.key});

  @override
  State<OnboardingTab> createState() => _OnboardingTabState();
}

class _OnboardingTabState extends State<OnboardingTab> {
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
      "sno": 1,
      "name": "Aarav Sharma",
      "colum3": "2 yrs", // Experience
      "colum4": "Mumbai, Maharashtra", // Location
      "colum5": "Flutter Developer", // Role
      "colum6": "85%", // ATS Score
    },
    {
      "sno": 2,
      "name": "Priya Verma",
      "colum3": "3 yrs",
      "colum4": "Delhi, NCR",
      "colum5": "Backend Developer",
      "colum6": "78%",
    },
    {
      "sno": 3,
      "name": "Rohan Gupta",
      "colum3": "1.5 yrs",
      "colum4": "Pune, Maharashtra",
      "colum5": "UI/UX Designer",
      "colum6": "65%",
    },
    {
      "sno": 4,
      "name": "Neha Singh",
      "colum3": "4 yrs",
      "colum4": "Bangalore, Karnataka",
      "colum5": "Full Stack Developer",
      "colum6": "92%",
    },
    {
      "sno": 5,
      "name": "Arjun Mehta",
      "colum3": "Fresher",
      "colum4": "Ahmedabad, Gujarat",
      "colum5": "QA Engineer",
      "colum6": "60%",
    },
    {
      "sno": 6,
      "name": "Simran Kaur",
      "colum3": "5 yrs",
      "colum4": "Chennai, Tamil Nadu",
      "colum5": "Project Manager",
      "colum6": "88%",
    },
    {
      "sno": 7,
      "name": "Vikram Rao",
      "colum3": "2.5 yrs",
      "colum4": "Hyderabad, Telangana",
      "colum5": "Data Analyst",
      "colum6": "73%",
    },
    {
      "sno": 8,
      "name": "Ananya Nair",
      "colum3": "1 yr",
      "colum4": "Kochi, Kerala",
      "colum5": "AI Engineer",
      "colum6": "95%",
    },
    {
      "sno": 9,
      "name": "Karan Patel",
      "colum3": "6 yrs",
      "colum4": "Surat, Gujarat",
      "colum5": "DevOps Engineer",
      "colum6": "91%",
    },
    {
      "sno": 10,
      "name": "Meera Iyer",
      "colum3": "3.5 yrs",
      "colum4": "Coimbatore, Tamil Nadu",
      "colum5": "Business Analyst",
      "colum6": "67%",
    },
    {
      "sno": 11,
      "name": "Rahul Kumar",
      "colum3": "4.5 yrs",
      "colum4": "Kolkata, West Bengal",
      "colum5": "Mobile Developer",
      "colum6": "84%",
    },
    {
      "sno": 12,
      "name": "Sneha Reddy",
      "colum3": "2 yrs",
      "colum4": "Visakhapatnam, Andhra Pradesh",
      "colum5": "Frontend Developer",
      "colum6": "79%",
    },
    {
      "sno": 13,
      "name": "Amit Agarwal",
      "colum3": "7 yrs",
      "colum4": "Jaipur, Rajasthan",
      "colum5": "Tech Lead",
      "colum6": "89%",
    },
    {
      "sno": 14,
      "name": "Pooja Jain",
      "colum3": "1.5 yrs",
      "colum4": "Indore, Madhya Pradesh",
      "colum5": "Content Writer",
      "colum6": "55%",
    },
    {
      "sno": 15,
      "name": "Rajesh Mishra",
      "colum3": "8 yrs",
      "colum4": "Lucknow, Uttar Pradesh",
      "colum5": "System Admin",
      "colum6": "71%",
    },
    {
      "sno": 16,
      "name": "Priya Verma",
      "colum3": "3 yrs",
      "colum4": "Delhi, NCR",
      "colum5": "Backend Developer",
      "colum6": "78%",
    },
  ];

  // Build DataGridRows from applicantsData
  List<DataGridRow> _buildRows() => sampleData.asMap().entries.map((entry) {
    int index = entry.key; // row index
    var data = entry.value;
    return DataGridRow(
      cells: [
        // S.No column
        DataGridCell<int>(columnName: 'SNo', value: index + 1),
        DataGridCell<String>(columnName: 'Name', value: data['name']),
        DataGridCell<String>(columnName: 'Experience', value: data['colum3']),
        DataGridCell<String>(columnName: 'Location', value: data['colum4']),
        DataGridCell<String>(columnName: 'Role', value: data['colum5']),
        DataGridCell<String>(columnName: 'Score', value: data['colum6']),
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
      GridColumn(columnName: 'Name', width: 150, label: header('Name')),

      GridColumn(columnName: 'Experience', label: header('Experience')),
      GridColumn(columnName: 'Location', label: header('Location')),
      GridColumn(columnName: 'Role', width: 200, label: header('Role')),
      GridColumn(columnName: 'Score', width: 120, label: header('ATS Score')),
    ];
  }

  // Getter methods for pagination
  int get totalPages => (sampleData.length / itemsPerPage).ceil();

  List<Map<String, dynamic>> get paginatedData {
    int totalPagesCount = (sampleData.length / itemsPerPage).ceil();

    // Ensure currentPage is within range
    if (currentPage > totalPagesCount) currentPage = totalPagesCount;
    if (currentPage < 1) currentPage = 1;

    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    if (startIndex >= sampleData.length) return []; // safe guard
    if (endIndex > sampleData.length) endIndex = sampleData.length;

    return sampleData.sublist(startIndex, endIndex);
  }

  // Calculate display text for showing entries
  String get entriesDisplayText {
    if (sampleData.isEmpty) return "Showing 0 to 0 of 0 entries";

    int startIndex = (currentPage - 1) * itemsPerPage + 1;
    int endIndex = currentPage * itemsPerPage;
    if (endIndex > sampleData.length) endIndex = sampleData.length;

    return "Showing $startIndex to $endIndex of ${sampleData.length} entries";
  }

  @override
  Widget build(BuildContext context) {
    final rows = _buildRows();
    final columns = _buildColumns();
    final hiveService = getIt<HiveStorageService>();
    //Table Column Header Widget
    SizedBox _headers(String text, double width) {
      return SizedBox(
        width: width,
        child: Center(
          child: KText(
            text: text,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.greyColor,
          ),
        ),
      );
    }

    final headers = [
      _headers("S.No", 50.w),
      _headers("Name", 100.w),
      _headers("Experience", 120.w),
      _headers("Location", 120.w),
      _headers("Role", 100.w),
      _headers("ATS Score", 160.w),

      //   if (showStatusColumn) // ✅ conditional
      //      SizedBox(
      //      width: 120.w,
      //      child: KText(
      //        text: "Status",
      //        fontSize: 12.sp,
      //        fontWeight: FontWeight.w500,
      //        color: AppColors.greyColor,
      //      ),
      //    ),
    ];

    // Grid Attendance Data - Updated with dynamic counts
    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
        'title': 'Total Employees',
        'numberOfCount': "13,540",
      },
      {
        'title': 'Awaiting Employment',
        'numberOfCount': "708",
        'icon': AppAssetsConstants.pecIcon, // ✅ SVG path
      },
      {
        'title': 'Ofer Acceptance Rate',
        'numberOfCount': "958",
        'icon': AppAssetsConstants.pecIcon, // ✅ SVG path
      },
      {
        'title': 'Conversion Rate',
        'numberOfCount': "1,504",
        'icon': AppAssetsConstants.pecIcon, // ✅ SVG path
      },
    ];

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.atsHomepageBg,
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
                    crossAxisCount: 2,
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
                      employeeIconColor: AppColors.primaryColor,
                      employeePercentageColor: AppColors.checkInColor,
                      growthText: item['growth'],
                    );
                  },
                ),
                SizedBox(height: 14.h),
                Container(
                  padding: EdgeInsets.all(18.47.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.77.w,
                      color: AppColors.greyColor.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(7.69.r),
                    color: AppColors.secondaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: "Candidate List",
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: AppColors.titleColor,
                          ),
                        ],
                      ),
                      KVerticalSpacer(height: 20.h),

                      // Data Table with paginated data
                      /* <!-----------Old Data Table----------->
                      SizedBox(
                        height: 330.h,
                        child: KAtsDataTable(
                          columnHeaders: headers,
                          rowData: paginatedData,
                          showActionsColumn: false,
                          showStatusColumn: false,
                          minWidth: 1000.w,
                        ),
                      ),

                      // Pagination
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [_buildPageNumbersRow()],
                      ),

                      SizedBox(height: 16.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          KText(
                            text: entriesDisplayText, // Dynamic entries text
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w500,
                          ),

                          GestureDetector(
                            onTap: () {
                              // Show dropdown or bottom sheet to change items per page
                              _showItemsPerPageSelector();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.77.w,
                                  color: AppColors.greyColor.withOpacity(0.1),
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.secondaryColor,
                              ),
                              child: Row(
                                children: [
                                  KText(
                                    text: "Show $itemsPerPage",
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                        0.025,
                                    color: AppColors.titleColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size:
                                        MediaQuery.of(context).size.width *
                                        0.04,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),*/
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
                text: "Items per page",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.titleColor,
              ),
              SizedBox(height: 16.h),
              ...([5, 6, 10, 15, 20].map(
                (count) => ListTile(
                  title: KText(
                    text: "Show $count items",
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

/// Data Table Widget
Padding newDatatable(List<GridColumn> columns, List<DataGridRow> rows) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: ReusableDataGrid(
      title: 'Applicants',
      columns: columns,
      rows: rows,
      totalRows: rows.length,
      initialRowsPerPage: 5,
    ),
  );
}
