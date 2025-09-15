import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'k_ats_drawer_list_tile.dart';

class KAtsDrawer extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String? profileImageUrl;
  final String? currentRoute; // Add this parameter to track current route

  const KAtsDrawer({
    super.key,
    this.userName,
    this.userEmail,
    this.profileImageUrl,
    this.currentRoute, // Add this to constructor
  });

  @override
  Widget build(BuildContext context) {
    final employeeDetails = HiveStorageService().employeeDetails ?? {};
    final designation = (employeeDetails['designation'] ?? '').toString();

    final managementRoles = ['assistant manager-it', 'founder & ceo'];

    return Drawer(
      backgroundColor: AppColors.secondaryColor,
      child: Column(
        children: [
          // Profile Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColors.primaryColor),
            accountName: KText(
              text: userName ?? "No name",
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
            accountEmail: KText(
              text: userEmail ?? "No email",
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
            currentAccountPicture: KCircularCachedImage(
              imageUrl: profileImageUrl ?? "",
              size: 200.h,
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                // Teams
                KAtsDrawerListTile(
                  drawerTitle: "Candidates",
                  drawerListTileOnTap: () {
                    _navigateToRoute(context, AppRouteConstants.atsCandidate);
                  },
                  drawerLeadingIcon: Icons.group,
                  isSelected: currentRoute == AppRouteConstants.atsCandidate,
                ),

                // Tracker Screen
                KAtsDrawerListTile(
                  drawerTitle: "Tracker",
                  drawerListTileOnTap: () {
                    _navigateToRoute(context, AppRouteConstants.trackerScreen);
                  },
                  drawerLeadingIcon: Icons.location_city,
                  isSelected: currentRoute == AppRouteConstants.trackerScreen,
                ),

                // Team Tree
                KAtsDrawerListTile(
                  drawerTitle: "Team Tree",
                  drawerListTileOnTap: () {
                    // Only close drawer for now since route is commented
                    Navigator.pop(context);
                    // _navigateToRoute(context, AppRouteConstants.teamTree);
                  },
                  drawerLeadingIcon: Icons.account_tree_outlined,
                  isSelected: currentRoute == AppRouteConstants.teamTree, // Update when you add the route
                ),

                _buildDivider(),

                // Attendance
                KAtsDrawerListTile(
                  drawerTitle: "Attendance",
                  drawerListTileOnTap: () {
                    Navigator.pop(context);
                    // _navigateToRoute(context, AppRouteConstants.attendance);
                  },
                  drawerLeadingIcon: Icons.add_chart,
                  isSelected: currentRoute == AppRouteConstants.attendance, // Update when you add the route
                ),

                // Time Tracker
                KAtsDrawerListTile(
                  drawerTitle: "Time Tracker",
                  drawerListTileOnTap: () {
                    Navigator.pop(context);
                    // _navigateToRoute(context, AppRouteConstants.timeTracker);
                  },
                  drawerLeadingIcon: Icons.timelapse,
                  isSelected: currentRoute == AppRouteConstants.timeTracker, // Update when you add the route
                ),

                // HR menu — visible only if designation is "hr"
                if (designation.toLowerCase() == 'hr')
                  KAtsDrawerListTile(
                    drawerTitle: "HR",
                    drawerListTileOnTap: () {
                      Navigator.pop(context);
                      // _navigateToRoute(context, AppRouteConstants.hr);
                    },
                    drawerLeadingIcon: Icons.hail_rounded,
                    isSelected: currentRoute == AppRouteConstants.hr, // Update when you add the route
                  ),

                // Management
                if (managementRoles.contains(designation.trim().toLowerCase()))
                  KAtsDrawerListTile(
                    drawerTitle: "Management",
                    drawerListTileOnTap: () {
                      Navigator.pop(context);
                      // _navigateToRoute(context, AppRouteConstants.management);
                    },
                    drawerLeadingIcon: Icons.manage_accounts_rounded,
                    isSelected: currentRoute == AppRouteConstants.management, // Update when you add the route
                  ),

                // Pay Slip
                KAtsDrawerListTile(
                  drawerTitle: "Pay Slip",
                  drawerListTileOnTap: () {
                    Navigator.pop(context);
                    // _navigateToRoute(context, AppRouteConstants.paySlip);
                  },
                  drawerLeadingIcon: Icons.payment_rounded,
                  isSelected: currentRoute == AppRouteConstants.paySlip, // Update when you add the route
                ),

                // Performance
                KAtsDrawerListTile(
                  drawerTitle: "Performance",
                  drawerListTileOnTap: () {
                    Navigator.pop(context);
                    // _navigateToRoute(context, AppRouteConstants.performance);
                  },
                  drawerLeadingIcon: Icons.quick_contacts_dialer,
                  isSelected: currentRoute == AppRouteConstants.performance, // Update when you add the route
                ),

                _buildDivider(),

                // Support
                KAtsDrawerListTile(
                  drawerTitle: "Support",
                  drawerListTileOnTap: () {
                    Navigator.pop(context);
                    // _navigateToRoute(context, AppRouteConstants.support);
                  },
                  drawerLeadingIcon: Icons.support_agent,
                  isSelected: currentRoute == AppRouteConstants.support, // Update when you add the route
                ),

                // Logout
                KAtsDrawerListTile(
                  drawerTitle: "Logout",
                  drawerListTileOnTap: () {
                    _showLogoutDialog(context);
                  },
                  drawerLeadingIcon: Icons.logout,
                  isSelected: false, // Logout is never selected
                ),
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
      GoRouter.of(context).pushNamed(routeName);
    }
    // If we're already on the same route, just close the drawer (no navigation)
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      child: Divider(color: AppColors.subTitleColor.withOpacity(0.2)),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text("Cancel"),
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
                  ? const CircularProgressIndicator()
                  : const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}