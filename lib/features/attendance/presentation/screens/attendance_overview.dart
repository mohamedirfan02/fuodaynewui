import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/attendance/presentation/widgets/attendance_card.dart';
import 'package:fuoday/features/attendance/presentation/widgets/attendance_welcoming_card.dart';
import 'package:go_router/go_router.dart';

class AttendanceOverview extends StatefulWidget {
  const AttendanceOverview({super.key});

  @override
  State<AttendanceOverview> createState() => _AttendanceOverviewState();
}

class _AttendanceOverviewState extends State<AttendanceOverview> {
  // Service
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
      context.totalAttendanceDetailsProviderRead.fetchAttendanceDetails(
        webUserId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // // Internet Checker Provider
    // final internetCheckerProvider = context.appInternetCheckerProviderWatch;
    //
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (!internetCheckerProvider.isNetworkConnected) {
    //     KSnackBar.failure(context, "No Internet Connection");
    //   } else {
    //     KSnackBar.success(context, "Internet Connection Available");
    //   }
    // });
    //Date and Time Showing provider
    final dateTimeProvider = context.dateTimeProviderWatch;
    // Total Attendance Details Provider
    final totalAttendanceDetailsProvider =
        context.totalAttendanceDetailsProviderWatch;

    // Grid Attendance Data
    final List<Map<String, dynamic>> gridAttendanceData = [
      {
        'title': 'Total Attendance',
        'numberOfCount':
            totalAttendanceDetailsProvider
                .attendanceDetails
                ?.data
                ?.totalPresent ??
            0,
        'icon': Icons.person,
      },
      {
        'title': 'Absent Days',
        'numberOfCount':
            totalAttendanceDetailsProvider
                .attendanceDetails
                ?.data
                ?.totalAbsent ??
            0,
        'icon': Icons.person,
      },
      {
        'title': 'Punctual Arrivals',
        'numberOfCount':
            totalAttendanceDetailsProvider
                .attendanceDetails
                ?.data
                ?.totalPunctual ??
            0,
        'icon': Icons.person,
      },
      {
        'title': 'Late Arrivals',
        'numberOfCount':
            totalAttendanceDetailsProvider.attendanceDetails?.data?.totalLate ??
            0,
        'icon': Icons.person,
      },
      {
        'title': 'Early Arrivals',
        'numberOfCount':
            totalAttendanceDetailsProvider
                .attendanceDetails
                ?.data
                ?.totalEarly ??
            0,
        'icon': Icons.person,
      },
      {
        'title': 'Permission Taken',
        'numberOfCount':
            totalAttendanceDetailsProvider
                .attendanceDetails
                ?.data
                ?.totalPermission ??
            0,
        'icon': Icons.person,
      },
    ];
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final isLandscape = size.width > size.height;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          // Attendance Welcoming Card
          AttendanceWelcomingCard(
            attendanceCardTime: dateTimeProvider.currentTime, //"09:02:04 AM",
            attendanceCardTimeMessage: dateTimeProvider.greeting,
            attendanceDay: "Today",
            attendanceDate: dateTimeProvider.currentDate,
            onViewAttendance: () {
              // Total Attendance View Screen
              GoRouter.of(
                context,
              ).pushNamed(AppRouteConstants.totalAttendanceView);
            },
          ),

          KVerticalSpacer(height: 20.h),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: isTablet
                  ? (isLandscape ? 4.8 : 2.5)
                  : 1.3, //1.3,
            ),
            itemCount: gridAttendanceData.length,
            itemBuilder: (context, index) {
              final item = gridAttendanceData[index];

              return AttendanceCard(
                attendancePercentage: "Employee",
                attendancePercentageIcon: Icons.add_circle_outlined,
                attendanceCount: item['numberOfCount'].toString(),
                attendanceCardIcon: item['icon'],
                attendanceDescription: item['title'],
                attendanceIconColor: theme.primaryColor,
                attendancePercentageColor: isDark
                    ? AppColors.checkInColorDark
                    : AppColors.checkInColor,
              );
            },
          ),
        ],
      ),
    );
  }
}
