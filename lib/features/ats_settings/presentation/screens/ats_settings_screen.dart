import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
// import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/router/app_route_constants.dart';

class AtsSettingsScreen extends StatefulWidget {
  const AtsSettingsScreen({super.key});

  @override
  State<AtsSettingsScreen> createState() => _AtsSettingsScreenState();
}

class _AtsSettingsScreenState extends State<AtsSettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  bool darkMode = false;
  bool notificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "John Doe";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "john.doe@company.com";
    const currentRoute = AppRouteConstants.atsSettingsScreen;

    return PopScope(
      canPop: false, // Prevent default pop
      onPopInvokedWithResult: (didPop, result) async {
        // If not popped automatically
        if (!didPop) {
          if (currentRoute != AppRouteConstants.homeRecruiter) {
            context.goNamed(AppRouteConstants.homeRecruiter);
          } else {
            // If already on Home → allow exiting app
            Navigator.of(context).maybePop();
          }
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AtsKAppBarWithDrawer(
          userName: "",
          cachedNetworkImageUrl: profilePhoto,
          userDesignation: "",
          showUserInfo: true,
          onDrawerPressed: _openDrawer,
          onNotificationPressed: () {},
        ),
        drawer: KAtsDrawer(
          userName: name,
          userEmail: email,
          currentRoute: currentRoute,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.atsHomepageBg,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🧑 Profile Section
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(0.15),
                        Colors.white,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 36.r,
                        backgroundImage: profilePhoto.isNotEmpty
                            ? NetworkImage(profilePhoto)
                            : null,
                        backgroundColor: AppColors.primaryColor.withOpacity(
                          0.2,
                        ),
                        child: profilePhoto.isEmpty
                            ? Icon(
                                Icons.person,
                                size: 32.sp,
                                color: AppColors.primaryColor,
                              )
                            : null,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: name,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: AppColors.titleColor,
                            ),
                            KText(
                              text: email,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyColor,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),

                // ⚙️ Quick Toggles
                _buildQuickToggles(),

                SizedBox(height: 25.h),
                KText(
                  text: "App Preferences",
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppColors.titleColor,
                ),
                SizedBox(height: 12.h),
                _buildSettingsCard(
                  icon: Icons.dashboard_customize_outlined,
                  title: "Homepage Customization",
                  subtitle: "Change layout, widgets, and quick panels",
                ),
                _buildSettingsCard(
                  icon: Icons.calendar_today_outlined,
                  title: "Calendar Integration",
                  subtitle: "Sync with Google / Outlook Calendar",
                ),
                _buildSettingsCard(
                  icon: Icons.people_outline,
                  title: "Candidate Preferences",
                  subtitle: "Manage default filters and status colors",
                ),
                _buildSettingsCard(
                  icon: Icons.work_outline,
                  title: "Hiring Flow Settings",
                  subtitle: "Edit interview pipeline and stages",
                ),

                SizedBox(height: 30.h),
                KText(
                  text: "System & Support",
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: AppColors.titleColor,
                ),
                SizedBox(height: 12.h),
                _buildSettingsCard(
                  icon: Icons.admin_panel_settings_outlined,
                  title: "Admin & Permissions",
                  subtitle: "Manage roles and HR access levels",
                ),
                _buildSettingsCard(
                  icon: Icons.support_agent_outlined,
                  title: "Support",
                  subtitle: "Chat with HR or tech support",
                ),
                _buildSettingsCard(
                  icon: Icons.help_outline,
                  title: "Help Center",
                  subtitle: "FAQ, documentation, and guides",
                ),

                SizedBox(height: 40.h),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                        vertical: 14.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: KText(
                      text: "Logout",
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    onPressed: () {
                      // handle logout
                    },
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickToggles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildToggleCard(
          title: "Dark Mode",
          icon: Icons.dark_mode_outlined,
          value: darkMode,
          onChanged: (v) => setState(() => darkMode = v),
        ),
        _buildToggleCard(
          title: "Notifications",
          icon: Icons.notifications_active_outlined,
          value: notificationEnabled,
          onChanged: (v) => setState(() => notificationEnabled = v),
        ),
      ],
    );
  }

  Widget _buildToggleCard({
    required String title,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryColor, size: 26.sp),
            SizedBox(height: 10.h),
            KText(
              text: title,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.titleColor,
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                offset: const Offset(0, 3),
                blurRadius: 6,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 26.sp),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KText(
                      text: title,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.titleColor,
                    ),
                    SizedBox(height: 3.h),
                    KText(
                      text: subtitle,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColors.greyColor,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.greyColor,
                size: 18.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
