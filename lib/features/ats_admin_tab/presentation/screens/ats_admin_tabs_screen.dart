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

class AtsAdminScreen extends StatefulWidget {
  const AtsAdminScreen({super.key});

  @override
  State<AtsAdminScreen> createState() => _AtsAdminScreenState();
}

class _AtsAdminScreenState extends State<AtsAdminScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "John Doe";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "john.doe@company.com";
    const currentRoute = AppRouteConstants.atsAdminTabScreen;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          if (currentRoute != AppRouteConstants.homeRecruiter) {
            context.goNamed(AppRouteConstants.homeRecruiter);
          } else {
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
        body: const AdminTabContent(),
      ),
    );
  }
}

class AdminTabContent extends StatelessWidget {
  const AdminTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> adminOptions = [
      {
        "title": "User Management",
        "subtitle": "Add, remove or update user roles & permissions",
        "icon": Icons.people_alt_rounded,
        "color": AppColors.primaryColor,
      },
      {
        "title": "Department Setup",
        "subtitle": "Manage company departments and assign heads",
        "icon": Icons.account_tree_rounded,
        "color": Colors.teal,
      },
      {
        "title": "Access Control",
        "subtitle": "Define access levels for employees & managers",
        "icon": Icons.verified_user_rounded,
        "color": Colors.deepPurple,
      },
      {
        "title": "Audit Logs",
        "subtitle": "Track admin activities and changes in system",
        "icon": Icons.history_rounded,
        "color": Colors.orangeAccent,
      },
      {
        "title": "System Settings",
        "subtitle": "Control configurations & global preferences",
        "icon": Icons.settings_applications_rounded,
        "color": Colors.indigo,
      },
      {
        "title": "Reports & Analytics",
        "subtitle": "View hiring trends, user stats, and performance",
        "icon": Icons.bar_chart_rounded,
        "color": Colors.green,
      },
    ];

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.atsHomepageBg,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KText(
              text: "Admin Panel",
              fontWeight: FontWeight.w700,
              fontSize: 26.sp,
              color: AppColors.titleColor,
            ),
            SizedBox(height: 6.h),
            KText(
              text: "Manage users, departments, access, and reports",
              fontSize: 14.sp,
              color: AppColors.greyColor,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(height: 25.h),

            // Grid view for admin options
            Expanded(
              child: GridView.builder(
                itemCount: adminOptions.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // change for web/mobile responsiveness
                  crossAxisSpacing: 20.w,
                  mainAxisSpacing: 20.h,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = adminOptions[index];
                  return _AdminCard(
                    title: item["title"],
                    subtitle: item["subtitle"],
                    icon: item["icon"],
                    color: item["color"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _AdminCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 26.sp),
            ),
            SizedBox(height: 12.h),
            KText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.titleColor,
            ),
            SizedBox(height: 6.h),
            Expanded(
              child: KText(
                text: subtitle,
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
