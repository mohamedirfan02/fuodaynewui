import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/commons/widgets/k_filter_button.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:fuoday/features/home/presentation/widgets/k_application_table.dart';
import 'package:fuoday/features/home/presentation/widgets/k_ats_applicatitem.dart';
import 'package:fuoday/features/home/presentation/widgets/k_calendar.dart';
import 'package:fuoday/features/home/presentation/widgets/requirement_stats_card.dart';

import '../../../../core/constants/assets/app_assets_constants.dart';

class HomeRecruiterScreen extends StatefulWidget {
  const HomeRecruiterScreen({super.key});

  @override
  State<HomeRecruiterScreen> createState() => _HomeRecruiterScreenState();
}

class _HomeRecruiterScreenState extends State<HomeRecruiterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController dateController = TextEditingController();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  int get totalPages => (applicantsData.length / itemsPerPage).ceil();

  int pageWindowStart = 1; // first page in current window
  int pageWindowSize = 5;  // show 5 numbers at a time

  // Pagination state
  int currentPage = 1;
  int itemsPerPage = 6; // Change this to show how many items per page

  List<Map<String, dynamic>> get paginatedApplicants {
    int totalPages = (applicantsData.length / itemsPerPage).ceil();

    // Ensure currentPage is within range
    if (currentPage > totalPages) currentPage = totalPages;
    if (currentPage < 1) currentPage = 1;

    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    if (startIndex >= applicantsData.length) return []; // safe guard
    if (endIndex > applicantsData.length) endIndex = applicantsData.length;

    return applicantsData.sublist(startIndex, endIndex);
  }

  List<Map<String, dynamic>> applicantsData = [
    {
      'name': 'Pristia Candra',
      'email': 'pristia@gmail.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '01 May 2025',
      'avatarColor': AppColors.primaryColor,
    },
    {
      'name': 'Hanna Baptista',
      'email': 'hanna@gmail.com',
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
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
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
      'avatarColor': AppColors.secondaryColor,
    },
    {
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.greyColor,
    },
    {
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authTextFieldSuffixIconColor,
    },
    {
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.unactive,
    },
    {
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.pending,
    },
    {
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.checkInColor,
    },
    {
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authUnderlineBorderColor,
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
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
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
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
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
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
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
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
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
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },
    {
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },{
      'name': 'Skylar Herwitz',
      'email': 'skylar@unpixel.com',
      'phone': '08092139441',
      'cv': 'cv.pdf',
      'createdDate': '02 May 2025',
      'avatarColor': AppColors.authBackToLoginColor,
    },
    // Add more items...
  ];

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

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Safe extraction of employee details
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No Email";

    // Grid Attendance Data
    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'icon': Icons.person,
        'title': 'Total Opening Position',
        'numberOfCount': "3,540",
        'growth': "+5.1%",
      },
      {
        'title': 'Total Closed Position',
        'numberOfCount': "1,540",
        'growth': "+5.1%",
        'icon': Icons.person,
      },
      {
        'title': 'Total Employee',
        'numberOfCount': "500",
        'growth': "+5.1%",
        'icon': Icons.person,
      },
      {
        'title': 'Shortlisted',
        'numberOfCount': "1,504",
        'growth': "+5.1%",
        'icon': Icons.person,
      },
      {
        'title': 'On Hold',
        'numberOfCount': "562",
        'growth': "+5.1%",
        'icon': Icons.person,
      },
      {
        'title': 'Onboarding',
        'numberOfCount': "850",
        'growth': "+5.1%",
        'icon': Icons.person,
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
      drawer: KDrawer(
        userEmail: email,
        userName: name,
        profileImageUrl: profilePhoto,
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
              // ✅ FIX: wrap multiple children
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: 155 / 113, // ✅ matches Figma
                  ),
                  itemCount: gridAttendanceData.length,
                  itemBuilder: (context, index) {
                    final item = gridAttendanceData[index];
                    return AtsTotalCountCard(
                      attendanceCount: item['numberOfCount'].toString(),
                      attendanceCardIcon: item['icon'],
                      attendanceDescription: item['title'],
                      attendanceIconColor: AppColors.primaryColor,
                      attendancePercentageColor: AppColors.checkInColor,
                      growthText: item['growth'],
                    );
                  },
                ),

                SizedBox(height: 24.h),

                RequirementStatsCard(
                  dataMap: {"Pending": 36, "Unactive": 6, "Closed": 13},
                  colorMap: {
                    "Pending": AppColors.pending,
                    "Unactive": AppColors.unactive,
                    "Closed": AppColors.closed,
                  },
                ),
                SizedBox(height: 24.h),
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
                            text: "Applicant details",
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
                          // Start Date
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.atsHomepageBg, // background
                                borderRadius: BorderRadius.circular(8.r), // rounded corners
                                border: Border.all(
                                  color: Colors.grey.shade300, // border color
                                  width: 1, // border width
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1), // shadow color
                                    blurRadius: 6, // softness
                                    offset: const Offset(0, 3), // horizontal, vertical shadow offset
                                  ),
                                ],
                              ),
                              child: KAuthFilledBtn(
                                text: "Date",
                                fontWeight: FontWeight.w600,
                                textColor: AppColors.greyColor,
                                icon: SvgPicture.asset(
                                  AppAssetsConstants.dateIcon,
                                  height: 16.67.h,
                                  width: 15.w,
                                  fit: BoxFit.contain,
                                ),
                                onPressed: () {
                                  selectDate(context, dateController);
                                },
                                backgroundColor: Colors.transparent, // transparent since Container has bg
                                height: 28.h,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),

                          // Export file
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.atsHomepageBg, // background
                                borderRadius: BorderRadius.circular(10.r), // rounded corners
                                border: Border.all(
                                  color: Colors.grey.shade300, // border color
                                  width: 1, // border width
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColor.withOpacity(0.1), // shadow color
                                    blurRadius: 6, // softness
                                    offset: const Offset(0, 3), // horizontal, vertical shadow offset
                                  ),
                                ],
                              ),
                              child: KAuthFilledBtn(
                                text: "Export",
                                icon: SvgPicture.asset(
                                  AppAssetsConstants.downloadIcon,
                                  // Replace with your delete SVG
                                  height: 16.67.h,
                                  width: 15.w,
                                  fit: BoxFit.contain,
                                  color: Colors.white, // Optional: tint the SVG
                                ),
                                onPressed: () {},
                                backgroundColor: AppColors.primaryColor,
                                height: 28.h,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      KVerticalSpacer(height: 16.h),

                      // Filter Field
                      KFilterBtn(
                        text: "Filter",
                        textColor: Colors.black,
                        backgroundColor: Colors.white,
                        borderColor: const Color.fromRGBO(233, 234, 236, 1),
                        borderRadius: BorderRadius.circular(10.r),
                        onPressed: () {
                          print("Filter pressed");
                        },
                        icon: SvgPicture.asset(
                          AppAssetsConstants.filterIcon,
                          height: 16.h,
                          width: 16.w,
                          color: Colors.black,
                        ),
                      ),





                      KVerticalSpacer(height: 24.h),

                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: ApplicantTable(
                      //     applicants: applicantsData, // ✅ just pass your list
                      //     itemsPerPage: 6, // optional
                      //   ),
                      // ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            ApplicantItem.buildHeader(),
                            // 👈 header from same file
                            SizedBox(height: 16.h),
                            Column(
                              children: paginatedApplicants.map((applicant) {
                                return ApplicantItem(
                                  name: applicant['name'],
                                  email: applicant['email'],
                                  phoneNumber: applicant['phone'],
                                  cv: applicant['cv'],
                                  createdDate: applicant['createdDate'],
                                  avatarColor: applicant['avatarColor'],
                                  showInitials: true,
                                  initials: applicant['name']
                                      .substring(0, 2)
                                      .toUpperCase(),
                                  onStageChanged: (newStage) {
                                    print(
                                      "${applicant['name']} stage changed to $newStage",
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),


                      KVerticalSpacer(height: 24.h),

                      // Pagination
                      _buildPageNumbersRow(),

                      SizedBox(height: 16.w),
                      Row(
                        children: [
                          KText(
                            text: "Showing 1 to 8 of 50 entries",
                            fontSize: 12.sp,
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: 40.w),
                          Container(
                            padding: EdgeInsets.all(10.w),
                            // ✅ Padding from Figma
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.77.w, // ✅ Border width
                                color: AppColors.greyColor.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                              // ✅ Border radius
                              color: AppColors.secondaryColor,
                            ),
                            child: Row(
                              children: [
                                KText(
                                  text: "Show 8",
                                  fontSize: 12.sp,
                                  color: AppColors.titleColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                Icon(Icons.keyboard_arrow_up, size: 14.sp),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.w),

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      CalendarHeader(),

                      SizedBox(height: 20.h),

                      // TODAY Section
                      TodaySection(),

                      SizedBox(height: 24.h),

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

  Widget _buildPageNumbersRow() {
    int windowEnd = (pageWindowStart + pageWindowSize - 1);
    if (windowEnd > totalPages) windowEnd = totalPages;

    List<Widget> pageButtons = [];

    // Previous window arrow
    pageButtons.add(IconButton(
      icon: Icon(Icons.chevron_left, size: 16.sp),
      onPressed: pageWindowStart > 1
          ? () {
        setState(() {
          pageWindowStart -= pageWindowSize;
          currentPage = pageWindowStart;
        });
      }
          : null,
    ));

    // Page numbers
    for (int i = pageWindowStart; i <= windowEnd; i++) {
      pageButtons.add(Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: _buildPageNumber(i),
      ));
    }

    // Next window arrow
    pageButtons.add(IconButton(
      icon: Icon(Icons.chevron_right, size: 16.sp),
      onPressed: windowEnd < totalPages
          ? () {
        setState(() {
          pageWindowStart += pageWindowSize;
          currentPage = pageWindowStart;
        });
      }
          : null,
    ));

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
}
