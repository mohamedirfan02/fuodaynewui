import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_%20bar_with_drawer.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/secure_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:fuoday/features/home/presentation/widgets/new_ui_widgets/announcement_card_widget.dart';
import 'package:fuoday/features/home/presentation/widgets/new_ui_widgets/recent_activity_card_widget.dart';
import 'package:fuoday/features/home/presentation/widgets/new_ui_widgets/time_tracker_card_widget.dart';
import 'package:fuoday/features/home/presentation/widgets/new_ui_widgets/total_time_worked_card_widget.dart';
import 'package:fuoday/features/home/presentation/widgets/requirement_stats_card.dart';
import 'package:intl/intl.dart';

class HomeEmployeeScreen extends StatefulWidget {
  const HomeEmployeeScreen({super.key});

  @override
  State createState() => _HomeEmployeeScreenState();
}

class _HomeEmployeeScreenState extends State<HomeEmployeeScreen> {
  // Scaffold Key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // Auth Token
  String? authToken;

  @override
  void initState() {
    super.initState();
    loadAuthToken();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  void _initializeData() {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final int webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    // Fetch events
    context.allEventsProviderRead.fetchAllEvents();

    // Fetch checkin status
    if (webUserId > 0) {
      context.checkinStatusProviderRead.fetchCheckinStatus(webUserId);
    }
  }

  Future<void> loadAuthToken() async {
    try {
      final secureStorageService = getIt<SecureStorageService>();
      authToken = await secureStorageService.getToken();
      AppLoggerHelper.logInfo("Auth Token: $authToken");
      if (authToken != null) {
        DioService().updateAuthToken(authToken!);
      }
    } catch (e) {
      AppLoggerHelper.logInfo("Auth Token error: $e");
    }
  }

  // Time Formatting
  String formatIsoTime(String? isoString) {
    if (isoString == null) return "00:00:00";
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      final formatted = DateFormat('h:mm:ss a').format(dateTime);
      AppLoggerHelper.logInfo("Formatted Time for $isoString → $formatted");
      return formatted;
    } catch (e) {
      AppLoggerHelper.logError("Time format error: $e");
      return "00:00:00";
    }
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final checkInProvider = context.checkInProviderWatch;
    final checkinStatusProvider = context.checkinStatusProviderWatch;

    // Get employee details from Hive with error handling
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Safe extraction of employee details
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final empId = employeeDetails?['empId'] ?? "No Employee ID";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No Email";
    final int webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    // Debugging Logger
    AppLoggerHelper.logInfo("Employee Details: $employeeDetails");
    AppLoggerHelper.logInfo(
      "Has Employee Details: ${hiveService.hasEmployeeDetails}",
    );
    // Sample attendance data for chart (you can replace with real data)

    final months = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    // Grid Attendance Data - Updated with dynamic counts
    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
        'title': 'Total Opening Position',
        'numberOfCount': "3,540",
        'growth': "+5.1%",
        'backgroundImage': AppAssetsConstants.homeCard1,
      },
      {
        'title': 'Total Closed Position',
        'numberOfCount': "1,540",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
        'backgroundImage': AppAssetsConstants.homeCard2,
      },
      {
        'title': 'Total Employee',
        'numberOfCount': "500",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
        'backgroundImage': AppAssetsConstants.homeCard3,
      },
      {
        'title': 'Shortlisted',
        'numberOfCount': "1,504",
        'growth': "+5.1%",
        'icon': AppAssetsConstants.atsUserIcon, // ✅ SVG path
        'backgroundImage': AppAssetsConstants.homeCard4,
      },
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      key: _scaffoldKey,
      appBar: KAppBarWithDrawer(
        userName: name,
        cachedNetworkImageUrl: profilePhoto,
        userDesignation: designation,
        showUserInfo: false,
        onDrawerPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onNotificationPressed: () {},
      ),
      drawer: KDrawer(
        userEmail: email,
        userName: name,
        profileImageUrl: profilePhoto,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            context.allEventsProviderRead.fetchAllEvents(forceRefresh: true),
            if (webUserId > 0)
              context.checkinStatusProviderRead.fetchCheckinStatus(webUserId),
          ]);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                //User Details
                Row(
                  spacing: 20.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KCircularCachedImage(imageUrl: profilePhoto, size: 90.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: name,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                        KText(
                          text: "Employee Id: $empId",
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                        KText(
                          text: email,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ],
                ),
                KVerticalSpacer(height: 16.h),

                ///Home Cards Widget
                homeCardsWIdget(gridAttendanceData, theme, isDark),
                KVerticalSpacer(height: 16.h),
                TimeTrackerContainer(
                  theme: theme,
                  checkinStatusProvider: checkinStatusProvider,
                  checkInProvider: checkInProvider,
                  isDark: isDark,
                  webUserId: webUserId,
                ),
                KVerticalSpacer(height: 16.h),
                //Task Chat
                _taskChatCard(theme, isDark),
                //Total Time Worked
                KVerticalSpacer(height: 16.h),
                //Total Time Worked Card
                TotalTimeWorkedCard(theme: theme, months: months),
                SizedBox(height: 16.h),
                //Recent Activity Card
                RecentActivityWidget(),
                KVerticalSpacer(height: 16.h),
                //Announcement Card
                AnnouncementWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GridView homeCardsWIdget(
    List<Map<String, dynamic>> gridAttendanceData,
    ThemeData theme,
    bool isDark,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 145 / 113,
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
    );
  }

  Container _taskChatCard(ThemeData theme, bool isDark) {
    return Container(
      //s height: 320.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5.w,
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(12.r),
        //  color: theme.secondaryHeaderColor.withValues(alpha: 1),
        image: DecorationImage(
          image: AssetImage(AppAssetsConstants.chartBgImage),
          fit: BoxFit.cover,
          // opacity: isDark ? 0.7 : 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: "Task Chat",
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.secondaryColor,
                  ),
                  // KVerticalSpacer(height: 10.h),
                  KText(
                    text: "View your all task states ",
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: AppColors.secondaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              height: 30.h,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5.w,
                  color:
                      theme.textTheme.bodyLarge?.color?.withValues(
                        alpha: 0.3,
                      ) ??
                      AppColors.greyColor,
                ),
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.secondaryColorDark,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? AppColors.pendingColorDark
                          : AppColors.pending,
                    ),
                  ),
                  KHorizontalSpacer(width: 5.w),
                  KText(
                    text: "43 Task",
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: AppColors.secondaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),

            KPieChart(
              dataMap: {
                "To do ": 36,
                "In Progress ": 6,
                "Closed": 13,
                "Test": 28,
              },
              colorMap: {
                "To do ": isDark ? AppColors.todoColor : AppColors.todoColor,
                "In Progress ": isDark
                    ? AppColors.inProgressColor
                    : AppColors.inProgressColor,
                "In Reviewed": isDark
                    ? AppColors.inReviewedColor
                    : AppColors.inReviewedColor,
                "Completed": isDark
                    ? AppColors.completedColor
                    : AppColors.completedColor,
              },
            ),

            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(right: 16.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLegendItem(
                        "To do",
                        isDark ? AppColors.todoColor : AppColors.todoColor,
                      ),
                      buildLegendItem(
                        "In Progress",
                        isDark
                            ? AppColors.inProgressColor
                            : AppColors.inProgressColor,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLegendItem(
                        "In Reviewed",
                        isDark
                            ? AppColors.inReviewedColor
                            : AppColors.inReviewedColor,
                      ),
                      buildLegendItem(
                        "Completed",
                        isDark
                            ? AppColors.completedColor
                            : AppColors.completedColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLegendItem(String label, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 10.h,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          KHorizontalSpacer(width: 10.w),
          KText(
            text: label,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: AppColors.secondaryColor,
          ),
        ],
      ),
    );
  }
}
