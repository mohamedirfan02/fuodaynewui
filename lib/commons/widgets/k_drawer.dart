import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_drawer_list_tile.dart';
import 'package:fuoday/commons/widgets/k_snack_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/extensions/provider_extension.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:go_router/go_router.dart';

class KDrawer extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String? profileImageUrl;

  const KDrawer({
    super.key,
    this.userName,
    this.userEmail,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final employeeDetails = HiveStorageService().employeeDetails ?? {};
    final access = (employeeDetails['access'] ?? '').toString();
    final rawAccess = (employeeDetails['access'] ?? '')
        .toString()
        .toLowerCase();
    // Convert comma-separated roles into a list (like ['manager', 'tl', 'hr'])
    final accessList = rawAccess.split(',').map((e) => e.trim()).toList();

    // Helper functions
    bool hasRole(String role) => accessList.contains(role);
    bool hasAnyRole(List<String> roles) =>
        roles.any((r) => accessList.contains(r));

    return Drawer(
      backgroundColor: theme.secondaryHeaderColor, //AppColors.secondaryColor
      child: Column(
        children: [
          // Profile Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: primaryColor),
            accountName: KText(
              text: userName ?? "No name",
              color: theme.secondaryHeaderColor,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
            accountEmail: KText(
              text: userEmail ?? "No email",
              color: theme.secondaryHeaderColor,
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
                //  if (designation.toLowerCase() != 'employee')
                KDrawerListTile(
                  drawerTitle: "Teams",
                  drawerListTileOnTap: () {
                    Navigator.pop(context); // Close drawer
                    GoRouter.of(context).pushNamed(AppRouteConstants.teams);
                  },
                  drawerLeadingIcon: Icons.group,
                ),

                // Organization
                KDrawerListTile(
                  drawerTitle: "Organization",
                  drawerListTileOnTap: () {
                    Navigator.pop(context); // Close drawer
                    GoRouter.of(
                      context,
                    ).pushNamed(AppRouteConstants.organizations);
                  },
                  drawerLeadingIcon: Icons.location_city,
                ),

                // Team Tree
                KDrawerListTile(
                  drawerTitle: "Team Tree",
                  drawerListTileOnTap: () {
                    Navigator.pop(context); // Close drawer
                    GoRouter.of(context).pushNamed(AppRouteConstants.teamTree);
                  },
                  drawerLeadingIcon: Icons.account_tree_outlined,
                ),

                _buildDivider(context),

                // Attendance
                KDrawerListTile(
                  drawerTitle: "Attendance",
                  drawerListTileOnTap: () {
                    Navigator.pop(context); // Close drawer
                    GoRouter.of(
                      context,
                    ).pushNamed(AppRouteConstants.attendance);
                  },
                  drawerLeadingIcon: Icons.add_chart,
                ),

                // Time Tracker
                KDrawerListTile(
                  drawerTitle: "Time Tracker",
                  drawerListTileOnTap: () {
                    Navigator.pop(context); // Close drawer
                    GoRouter.of(
                      context,
                    ).pushNamed(AppRouteConstants.timeTracker);
                  },
                  drawerLeadingIcon: Icons.timelapse,
                ),

                // HR menu — visible only if designation is "hr"
                //  if (access.toLowerCase() == 'hr')
                if (hasRole('hr'))
                  KDrawerListTile(
                    drawerTitle: "HR",
                    drawerListTileOnTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).pushNamed(AppRouteConstants.hr);
                    },
                    drawerLeadingIcon: Icons.handshake_rounded,
                  ),
                // TL menu — visible only if designation is "TL"
                // if (access.toLowerCase() == 'team leader')
                if (hasRole('tl'))
                  KDrawerListTile(
                    drawerTitle: "TL",
                    drawerListTileOnTap: () {
                      Navigator.pop(context);
                      GoRouter.of(
                        context,
                      ).pushNamed(AppRouteConstants.teamLeader);
                    },
                    drawerLeadingIcon: Icons.groups,
                  ),
                // Manager menu — visible only if designation is "Manager"
                //if (access.toLowerCase() == 'manager')
                if (hasRole('manager'))
                  KDrawerListTile(
                    drawerTitle: "Manager",
                    drawerListTileOnTap: () {
                      Navigator.pop(context);
                      GoRouter.of(context).pushNamed(AppRouteConstants.manager);
                    },
                    drawerLeadingIcon: Icons.manage_accounts_rounded,
                  ),

                // Management
                if (hasRole('management'))
                  KDrawerListTile(
                    drawerTitle: "Management",
                    drawerListTileOnTap: () {
                      Navigator.pop(context); // Close drawer
                      GoRouter.of(
                        context,
                      ).pushNamed(AppRouteConstants.management);
                    },
                    drawerLeadingIcon: Icons.manage_accounts_rounded,
                  ),

                // Pay Slip
                KDrawerListTile(
                  drawerTitle: "Pay Slip",
                  drawerListTileOnTap: () {
                    Navigator.pop(context); // Close drawer
                    GoRouter.of(context).pushNamed(AppRouteConstants.paySlip);
                  },
                  drawerLeadingIcon: Icons.payment_rounded,
                ),

                // Performance
                KDrawerListTile(
                  drawerTitle: "Performance",
                  drawerListTileOnTap: () {
                    Navigator.pop(context); // Close drawer
                    GoRouter.of(
                      context,
                    ).pushNamed(AppRouteConstants.performance);
                  },
                  drawerLeadingIcon: Icons.quick_contacts_dialer,
                ),

                _buildDivider(context),

                // Support
                KDrawerListTile(
                  drawerTitle: "Support",
                  drawerListTileOnTap: () {
                    Navigator.pop(context); // Close drawer
                    GoRouter.of(context).pushNamed(AppRouteConstants.support);
                  },
                  drawerLeadingIcon: Icons.support_agent,
                ),

                // Logout
                KDrawerListTile(
                  drawerTitle: "Logout",
                  drawerListTileOnTap: () {
                    _showLogoutDialog(context);
                  },
                  drawerLeadingIcon: Icons.logout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      child: Divider(
        color: theme.inputDecorationTheme.focusedBorder?.borderSide.color
            .withOpacity(0.2),
      ), //AppColors.subTitleColor
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
