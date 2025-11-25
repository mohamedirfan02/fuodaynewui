import 'package:flutter/material.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:fuoday/features/hr/domain/entities/hr_overview_entity.dart';
import 'package:fuoday/features/hr/presentation/provider/hr_overview_provider.dart';
import 'package:fuoday/features/hr/presentation/screens/hr_add_events.dart';
import 'package:fuoday/features/hr/presentation/widgets/hr_card.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HROverviewWidget extends StatelessWidget {
  final int webUserId;
  const HROverviewWidget({super.key, required this.webUserId});

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);
    //final stats = context.watch<HROverviewProvider>().hrOverview!.stats;
    final roleBasedProvider = context.roleBasedUsersProviderWatch;
    final attendanceProvider = context.roleWiseAttendanceReportProviderWatch;
    final lateArrivalProvider = context.allRoleLateArrivalsReportProviderWatch;
    final regulationProvider = context.allRegulationsProviderWatch;
    final leaveProvider = context.allLeaveRequestProviderWatch;
    final totalPayrollProvider = context.totalPayrollProviderWatch;

    final employees = roleBasedProvider.roleBasedUsers;
    final EmployeetotalAttendce = attendanceProvider.attendanceReport;
    final EmployeelateArrival = lateArrivalProvider.lateArrivals;
    final EmployeeleaveRequest = leaveProvider.leaveRequests;

    final permissions =
        context.watch<HROverviewProvider>().hrOverview?.permissions ?? [];

    final totalEmployees = employees?.hr.totalCount ?? 0;
    final totalAttendancecount =
        EmployeetotalAttendce?.hrSection.totalCount ?? 0;
    final totallateArrivalcount =
        EmployeelateArrival?.hrSection.totalCount ?? 0;
    final totallateleaveRequest =
        EmployeeleaveRequest?.hrSection?.totalCount ?? 0;
    final TotalPayrollList = totalPayrollProvider.totalPayroll?.totalCount ?? 0;

    // ///   Extract HR Section leave data
    // final hrLeaves = EmployeeleaveRequest?.hrSection?.data ?? [];
    //
    // ///   Calculate counts
    // final totalApproved = hrLeaves
    //     .where((e) => e.status?.toLowerCase() == 'approved')
    //     .length;
    // final totalRejected = hrLeaves
    //     .where((e) => e.status?.toLowerCase() == 'rejected')
    //     .length;
    // final totalPending = hrLeaves
    //     .where((e) => e.status?.toLowerCase() == 'pending')
    //     .length;
    //
    // ///   Grand total
    // final totalLeaveRequests = totalApproved + totalRejected + totalPending;

    //   Today’s date formatted like your API (e.g., 2025-11-05)
    final today = DateTime.now();
    final todayStr =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    //   Filter only today’s records where employee is “present” (not on leave)
    final todayAttendanceList =
        EmployeetotalAttendce?.hrSection.data
            .where(
              (att) =>
                  att.date == todayStr &&
                  att.status != "On Leave" &&
                  att.checkin != null,
            )
            .toList() ??
        [];

    //   Count how many employees attended today
    final todayAttendanceCount = todayAttendanceList.length;

    final cardData = [
      {
        'count': totalEmployees,
        'description': 'Total Employees',
        'filter': 'this week',
        'icon': Icons.person,
      },
      {
        'count': totallateleaveRequest,
        'description': 'Total Leave Requests',
        'filter': 'this month',
        'icon': Icons.work,
      },
      {
        'count': "$todayAttendanceCount/$totalEmployees",
        'description': 'Total Attendance Report',
        'filter': 'today',
        'icon': Icons.check_circle,
      },
      {
        'count': "${permissions.length ?? 0}",
        'description': 'Permissions',
        'filter': 'this week',
        'icon': Icons.rate_review,
      },
      {
        'count': totallateArrivalcount,
        'description': 'Late Arrival',
        'filter': 'today',
        'icon': Icons.access_time,
      },
      {
        'count': TotalPayrollList,
        'description': 'Total Employee Payroll',
        'filter': 'this week',
        'icon': Icons.person_2_outlined,
      },
      {
        'count': "${regulationProvider?.hrTotalCount ?? 0}",
        'description': 'Regulation Approval',
        'filter': 'this week',
        'icon': Icons.person_2_outlined,
      },
      // {
      //   'count': '0',
      //   'description': 'Total Audits',
      //   'filter': 'this week',
      //   'icon': Icons.analytics,
      // },
      {
        'count': '1',
        'description': 'Event',
        'filter': 'this week',
        'icon': Icons.analytics,
      },

      // Add more cards if needed
    ];

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: isTablet ? (isLandscape ? 4.8 : 2.5) : 1.1, // 1.1,
      ),
      itemCount: cardData.length,
      itemBuilder: (context, index) {
        return HRCard(
          totalEmployeesCount: cardData[index]['count'].toString(),
          description: cardData[index]['description'] as String,
          filterByHR: cardData[index]['filter'] as String,
          hrCardIcon: cardData[index]['icon'] as IconData,
          onTap: () {
            final desc = cardData[index]['description'] as String;

            switch (desc) {
              case 'Total Employees':
                GoRouter.of(context).pushNamed(
                  AppRouteConstants.hrTotalEmployeesScreen,
                  extra: webUserId,
                );
                break;

              case 'Total Leave Requests':
                GoRouter.of(context).pushNamed(
                  AppRouteConstants.hrTotalLeaveRequestScreen,
                  // extra: webUserId,
                );
                break;

              case 'Total Attendance Report':
                GoRouter.of(
                  context,
                ).pushNamed(AppRouteConstants.hrTotalAttendanceScreen);
                break;

              case 'Regulation Approval':
                GoRouter.of(
                  context,
                ).pushNamed(AppRouteConstants.hrRegulationScreen);
                break;
              case 'Total Employee Payroll':
                GoRouter.of(
                  context,
                ).pushNamed(AppRouteConstants.hrPayRollScreen);
                break;
              case 'Late Arrival':
                GoRouter.of(
                  context,
                ).pushNamed(AppRouteConstants.hrLateArrivalScreen);
                break;
              case 'Permissions':
                GoRouter.of(
                  context,
                ).pushNamed(AppRouteConstants.hrPermissionsScreen);
                break;
              case 'Event':
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    decoration: BoxDecoration(
                      color: theme
                          .secondaryHeaderColor, //AppColors.secondaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Handle bar
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        // Header
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Add Event',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                        Divider(height: 1),
                        // Content
                        Expanded(child: HrAddEvents()),
                      ],
                    ),
                  ),
                );
                //Bottomsheet calling area
                break;

              default:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Page under development')),
                );
            }

            // Example navigation
            // Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveRequestPage()));
          },
        );
      },
    );
  }
}
