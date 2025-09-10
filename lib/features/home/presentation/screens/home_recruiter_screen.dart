import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_filled_btn.dart';
import 'package:fuoday/features/auth/presentation/widgets/k_auth_text_form_field.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:fuoday/features/home/presentation/widgets/k_ats_applicatitem.dart';
import 'package:fuoday/features/home/presentation/widgets/k_calendar.dart';
import 'package:fuoday/features/home/presentation/widgets/requirement_stats_card.dart';

class HomeRecruiterScreen extends StatefulWidget {
  const HomeRecruiterScreen({super.key});

  @override
  State<HomeRecruiterScreen> createState() => _HomeRecruiterScreenState();
}

class _HomeRecruiterScreenState extends State<HomeRecruiterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  final TextEditingController dateController = TextEditingController();

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
                            child: KAuthTextFormField(
                              onTap: () {
                                selectDate(context, dateController);
                              },
                              controller: dateController,
                              hintText: "Start Date",
                              keyboardType: TextInputType.datetime,
                              suffixIcon: Icons.date_range,
                            ),
                          ),
                          // Export file
                          Expanded(
                            child: KAuthFilledBtn(
                              text: "Export",
                              icon: Icon(
                                Icons.download_outlined,
                                color: Colors.white,
                                size: 14.sp,
                              ),
                              onPressed: () {},
                              backgroundColor: AppColors.primaryColor,
                              height: 28.h,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                      KVerticalSpacer(height: 16.h),

                      // Filter Field
                      KAuthTextFormField(
                        onTap: () {},
                        hintText: "Filter",
                        keyboardType: TextInputType.text,
                        suffixIcon: Icons.filter_list_outlined,
                      ),

                      KVerticalSpacer(height: 24.h),

                      // Table Headers
                      Container(
                        width: 327.w, // ✅ Outer card width
                        height: 56.h, // ✅ Outer card height
                        color: AppColors.atsHomepageBg,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: KText(
                                text: "Applicant details",
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.greyColor,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: KText(
                                text: "Employee Type",
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.greyColor,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),

                      KVerticalSpacer(height: 16.h),

                      // Applicant List
                      Column(
                        children: [
                          ApplicantItem(
                            name: "Pristia Candra",
                            email: "pristia@gmail.com",
                            employeeType: "Fulltime",
                            avatarColor: Colors.orange,
                          ),
                          KVerticalSpacer(height: 12.h),
                          ApplicantItem(
                            name: "Hanna Baptista",
                            email: "hanna@gmail.com",
                            employeeType: "Contractor",
                            avatarColor: Colors.green,
                          ),
                          KVerticalSpacer(height: 12.h),
                          ApplicantItem(
                            name: "Miracle Geidt",
                            email: "miracle@gmail.com",
                            employeeType: "Freelance",
                            avatarColor: Colors.teal,
                            showInitials: true,
                            initials: "MG",
                          ),
                          KVerticalSpacer(height: 12.h),
                          ApplicantItem(
                            name: "Rayna Torff",
                            email: "rayna@gmail.com",
                            employeeType: "Fulltime",
                            avatarColor: Colors.brown,
                          ),
                          KVerticalSpacer(height: 12.h),
                          ApplicantItem(
                            name: "Giana Lipshutz",
                            email: "giana@gmail.com",
                            employeeType: "Fulltime",
                            avatarColor: Colors.purple,
                          ),
                        ],
                      ),

                      KVerticalSpacer(height: 24.h),

                      // Pagination
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.chevron_left, size: 16.sp),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                              SizedBox(width: 8.w),
                              _buildPageNumber("1", isActive: true),
                              SizedBox(width: 8.w),
                              _buildPageNumber("2"),
                              SizedBox(width: 8.w),
                              _buildPageNumber("3"),
                              SizedBox(width: 8.w),
                              KText(
                                text: "...",
                                fontSize: 12.sp,
                                color: AppColors.greyColor,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(width: 30.w),
                              _buildPageNumber("10"),
                              SizedBox(width: 8.w),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.chevron_right, size: 16.sp),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                            padding: EdgeInsets.all(10.w), // ✅ Padding from Figma
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.77.w, // ✅ Border width
                                color: AppColors.greyColor.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(8.r), // ✅ Border radius
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
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  // Helper method to build page numbers
  Widget _buildPageNumber(String number, {bool isActive = false}) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFFF8F8F8) : Colors.transparent,
        borderRadius: BorderRadius.circular(4.r),
        // border: isActive
        //     ? null
        //     : Border.all(color: AppColors.greyColor.withOpacity(0.3)),
      ),
      child: Center(
        child: KText(
          text: number,
          fontSize: 12.sp,
          color: isActive ? Colors.black : AppColors.titleColor,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}
