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
import 'package:fuoday/features/attendance/presentation/widgets/attendance_card.dart';
import 'package:fuoday/features/team_leader/presentation/widget/TL_attendance_card.dart';
import 'package:go_router/go_router.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({super.key});

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
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

    Future.microtask(() {
      final ctx = context;
      ctx.roleBasedUsersProviderRead.fetchRoleBasedUsers(webUserId);
      ctx.roleWiseAttendanceReportProviderRead.fetchAllRoleAttendance(
        webUserId,
      );
      ctx.allRoleLateArrivalsReportProviderRead.fetchLateArrivals();
      ctx.allLeaveRequestProviderRead.fetchAllLeaveRequests("approved");
      ctx.allRegulationsProviderRead.fetchAllRegulations(webUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 Fetch all providers
    final roleBasedProvider = context.roleBasedUsersProviderWatch;
    final attendanceProvider = context.roleWiseAttendanceReportProviderWatch;
    final lateArrivalProvider = context.allRoleLateArrivalsReportProviderWatch;
    final regulationProvider = context.allRegulationsProviderWatch;
    final leaveProvider = context.allLeaveRequestProviderWatch;

    final employees = roleBasedProvider.roleBasedUsers;
    final EmployeetotalAttendce = attendanceProvider.attendanceReport;
    final EmployeelateArrival = lateArrivalProvider.lateArrivals;
    final EmployeeleaveRequest = leaveProvider.leaveRequests;

    final totalTeams = employees?.manager.totalCount ?? 0;
    final totalAttendancecount =
        EmployeetotalAttendce?.managerSection.totalCount ?? 0;
    final totallateArrivalcount =
        EmployeelateArrival?.managerSection.totalCount ?? 0;
    final totallateleaveRequest =
        EmployeeleaveRequest?.managerSection?.totalCount ?? 0;

    final isLoading =
        roleBasedProvider.isLoading ||
        attendanceProvider.isLoading ||
        lateArrivalProvider.isLoading ||
        regulationProvider.isLoading ||
        leaveProvider.isLoading;
    // 🔹 If still loading, show loader
    if (isLoading) {
      return Scaffold(
        appBar: KAppBar(
          title: "Manager",
          centerTitle: true,
          leadingIcon: Icons.arrow_back,
          onLeadingIconPress: () {
            GoRouter.of(context).pop();
          },
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    // Grid Attendance Data
    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'title': 'Total Employees',
        'numberOfCount': totalTeams,
        'icon': Icons.person,
      },
      {
        'title': 'Total Attendance Report',
        'numberOfCount': totalAttendancecount,
        'icon': Icons.speaker_notes_rounded,
      },
      {
        'title': 'Late Arrival',
        'numberOfCount': totallateArrivalcount,
        'icon': Icons.access_time,
      },
      {
        'title': 'Total Leave Request',
        'numberOfCount': totallateleaveRequest,
        'icon': Icons.leave_bags_at_home,
      },
      {
        'title': 'Regulation Approval',
        'numberOfCount': regulationProvider.managerTotalCount,
        'icon': Icons.approval,
      },
      {'title': 'Manager Feeds', 'numberOfCount': 0, 'icon': Icons.approval},

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
    return Scaffold(
      appBar: KAppBar(
        title: "Manager",
        centerTitle: true,
        leadingIcon: Icons.arrow_back,
        onLeadingIconPress: () {
          GoRouter.of(context).pop();
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        initialOpen: false,
        //key: _key,
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
            label: "Manager\nFeeds",
            heroTag: "punctual_arrivals",
            onPressed: () {
              GoRouter.of(
                context,
              ).pushNamed(AppRouteConstants.managerFeedScreen);
            },
          ),

          _buildFabWithText(
            context,
            icon: Icons.access_time_filled,
            label: "Regulation\nApproval",
            heroTag: "punctual_arrivals",
            onPressed: () {
              GoRouter.of(
                context,
              ).pushNamed(AppRouteConstants.managerRegulationScreen);
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
              ).pushNamed(AppRouteConstants.managerTotalLeaveRequestScreen);
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
              ).pushNamed(AppRouteConstants.managerLateArrivalScreen);
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
              ).pushNamed(AppRouteConstants.managerTotalAttendanceScreen);
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
              ).pushNamed(AppRouteConstants.managerTotalEmployeesScreen);
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
                  childAspectRatio: 1.15,
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
