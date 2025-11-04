import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_overview_screens/hr_overview.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_view_open_positions.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_view_recent_employees.dart';
import 'package:go_router/go_router.dart';

import 'hr_add_events.dart';
import 'package:provider/provider.dart';
import '../provider/hr_overview_provider.dart';

class HRScreen extends StatefulWidget {
  const HRScreen({super.key});

  @override
  State<HRScreen> createState() => _HRScreenState();
}

class _HRScreenState extends State<HRScreen> {
  late final int webUserId;
  late final HiveStorageService hiveService;
  late final Map<String, dynamic>? employeeDetails;

  @override
  void initState() {
    super.initState();

    hiveService = getIt<HiveStorageService>();
    employeeDetails = hiveService.employeeDetails;
    webUserId =
        int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '0') ?? 0;

    // 🔹 Call your async provider methods after the widget is built
    Future.microtask(() {
      final ctx = context;

      //🔹 Add your other initial calls here:
      ctx.roleBasedUsersProviderRead.fetchRoleBasedUsers(webUserId);
      ctx.roleWiseAttendanceReportProviderRead.fetchAllRoleAttendance(
        webUserId,
      );
      ctx.allRoleLateArrivalsReportProviderRead.fetchLateArrivals();
      ctx.allLeaveRequestProviderRead.fetchAllLeaveRequests("approved");
      ctx.allRegulationsProviderRead.fetchAllRegulations(webUserId);
      //Fetch attendance data once on init
      ctx.totalPayrollProviderRead.fetchTotalPayroll();
      ctx.read<HROverviewProvider>().fetchHROverview(webUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final roleBasedProvider = context.roleBasedUsersProviderWatch;
    final attendanceProvider = context.roleWiseAttendanceReportProviderWatch;
    final lateArrivalProvider = context.allRoleLateArrivalsReportProviderWatch;
    final regulationProvider = context.allRegulationsProviderWatch;
    final leaveProvider = context.allLeaveRequestProviderWatch;
    final totalPayrollProvider = context.totalPayrollProviderWatch;
    final provider = getIt<HROverviewProvider>();

    // final hiveService = getIt<HiveStorageService>();
    // final employeeDetails = hiveService.employeeDetails;

    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final empId = employeeDetails?['empId'] ?? "No Employee ID";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No Email";
    // final webUserId =
    //     int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '0') ?? 0;

    final isLoading =
        roleBasedProvider.isLoading ||
        attendanceProvider.isLoading ||
        lateArrivalProvider.isLoading ||
        regulationProvider.isLoading ||
        leaveProvider.isLoading ||
        totalPayrollProvider.isLoading ||
        provider.isLoading;
    // 🔹 If still loading, show loader
    if (isLoading) {
      return Scaffold(
        appBar: KAppBar(
          title: "HR Dashboard",
          centerTitle: true,
          leadingIcon: Icons.arrow_back,
          onLeadingIconPress: () {
            GoRouter.of(context).pop();
          },
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return ChangeNotifierProvider(
      create: (_) {
        final provider = getIt<HROverviewProvider>();
        // final webUserId =
        //     int.tryParse(employeeDetails?['web_user_id']?.toString() ?? '0') ??
        //     0;
        provider.fetchHROverview(webUserId);
        return provider;
      },
      child: DefaultTabController(
        length: 3, // Number of tabs
        child: Scaffold(
          appBar: KAppBar(
            title: "HR Dashboard",
            centerTitle: true,
            leadingIcon: Icons.arrow_back,
            onLeadingIconPress: () {
              GoRouter.of(context).pop();
            },
          ),
          body: Consumer<HROverviewProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (provider.error != null) {
                return Center(child: Text('Error: ${provider.error}'));
              } else if (provider.hrOverview == null) {
                return const Center(child: Text('No data found.'));
              }

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    KCircularCachedImage(imageUrl: profilePhoto, size: 80.h),
                    KVerticalSpacer(height: 24.h),
                    // Profile Card
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 14.h,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.greyColor.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: AppColors.cardGradientColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          KText(
                            text: name,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.titleColor,
                          ),
                          KVerticalSpacer(height: 3.h),
                          KText(
                            text: "Designation: $designation",
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: AppColors.titleColor,
                          ),
                          KVerticalSpacer(height: 3.h),
                          KText(
                            text: "Employee id: $empId",
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: AppColors.titleColor,
                          ),
                          KVerticalSpacer(height: 3.h),
                          KText(
                            text: email,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: AppColors.titleColor,
                          ),
                        ],
                      ),
                    ),
                    KVerticalSpacer(height: 30.h),
                    KTabBar(
                      tabs: const [
                        Tab(text: "Overview"),
                        Tab(text: "Recent Employees"),
                        Tab(text: "Open Positions"),
                        //Tab(text: "Add Events"),
                      ],
                    ),
                    KVerticalSpacer(height: 20.h),
                    Expanded(
                      child: TabBarView(
                        children: [
                          HROverviewWidget(webUserId: webUserId),
                          HRViewRecentEmployeesWidget(
                            hrOverview: provider.hrOverview!,
                          ),
                          HRViewOpenPositionsWidget(
                            hrOverview: provider.hrOverview!,
                          ),
                          //  const HrAddEvents(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
