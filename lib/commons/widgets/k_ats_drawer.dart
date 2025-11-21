import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:go_router/go_router.dart';
import 'k_ats_drawer_list_tile.dart';

class KAtsDrawer extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String? profileImageUrl;
  final String? currentRoute;

  const KAtsDrawer({
    super.key,
    this.userName,
    this.userEmail,
    this.profileImageUrl,
    this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    return Drawer(
      backgroundColor: theme.secondaryHeaderColor, //AppColors.secondaryColor
      child: Column(
        children: [
          // Logo Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 30.5.h,
              left: 2.03.w,
              right: 20.w,
              bottom: 17.5
                  .h, // 10.5 + 35 (logo height) + 7 (gap) - creating proper spacing
            ),
            decoration: BoxDecoration(
              color: theme.secondaryHeaderColor,
              border: Border(
                bottom: BorderSide(
                  color:
                      theme.inputDecorationTheme.focusedBorder?.borderSide.color
                          .withOpacity(0.1) ??
                      AppColors.subTitleColor.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                AppAssetsConstants.atsFuoDayLogo,
                height: 35.h,
                width: 176.w,
                //  color: theme.textTheme.headlineLarge?.color,//AppColors.titleColor,,
              ),
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(height: 10.h),

                // Home
                KAtsDrawerListTile(
                  drawerTitle: "Home",
                  drawerListTileOnTap: () {
                    _navigateToRoute(context, AppRouteConstants.homeRecruiter);
                  },
                  drawerLeadingIcon: Icons.home_outlined,
                  isSelected: currentRoute == AppRouteConstants.homeRecruiter,
                ),

                // Candidates
                KAtsDrawerListTile(
                  drawerTitle: "Candidates",
                  drawerListTileOnTap: () {
                    _navigateToRoute(context, AppRouteConstants.atsCandidate);
                  },
                  drawerLeadingIcon: Icons.group_outlined,
                  isSelected: currentRoute == AppRouteConstants.atsCandidate,
                ),

                // ATS Tracker
                KAtsDrawerListTile(
                  drawerTitle: "ATS Tracker",
                  drawerListTileOnTap: () {
                    _navigateToRoute(
                      context,
                      AppRouteConstants.atsTrackerScreen,
                    );
                  },
                  drawerLeadingIcon: Icons.track_changes_outlined,
                  isSelected:
                      currentRoute == AppRouteConstants.atsTrackerScreen,
                ),

                // Hiring
                KAtsDrawerListTile(
                  drawerTitle: "Hiring",
                  drawerListTileOnTap: () {
                    _navigateToRoute(context, AppRouteConstants.hiringScreen);
                  },
                  drawerLeadingIcon: Icons.business_center_outlined,
                  isSelected: currentRoute == AppRouteConstants.hiringScreen,
                ),

                // Calendar
                KAtsDrawerListTile(
                  drawerTitle: "Calendar",
                  drawerListTileOnTap: () {
                    _navigateToRoute(
                      context,
                      AppRouteConstants.atsCalendarScreen,
                    );
                  },
                  drawerLeadingIcon: Icons.calendar_today_outlined,
                  isSelected:
                      currentRoute == AppRouteConstants.atsCalendarScreen,
                ),

                // Index
                KAtsDrawerListTile(
                  drawerTitle: "Index",
                  drawerListTileOnTap: () {
                    _navigateToRoute(context, AppRouteConstants.atsIndexScreen);
                  },
                  drawerLeadingIcon: Icons.list_alt_outlined,
                  isSelected: currentRoute == AppRouteConstants.atsIndexScreen,
                ),

                // Job Portal
                KAtsDrawerListTile(
                  drawerTitle: "Job Portal",
                  drawerListTileOnTap: () {
                    _navigateToRoute(
                      context,
                      AppRouteConstants.atsJobPortalScreen,
                    );
                  },
                  drawerLeadingIcon: Icons.work_outline,
                  isSelected:
                      currentRoute == AppRouteConstants.atsJobPortalScreen,
                ),

                // Admin Tab
                KAtsDrawerListTile(
                  drawerTitle: "Admin Tab",
                  drawerListTileOnTap: () {
                    _navigateToRoute(
                      context,
                      AppRouteConstants.atsAdminTabScreen,
                    );
                  },
                  drawerLeadingIcon: Icons.admin_panel_settings_outlined,
                  isSelected:
                      currentRoute == AppRouteConstants.atsAdminTabScreen,
                ),

                // Support
                KAtsDrawerListTile(
                  drawerTitle: "Support",
                  drawerListTileOnTap: () {
                    _navigateToRoute(
                      context,
                      AppRouteConstants.atsSupportScreen,
                    );
                  },
                  drawerLeadingIcon: Icons.support_agent_outlined,
                  isSelected:
                      currentRoute == AppRouteConstants.atsSupportScreen,
                ),

                // Spacer to push Help Center and Settings to bottom
                SizedBox(height: 60.h),

                // Help Center (with notification badge as shown in Figma)
                KAtsDrawerListTile(
                  drawerTitle: "Help Center",
                  drawerListTileOnTap: () {
                    _navigateToRoute(
                      context,
                      AppRouteConstants.atsHelpCenterScreen,
                    );
                  },
                  drawerLeadingIcon: Icons.help_outline,
                  isSelected:
                      currentRoute == AppRouteConstants.atsHelpCenterScreen,
                  //   hasNotificationBadge: true, // You'll need to add this property to your KAtsDrawerListTile
                ),

                // Setting
                KAtsDrawerListTile(
                  drawerTitle: "Setting",
                  drawerListTileOnTap: () {
                    _navigateToRoute(
                      context,
                      AppRouteConstants.atsSettingsScreen,
                    ); //AppRouteConstants
                  },
                  drawerLeadingIcon: Icons.settings_outlined,
                  isSelected:
                      currentRoute == AppRouteConstants.atsSettingsScreen,
                ),

                SizedBox(height: 20.h),

                // Logout
                KAtsDrawerListTile(
                  drawerTitle: "Logout",
                  drawerListTileOnTap: () {
                    _showLogoutDialog(context);
                  },
                  drawerLeadingIcon: Icons.logout_outlined,
                  isSelected: false,
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to handle navigation with duplicate route prevention
  void _navigateToRoute(BuildContext context, String routeName) {
    Navigator.pop(context); // Close drawer first

    // Check if we're already on the target route
    if (currentRoute != routeName) {
      GoRouter.of(context).pushNamed(routeName); //goNamed
    }
    // If we're already on the same route, just close the drawer (no navigation)
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        //App Theme Data
        final theme = Theme.of(context);
        // final isDark = theme.brightness == Brightness.dark;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: KText(
            text: "Logout",
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
          content: KText(
            text: "Are you sure you want to logout?",
            fontSize: 14.sp,
            color: theme
                .inputDecorationTheme
                .focusedBorder
                ?.borderSide
                .color, //subTitleColor,
            fontWeight: FontWeight.w600,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: KText(
                text: "Cancel",
                color:
                    theme.inputDecorationTheme.focusedBorder?.borderSide.color,
                fontWeight: FontWeight.w600,

                fontSize: 14.sp,
              ),
            ),
            TextButton(
              onPressed: () async {
                final logoutProvider = context.employeeAuthLogoutProviderRead;

                await logoutProvider.logout();

                // Only navigate if logout was successful (no error)
                if (logoutProvider.error == null) {
                  GoRouter.of(
                    context,
                  ).pushReplacementNamed(AppRouteConstants.login);
                  KSnackBar.success(context, 'Logout Successfully');
                } else {
                  KSnackBar.failure(
                    context,
                    'Logout failed: ${logoutProvider.error}',
                  );
                }
              },
              child: context.employeeAuthLogOutProviderWatch.isLoading
                  ? SizedBox(
                      width: 16.w,
                      height: 16.h,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.primaryColor,
                        ),
                      ),
                    )
                  : KText(
                      text: "Logout",
                      color: theme.primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
            ),
          ],
        );
      },
    );
  }
}

// //Back To Home Wrapper
// class MainScaffold extends StatelessWidget {
//   final Widget child;
//   final String currentRoute;
//
//   const MainScaffold({
//     Key? key,
//     required this.child,
//     required this.currentRoute,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false, // prevent default popping behavior
//       onPopInvokedWithResult: (didPop, result) async {
//         if (!didPop) {
//           // If not on home → navigate to home instead of closing app
//           if (currentRoute != AppRouteConstants.homeRecruiter) {
//             context.goNamed(AppRouteConstants.homeRecruiter);
//           } else {
//             // Already on home → allow app exit
//             Navigator.of(context).maybePop();
//           }
//         }
//       },
//       child: Scaffold(
//         drawer: KAtsDrawer(currentRoute: currentRoute),
//         body: child,
//       ),
//     );
//   }
// }
