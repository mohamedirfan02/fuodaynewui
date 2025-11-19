import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/attendance/presentation/screens/attendance_history.dart';
import 'package:fuoday/features/attendance/presentation/screens/attendance_overview.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: KAppBar(
          title: "Attendance",
          centerTitle: true,
          leadingIcon: Icons.arrow_back,
          onLeadingIconPress: () {
            GoRouter.of(context).pop();
          },
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          type: ExpandableFabType.up,
          overlayStyle: ExpandableFabOverlayStyle(
            color: theme.textTheme.bodyLarge?.color?.withOpacity(
              0.5,
            ), //AppColors.greyColor,
          ),

          openButtonBuilder: DefaultFloatingActionButtonBuilder(
            child: Icon(Icons.menu, color: theme.secondaryHeaderColor),
            fabSize: ExpandableFabSize.regular,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          distance: 50.0.h,
          children: [
            // Punctual Arrivals Details
            _buildFabWithText(
              context,
              icon: Icons.access_time_filled,
              label: "Punctual\nArrivals",
              heroTag: "punctual_arrivals",
              onPressed: () {
                GoRouter.of(context).pushNamed(
                  AppRouteConstants.attendancePunctualArrivalsDetails,
                );
              },
            ),

            // Absent Days Details
            _buildFabWithText(
              context,
              icon: Icons.person_off,
              label: "Absent\nDays",
              heroTag: "absent_days",
              onPressed: () {
                GoRouter.of(
                  context,
                ).pushNamed(AppRouteConstants.attendanceAbsentDetails);
              },
            ),

            // Late Arrival Details
            _buildFabWithText(
              context,
              icon: Icons.schedule,
              label: "Late\nArrivals",
              heroTag: "late_arrivals",
              onPressed: () {
                GoRouter.of(
                  context,
                ).pushNamed(AppRouteConstants.attendanceLateArrivalDetails);
              },
            ),

            // Early Arrival Details
            _buildFabWithText(
              context,
              icon: Icons.drive_eta,
              label: "Early\nArrivals",
              heroTag: "early_arrivals",
              onPressed: () {
                GoRouter.of(
                  context,
                ).pushNamed(AppRouteConstants.attendanceEarlyArrivalDetails);
              },
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TabBar
              TabBar(
                dividerColor: AppColors.transparentColor,
                indicator: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                indicatorColor: AppColors.transparentColor,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: theme.primaryColor,
                labelColor:
                    theme.secondaryHeaderColor, //AppColors.secondaryColor,
                labelStyle: GoogleFonts.sora(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: GoogleFonts.sora(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal,
                ),
                tabs: const [
                  // About
                  Tab(text: "Attendance Overview"),

                  // Service and Industries
                  Tab(text: "History"),
                ],
              ),

              KVerticalSpacer(height: 20.h),

              Expanded(
                child: TabBarView(
                  children: [
                    // Attendance Overview
                    AttendanceOverview(),

                    // Attendance History
                    AttendanceHistory(),
                  ],
                ),
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
