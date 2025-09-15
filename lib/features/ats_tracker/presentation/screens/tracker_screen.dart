import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_ats_data_table.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
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
  ];

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
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final name = employeeDetails?['name'] ?? "No Name";
    final email = employeeDetails?['email'] ?? "No Email";
    final String currentRoute = AppRouteConstants.trackerScreen; // Replace with actual current route

    final headers = [
      SizedBox(
        width: 50.w,
        child: KText(
          text: "S.No",
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.greyColor,
        ),
      ),
      SizedBox(
        width: 200.w,
        child: KText(
          text: "Name",
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.greyColor,
        ),
      ),
      SizedBox(
        width: 120.w,
        child: KText(
          text: "Experience",
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.greyColor,
        ),
      ),
      SizedBox(
        width: 160.w,
        child: KText(
          text: "Location",
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.greyColor,
        ),
      ),
      SizedBox(
        width: 100.w,
        child: KText(
          text: "Role",
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.greyColor,
        ),
      ),
      SizedBox(
        width: 160.w,
        child: KText(
          text: "ATS Score",
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.greyColor,
        ),
      ),

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
        'icon': AppAssetsConstants.downloadIcon, // ✅ SVG path
        'title': 'Resume Downloaded',
        'numberOfCount': "13,540",
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

    return Scaffold(
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
        profileImageUrl: profilePhoto,
        currentRoute: currentRoute, // This will highlight the current screen
      ),
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: KText(
                    text: "Tracker Your Candidates",
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.titleColor,
                  ),
                ),
                SizedBox(height: 20.h),
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

                      // Date and Export Row
                      Row(
                        spacing: 20.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Filter Button
                          Expanded(
                            child: KAtsGlowButton(
                              text: "Filter",
                              textColor: AppColors.greyColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              icon: SvgPicture.asset(
                                AppAssetsConstants.filterIcon,
                                height: 15,
                                width: 15,
                                fit: BoxFit.contain,
                              ),
                              onPressed: () {
                                print("Filter button tapped");
                              },
                              backgroundColor: AppColors.secondaryColor,
                            ),
                          ),

                          // Export file
                          Expanded(
                            child: KAtsGlowButton(
                              text: "Interview",
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              icon: SvgPicture.asset(
                                AppAssetsConstants.addIcon,
                                height: 15,
                                width: 15,
                                fit: BoxFit.contain,
                              ),
                              onPressed: () {
                                print("Candidates button tapped");
                              },
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      KVerticalSpacer(height: 16.h),

                      // Data Table with paginated data
                      SizedBox(
                        height: 330.h,
                        child: KAtsDataTable(
                          columnHeaders: headers,
                          rowData: paginatedData,
                          showActionsColumn: false,
                          showStatusColumn: false,
                        ),
                      ),

                      // Pagination
                      _buildPageNumbersRow(),

                      SizedBox(height: 16.w),
                      Row(
                        children: [
                          KText(
                            text: entriesDisplayText, // Dynamic entries text
                            fontSize: 12.sp,
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: 40.w),
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
                                    fontSize: 12.sp,
                                    color: AppColors.titleColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Icon(Icons.keyboard_arrow_down, size: 14.sp),
                                ],
                              ),
                            ),
                          ),
                        ],
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
