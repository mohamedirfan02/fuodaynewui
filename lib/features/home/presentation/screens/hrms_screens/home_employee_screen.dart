import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_app_%20bar_with_drawer.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
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
import 'package:fuoday/features/attendance/presentation/widgets/attendance_line_chart.dart';
import 'package:fuoday/features/home/presentation/provider/check_in_provider.dart';
import 'package:fuoday/features/home/presentation/provider/checkin_status_provider.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart'
    show AtsTotalCountCard;
import 'package:fuoday/features/home/presentation/widgets/k_checkin_button.dart';
import 'package:fuoday/features/home/presentation/widgets/live_timer_widget.dart';
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
                SizedBox(height: 16.h),

                ///Home Cards Widget
                homeCardsWIdget(gridAttendanceData, theme, isDark),
                SizedBox(height: 16.h),
                TimeTrackerContainer(
                  theme: theme,
                  checkinStatusProvider: checkinStatusProvider,
                  checkInProvider: checkInProvider,
                  isDark: isDark,
                  webUserId: webUserId,
                ),
                SizedBox(height: 16.h),

                ///Task Chat
                _taskChatCard(theme, isDark),

                ///Total Time Worked
                SizedBox(height: 16.h),

                ///Total Time Worked Card
                TotalTimeWorkedCard(theme: theme, months: months),
                SizedBox(height: 16.h),

                ///Recent Activity Card
                RecentActivityWidget(),
                SizedBox(height: 16.h),

                ///Announcement Card
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

class TotalTimeWorkedCard extends StatelessWidget {
  const TotalTimeWorkedCard({
    super.key,
    required this.theme,
    required this.months,
  });

  final ThemeData theme;
  final List<String> months;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 320.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5.w,
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: theme.secondaryHeaderColor.withValues(alpha: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 20.h,
                      width: 23.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5.w,
                          color:
                              theme.textTheme.bodyLarge?.color?.withValues(
                                alpha: 0.3,
                              ) ??
                              AppColors.greyColor,
                        ),
                        borderRadius: BorderRadius.circular(5.r),
                        color: theme.secondaryHeaderColor.withValues(alpha: 1),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.access_time_outlined,
                          size: 16,
                          color: theme
                              .textTheme
                              .bodyLarge
                              ?.color, //AppColors.greyColor,,
                        ),
                      ),
                    ),
                    KHorizontalSpacer(width: 5.w),
                    KText(
                      text: "Total Time worked",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.more_vert,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
            // KText(
            //   text: "13h 32m 09s +1.5%",
            //   fontWeight: FontWeight.w500,
            //   fontSize: 12.sp,
            // ),
            KVerticalSpacer(height: 10.h),
            Align(
              alignment: Alignment.centerLeft,

              child: RichText(
                text: TextSpan(
                  children: [
                    // Total value
                    TextSpan(
                      text: "13h 32m 09s",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                        color: theme
                            .textTheme
                            .headlineLarge
                            ?.color, //AppColors.titleColor,,
                      ),
                    ),

                    // Gap
                    const WidgetSpan(
                      child: SizedBox(width: 6), // you can adjust
                    ),
                    TextSpan(
                      text: "+1.5%",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 10.sp,
                        color:
                            AppColors.inReviewedColor, //AppColors.titleColor,,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),

            // Chart
            SizedBox(
              height: 300.h,
              child: AttendanceLineChart(
                showHourSuffix: true,
                attendanceValues: [10, 8, 6, 4, 2, 0, 5],
                months: months,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeTrackerContainer extends StatelessWidget {
  const TimeTrackerContainer({
    super.key,
    required this.theme,
    required this.checkinStatusProvider,
    required this.checkInProvider,
    required this.isDark,
    required this.webUserId,
  });

  final ThemeData theme;
  final CheckinStatusProvider checkinStatusProvider;
  final CheckInProvider checkInProvider;
  final bool isDark;
  final int webUserId;

  @override
  Widget build(BuildContext context) {
    void _showLocationSwitchDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final theme = Theme.of(context);

          String? selectedLocation;

          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                title: KText(
                  text: "Switch Location",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    KText(
                      text: "Select your working mode",
                      fontSize: 14.sp,
                      color: theme
                          .inputDecorationTheme
                          .focusedBorder
                          ?.borderSide
                          .color,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 16.h),

                    // Remote Button
                    InkWell(
                      onTap: () {
                        setState(() => selectedLocation = "Remote");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: selectedLocation == "Remote"
                                ? theme.primaryColor
                                : theme.dividerColor,
                            width: 1.2,
                          ),
                        ),
                        child: KText(
                          text: "Remote",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: selectedLocation == "Remote"
                              ? theme.primaryColor
                              : theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Office Button
                    InkWell(
                      onTap: () {
                        setState(() => selectedLocation = "Office");
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: selectedLocation == "Office"
                                ? theme.primaryColor
                                : theme.dividerColor,
                            width: 1.2,
                          ),
                        ),
                        child: KText(
                          text: "Office",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: selectedLocation == "Office"
                              ? theme.primaryColor
                              : theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                    ),
                  ],
                ),

                actions: [
                  // Cancel
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: KText(
                      text: "Cancel",
                      color: theme
                          .inputDecorationTheme
                          .focusedBorder
                          ?.borderSide
                          .color,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),

                  // Confirm
                  TextButton(
                    onPressed: selectedLocation == null
                        ? null
                        : () {
                            Navigator.pop(context);
                            // 🔹 No API — only message
                            KSnackBar.success(
                              context,
                              "$selectedLocation Mode Selected",
                            );
                          },
                    child: KText(
                      text: "Confirm",
                      color: selectedLocation == null
                          ? theme.disabledColor
                          : theme.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    String selectedLocation = "Remote"; // default text

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5.w,
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ),
        borderRadius: BorderRadius.circular(12.r),
        color: theme.secondaryHeaderColor.withValues(alpha: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Column(
          children: [
            //Top Contents
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 20.h,
                      width: 23.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5.w,
                          color:
                              theme.textTheme.bodyLarge?.color?.withValues(
                                alpha: 0.3,
                              ) ??
                              AppColors.greyColor,
                        ),
                        borderRadius: BorderRadius.circular(5.r),
                        color: theme.secondaryHeaderColor.withValues(alpha: 1),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssetsConstants.timeTrackerIcon,
                          width: 12.w,
                          height: 12.w,
                          colorFilter: ColorFilter.mode(
                            theme.textTheme.headlineLarge?.color?.withValues(
                                  alpha: 0.5,
                                ) ??
                                Colors.black,
                            BlendMode.srcIn,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    KHorizontalSpacer(width: 5.w),
                    KText(
                      text: "Time Tracker",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ],
                ),
                Container(
                  height: 25.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5.w,
                      color:
                          theme.textTheme.bodyLarge?.color?.withValues(
                            alpha: 0.3,
                          ) ??
                          AppColors.greyColor,
                    ),
                    borderRadius: BorderRadius.circular(5.r),
                    color: theme.secondaryHeaderColor.withValues(alpha: 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.0.w),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 20,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                        KHorizontalSpacer(width: 5.w),
                        KText(
                          text: "History",
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            KVerticalSpacer(height: 16.h),
            //Check In Button Part
            Container(
              height: 170.h,
              width: double.infinity,
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
                color: theme.secondaryHeaderColor.withValues(alpha: 1),
              ),
              child: Column(
                children: [
                  Container(
                    height: 25.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 0.5.w,
                          color:
                              theme.textTheme.bodyLarge?.color?.withValues(
                                alpha: 0.3,
                              ) ??
                              AppColors.greyColor,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                      ),
                      color: theme.textTheme.bodyLarge?.color?.withValues(
                        alpha: 0.1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssetsConstants.logo,
                          width: 30.w,
                          height: 30.h,
                        ),
                        KText(
                          text: "Fuoday.com",
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ],
                    ),
                  ),
                  KVerticalSpacer(height: 16.h),
                  Container(
                    height: 25.h,
                    width: 133.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5.w,
                        color:
                            theme.textTheme.bodyLarge?.color?.withValues(
                              alpha: 0.3,
                            ) ??
                            AppColors.greyColor,
                      ),
                      borderRadius: BorderRadius.circular(5.r),
                      color: theme.textTheme.bodyLarge?.color?.withValues(
                        alpha: 0.1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0.w),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 20,
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                          KHorizontalSpacer(width: 5.w),
                          KText(
                            text: "Mon, 23 Apr 2025",
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  KVerticalSpacer(height: 10.h),

                  ///  LiveTimerDisplay widget
                  LiveTimerDisplay(
                    checkinStatusProvider: checkinStatusProvider,
                    checkInProvider: checkInProvider,
                    theme: theme,
                  ),

                  KVerticalSpacer(height: 10.h),

                  /// Check-in/out button
                  checkinStatusProvider.isLoading
                      ? CircularProgressIndicator(
                          color: theme.primaryColor,
                          strokeWidth: 2.5,
                        )
                      : KCheckInButton(
                          textColor: theme.secondaryHeaderColor,
                          text: checkInProvider.isLoading
                              ? "Loading..."
                              : (checkinStatusProvider.isCurrentlyCheckedIn ||
                                    checkInProvider.isCheckedIn)
                              ? "Clock Out"
                              : "Clock In",
                          fontSize: 10.sp,
                          height: 25.h,
                          width: 125.w,
                          backgroundColor: checkInProvider.isLoading
                              ? Colors.grey
                              : (checkinStatusProvider.isCurrentlyCheckedIn ||
                                    checkInProvider.isCheckedIn)
                              ? isDark
                                    ? AppColors.checkOutColorDark
                                    : AppColors.checkOutColor
                              : isDark
                              ? AppColors.checkInColorDark
                              : AppColors.newCheckInColor.withValues(
                                  alpha: 0.7,
                                ),
                          onPressed: checkInProvider.isLoading
                              ? null
                              : () async {
                                  final now = DateTime.now().toIso8601String();
                                  if (checkinStatusProvider
                                          .isCurrentlyCheckedIn ||
                                      checkInProvider.isCheckedIn) {
                                    await context.checkInProviderRead
                                        .handleCheckOut(
                                          userId: webUserId,
                                          time: now,
                                        );
                                    checkInProvider.stopWatchTimer
                                        .onStopTimer();
                                    AppLoggerHelper.logInfo(
                                      "Check Out Web User Id: $webUserId",
                                    );
                                  } else {
                                    await context.checkInProviderRead
                                        .handleCheckIn(
                                          userId: webUserId,
                                          time: now,
                                        );
                                    AppLoggerHelper.logInfo(
                                      "Check In Web User Id: $webUserId",
                                    );
                                    checkInProvider.stopWatchTimer
                                        .onResetTimer();
                                    checkInProvider.stopWatchTimer
                                        .onStartTimer();
                                  }
                                  if (webUserId > 0) {
                                    await context.checkinStatusProviderRead
                                        .fetchCheckinStatus(webUserId);
                                  }
                                },
                        ),
                ],
              ),
            ),
            KVerticalSpacer(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    KText(
                      text: "Clock In",
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    KVerticalSpacer(height: 10.h),
                    Icon(Icons.login),
                    KText(
                      text: checkinStatusProvider.formattedCheckinTime,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ],
                ),
                Column(
                  children: [
                    KText(
                      text: "Location",
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    KVerticalSpacer(height: 15.h),

                    InkWell(
                      onTap: () {
                        _showLocationSwitchDialog(context); // show dialog
                      },
                      child: Container(
                        height: 25.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5.w,
                            color:
                                theme.textTheme.bodyLarge?.color?.withValues(
                                  alpha: 0.3,
                                ) ??
                                AppColors.greyColor,
                          ),
                          borderRadius: BorderRadius.circular(5.r),
                          color: theme.textTheme.bodyLarge?.color?.withValues(
                            alpha: 0.1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5.0.w,
                            horizontal: 10.w,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssetsConstants.locationIcon,
                                width: 12.w,
                                height: 12.w,
                                colorFilter: ColorFilter.mode(
                                  theme.textTheme.headlineLarge?.color
                                          ?.withValues(alpha: 0.5) ??
                                      Colors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                              KHorizontalSpacer(width: 5.w),
                              KText(
                                text: selectedLocation, // 🔥 changes here only
                                fontWeight: FontWeight.w500,
                                fontSize: 10.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    KText(
                      text: "Clock Out",
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                    KVerticalSpacer(height: 10.h),
                    Icon(Icons.logout),
                    KText(
                      text: checkinStatusProvider.formattedCheckoutTime,
                      fontWeight: FontWeight.w500,
                      fontSize: 10.sp,
                    ),
                  ],
                ),
              ],
            ),
            KVerticalSpacer(height: 5.h),
          ],
        ),
      ),
    );
  }
}

class RecentActivityWidget extends StatelessWidget {
  const RecentActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //s  final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: theme.secondaryHeaderColor, //AppColors.secondaryColor
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ), //BORDER COLOR
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 20.h,
                    width: 23.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5.w,
                        color:
                            theme.textTheme.bodyLarge?.color?.withValues(
                              alpha: 0.3,
                            ) ??
                            AppColors.greyColor,
                      ),
                      borderRadius: BorderRadius.circular(5.r),
                      color: theme.secondaryHeaderColor.withValues(alpha: 1),
                    ),
                    child: Center(
                      child: Image.asset(
                        AppAssetsConstants.recentActivityImage,
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ),
                  KHorizontalSpacer(width: 5.w),
                  KText(
                    text: "Recent activity",
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.more_vert,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Main Items Container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color:
                    theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
                    AppColors.greyColor,
              ),
            ),
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                activityBlock(
                  title: "Juyed Ahmed’s List",
                  tasks: [
                    ("Netify SaaS Real estate", "In Juyed Ahmed’s List"),
                    ("Netify SaaS Real estate", "In Juyed Ahmed’s List"),
                  ],
                  context: context,
                ),
                SizedBox(height: 16.h),
                activityBlock(
                  title: "Pixem’s Project",
                  tasks: [("MatexAI Meeting Assistance", "In Project 11")],
                  context: context,
                ),
                SizedBox(height: 16.h),
                activityBlock(
                  title: "Pixem’s Project",
                  tasks: [("Clinscey Task Management", "In Project 11")],
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget activityBlock({
    required String title,
    required List<(String, String)> tasks,
    required BuildContext context,
  }) {
    //App Theme Data
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.format_list_bulleted,
              size: 20,
              color: theme.textTheme.bodyLarge?.color,
            ),
            SizedBox(width: 6.w),
            Text(
              title,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Icon(Icons.more_vert, color: theme.textTheme.bodyLarge?.color),
          ],
        ),
        const SizedBox(height: 10),
        for (var (taskTitle, taskSub) in tasks) ...[
          taskTile(taskTitle, taskSub, context),
          const SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget taskTile(String title, String subtitle, BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ), //BORDER COLOR),
        borderRadius: BorderRadius.circular(8),
        // color: const Color(0xfff8f8f8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 8,
            backgroundColor: theme.textTheme.bodyLarge?.color?.withValues(
              alpha: 0.2,
            ), //AppColors.greyColor,
            child: const CircleAvatar(
              radius: 5,
              backgroundColor: Colors.orange,
            ),
          ),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(
              " •  $subtitle",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
//====================Announcement

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: theme.secondaryHeaderColor, //AppColors.secondaryColor
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ), //BORDER COLOR
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            children: [
              Container(
                height: 20.h,
                width: 23.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5.w,
                    color:
                        theme.textTheme.bodyLarge?.color?.withValues(
                          alpha: 0.3,
                        ) ??
                        AppColors.greyColor,
                  ),
                  borderRadius: BorderRadius.circular(5.r),
                  color: theme.secondaryHeaderColor.withValues(alpha: 1),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssetsConstants.miceIcon,
                    width: 15.w,
                    height: 15.w,
                    colorFilter: ColorFilter.mode(
                      theme.textTheme.headlineLarge?.color?.withValues(
                            alpha: 0.5,
                          ) ??
                          Colors.black,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              KText(
                text: "Announcement",
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
              const Spacer(),
              Icon(Icons.more_vert, size: 20.sp),
            ],
          ),
          SizedBox(height: 16.h),

          // Announcement List
          announcementTile(
            img: AppAssetsConstants.celebRationIcon,
            title: "Diwali Celebration Event",
            subtitle:
                "We are excited to celebrate Diwali at the office! ......",
            showBadge: true,

            context: context,
          ),
          SizedBox(height: 12.h),
          announcementTile(
            img: AppAssetsConstants.systemIcon,
            title: "System Maintenance Alert",
            subtitle: "HRMS portal will be temporarily unavailable from ...",
            context: context,
          ),
          SizedBox(height: 12.h),
          announcementTile(
            img: AppAssetsConstants.micIconII,
            title: "Team Outing Announcement",
            subtitle: "A fun-filled team outing is planned to Wonderla!",
            context: context,
          ),
          SizedBox(height: 12.h),
          announcementTile(
            img: AppAssetsConstants.celebRationIcon,
            title: "Netify SaaS Real estate",
            subtitle: "In Juyed Ahmed’s List",
            context: context,
          ),
        ],
      ),
    );
  }

  Widget announcementTile({
    required String img,
    required String title,
    required String subtitle,
    bool showBadge = false,
    required BuildContext context,
  }) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ), //BORDER COLOR
        // color: Colors.white,
      ),
      child: Row(
        children: [
          // ⬇⬇ Updated SVG with circle + badge ⬇⬇
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 48.w,
                width: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        theme.textTheme.bodyLarge?.color?.withValues(
                          alpha: 0.3,
                        ) ??
                        AppColors.greyColor,
                  ),
                ),
                padding: EdgeInsets.all(10.w),
                child: _buildImage(img),
              ),

              if (showBadge)
                Positioned(
                  right: -1,
                  bottom: -1,
                  child: Container(
                    height: 13.w,
                    width: 13.w,
                    decoration: BoxDecoration(
                      color: AppColors.inProgressColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.secondaryHeaderColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // ⬆⬆ End of SVG + Badge UI ⬆⬆
          SizedBox(width: 12.w),

          // Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: title,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3.h),
                KText(
                  text: subtitle,
                  fontSize: 12.sp,
                  color: Colors.grey,
                  maxLines: 1,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),

          Icon(Icons.arrow_forward_ios_rounded, size: 18.sp),
        ],
      ),
    );
  }

  Widget _buildImage(String img) {
    // Check whether image is SVG
    if (img.toLowerCase().endsWith(".svg")) {
      return SvgPicture.asset(img, fit: BoxFit.contain);
    } else {
      return Image.asset(img, fit: BoxFit.contain);
    }
  }
}
