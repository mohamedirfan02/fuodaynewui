import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/attendance/presentation/widgets/attendance_card.dart';
import 'package:fuoday/features/team_leader/presentation/widget/TL_attendance_card.dart';
import 'package:go_router/go_router.dart';

class TeamLeaderScreen extends StatefulWidget {
  const TeamLeaderScreen({super.key});

  @override
  State<TeamLeaderScreen> createState() => _TeamLeaderScreenState();
}

class _TeamLeaderScreenState extends State<TeamLeaderScreen> {
  final _key = GlobalKey<ExpandableFabState>();

  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;
  late final String name;
  late final int webUserId;

  @override
  void initState() {
    super.initState();

    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    name = employeeDetails?['name'] ?? "No Name";
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '') ?? 0;

    //  Fetch all required data in one microtask
    Future.microtask(() {
      final ctx = context;

      ctx.roleWiseAttendanceReportProviderRead.fetchAllRoleAttendance(
        webUserId,
      );
      // Role-based users
      ctx.roleBasedUsersProviderRead.fetchRoleBasedUsers(webUserId);

      // Late arrivals
      ctx.allRoleLateArrivalsReportProviderRead.fetchLateArrivals();

      // Leave requests
      ctx.allLeaveRequestProviderRead.fetchAllLeaveRequests("approved");

      // Regulations
      ctx.allRegulationsProviderRead.fetchAllRegulations(webUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);
    // Total Attendance Details Provider

    final roleBasedProvider = context.roleBasedUsersProviderWatch;
    final attendanceReportProvider =
        context.roleWiseAttendanceReportProviderWatch;
    final regulationsProvider = context.allRegulationsProviderWatch;
    final lateArrivalsProvider = context.allRoleLateArrivalsReportProviderWatch;
    final leaveRequestsProvider = context.allLeaveRequestProviderWatch;

    // 🔹 Role-based users data
    final roleBasedUsers = roleBasedProvider.roleBasedUsers;
    final totalEmployees = roleBasedUsers?.teams.totalCount ?? 0;

    // 🔹 Attendance report data
    final attendanceReport = attendanceReportProvider.attendanceReport;
    final totalAttendanceCount = attendanceReport?.teamSection.totalCount ?? 0;

    // 🔹 Late arrivals data
    final lateArrivals = lateArrivalsProvider.lateArrivals;
    final totalLateArrivals = lateArrivals?.teamSection.totalCount ?? 0;

    // 🔹 Leave requests data
    final leaveRequests = leaveRequestsProvider.leaveRequests;
    final totalLeaveRequests = leaveRequests?.teamSection?.totalCount ?? 0;

    // 🔹 Regulations data
    final totalRegulationApprovals = regulationsProvider.teamTotalCount;
    //  Today’s date formatted like your API (e.g., 2025-11-05)
    final today = DateTime.now();
    final todayStr =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    //  Filter only today’s records where employee is “present” (not on leave)
    final todayAttendanceList =
        attendanceReport?.teamSection.data
            ?.where(
              (att) =>
                  att.date == todayStr &&
                  att.status != "On Leave" &&
                  att.checkin != null,
            )
            .toList() ??
        [];

    // Count how many employees attended today
    final todayAttendanceCount = todayAttendanceList.length;

    // 🔹 Grid data
    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'title': 'Total Employees',
        'numberOfCount': totalEmployees,
        'icon': Icons.person,
      },
      {
        'title': 'Total Attendance Report',
        'numberOfCount': "$todayAttendanceCount/$totalEmployees",
        'icon': Icons.speaker_notes_rounded,
      },
      {
        'title': 'Late Arrival',
        'numberOfCount': totalLateArrivals,
        'icon': Icons.access_time,
      },
      {
        'title': 'Total Leave Request',
        'numberOfCount': totalLeaveRequests,
        'icon': Icons.leave_bags_at_home,
      },
      {
        'title': 'Regulation Approval',
        'numberOfCount': totalRegulationApprovals,
        'icon': Icons.approval,
      },

      // {
      //   'title': 'Permission Taken',
      //   'numberOfCount':
      //       totalAttendanceDetailsProvider
      //           .attendanceDetails
      //           ?.data
      //           ?.totalPermission ??
      //       0,
      //   'icon': Icons.person,
      // },
    ];
    final isLoading =
        roleBasedProvider.isLoading ||
        attendanceReportProvider.isLoading ||
        regulationsProvider.isLoading ||
        lateArrivalsProvider.isLoading ||
        leaveRequestsProvider.isLoading;

    // 🔹 If still loading, show loader
    if (isLoading) {
      return Scaffold(
        appBar: KAppBar(
          title: "Team Leader",
          centerTitle: true,
          leadingIcon: Icons.arrow_back,
          onLeadingIconPress: () {
            GoRouter.of(context).pop();
          },
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: KAppBar(
        title: "Team Leader",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () {
          GoRouter.of(context).pop();
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        initialOpen: false,
        key: _key,
        type: ExpandableFabType.up,
        overlayStyle: ExpandableFabOverlayStyle(
          color: AppColors.greyColor.withOpacity(0.5),
        ),

        openButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: Icon(Icons.menu, color: AppColors.secondaryColor),
          fabSize: ExpandableFabSize.regular,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        distance: 50.0.h,
        children: [
          _buildFabWithText(
            context,
            icon: Icons.access_time_filled,
            label: "Regulation\nApproval",
            heroTag: "punctual_arrivals",
            onPressed: () {
              GoRouter.of(
                context,
              ).pushNamed(AppRouteConstants.tlRegulationScreen);
            },
          ),
          // Punctual Arrivals Details
          _buildFabWithText(
            context,
            icon: Icons.access_time_filled,
            label: "Total Leave\nRequest",
            heroTag: "punctual_arrivals",
            onPressed: () {
              GoRouter.of(
                context,
              ).pushNamed(AppRouteConstants.tlTotalLeaveRequestScreen);
            },
          ),

          // Absent Days Details
          _buildFabWithText(
            context,
            icon: Icons.person_off,
            label: "\nLate Arrival\n  ",
            heroTag: "absent_days",
            onPressed: () {
              GoRouter.of(
                context,
              ).pushNamed(AppRouteConstants.tlLateArrivalScreen);
            },
          ),

          // Late Arrival Details
          _buildFabWithText(
            context,
            icon: Icons.schedule,
            label: "Total\nAttendance\nReport",
            heroTag: "late_arrivals",
            onPressed: () {
              GoRouter.of(
                context,
              ).pushNamed(AppRouteConstants.tlTotalAttendanceScreen);
            },
          ),

          // Early Arrival Details
          _buildFabWithText(
            context,
            icon: Icons.drive_eta,
            label: "Total\nEmployees",
            heroTag: "early_arrivals",
            onPressed: () {
              GoRouter.of(
                context,
              ).pushNamed(AppRouteConstants.tlTotalEmployeesScreen);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              // Attendance Welcoming Card
              // AttendanceWelcomingCard(
              //   attendanceCardTime: dateTimeProvider.currentTime, //"09:02:04 AM",
              //   attendanceCardTimeMessage: dateTimeProvider.greeting,
              //   attendanceDay: "Today",
              //   attendanceDate: dateTimeProvider.currentDate,
              //   onViewAttendance: () {
              //     // Total Attendance View Screen
              //     GoRouter.of(
              //       context,
              //     ).pushNamed(AppRouteConstants.totalAttendanceView);
              //   },
              // ),
              //
              // KVerticalSpacer(height: 20.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: isTablet
                      ? (isLandscape ? 4.8 : 2.5)
                      : 1.15, //1.3 //1.15,
                ),
                itemCount: gridAttendanceData.length,
                itemBuilder: (context, index) {
                  final item = gridAttendanceData[index];

                  return TLAttendanceCard(
                    attendancePercentage: "this week",
                    attendancePercentageIcon: Icons.add_circle_outlined,
                    attendanceCount: item['numberOfCount'].toString(),
                    attendanceCardIcon: item['icon'],
                    attendanceDescription: item['title'],
                    attendanceIconColor: AppColors.primaryColor,
                    attendancePercentageColor: AppColors.checkInColor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Add this helper method to your class
  Widget _buildFabWithText(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String heroTag,
    required VoidCallback onPressed,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.small(
          heroTag: heroTag,
          onPressed: onPressed,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: Icon(icon, size: 20),
        ),
        KHorizontalSpacer(width: 4.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
