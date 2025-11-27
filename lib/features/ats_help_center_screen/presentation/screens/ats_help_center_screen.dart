import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';

class AtsHelpCenterScreen extends StatefulWidget {
  const AtsHelpCenterScreen({super.key});

  @override
  State<AtsHelpCenterScreen> createState() => _AtsHelpCenterScreenState();
}

class _AtsHelpCenterScreenState extends State<AtsHelpCenterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "John Doe";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "john.doe@company.com";
    const currentRoute = AppRouteConstants.atsHelpCenterScreen;

    return Scaffold(
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
      backgroundColor: AppColors.atsHomepageBg,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Header
            KText(
              text: "Help Center",
              fontWeight: FontWeight.w700,
              fontSize: 24.sp,
              color: AppColors.titleColor,
            ),
            SizedBox(height: 8.h),
            KText(
              text: "Find answers, get support, and explore resources",
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.greyColor,
            ),
            SizedBox(height: 20.h),

            // 🔹 Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for help...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.h,
                  horizontal: 12.w,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 25.h),

            // 🔹 Categories Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.7,

              children: const [
                _HelpCard(
                  title: "Account Settings",
                  subtitle: "Manage your profile & password",
                  iconData: Icons.person_outline,
                  color: Color(0xFFE0F7FA),
                  iconColor: Color(0xFF00ACC1),
                ),
                _HelpCard(
                  title: "Job Portal",
                  subtitle: "Post or manage job listings",
                  iconData: Icons.work_outline,
                  color: Color(0xFFF1F8E9),
                  iconColor: Color(0xFF7CB342),
                ),
                _HelpCard(
                  title: "Calendar & Events",
                  subtitle: "Manage schedules & events",
                  iconData: Icons.calendar_today,
                  color: Color(0xFFFFF3E0),
                  iconColor: Color(0xFFFF9800),
                ),
                _HelpCard(
                  title: "Candidates & Hiring",
                  subtitle: "Track and manage applicants",
                  iconData: Icons.group_outlined,
                  color: Color(0xFFF3E5F5),
                  iconColor: Color(0xFF8E24AA),
                ),
              ],
            ),
            SizedBox(height: 30.h),

            // 🔹 FAQ Section
            KText(
              text: "Frequently Asked Questions",
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: AppColors.titleColor,
            ),
            SizedBox(height: 12.h),
            _faqItem(
              "How do I update my profile?",
              "Navigate to Settings → Profile and edit your details like name, photo, and contact info.",
            ),
            _faqItem(
              "How can I manage candidates?",
              "Go to the Candidates screen to add, edit, or shortlist candidates.",
            ),
            _faqItem(
              "Where can I track interviews?",
              "In the ATS Tracker section, you can view all scheduled and completed interviews.",
            ),
            SizedBox(height: 30.h),

            // 🔹 Contact Support Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.support_agent_outlined,
                    size: 40.sp,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(height: 8.h),
                  KText(
                    text: "Still need help?",
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.titleColor,
                  ),
                  SizedBox(height: 6.h),
                  KText(
                    text:
                        "Reach out to support@fuoday.com for further assistance.",
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    color: AppColors.greyColor,
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () {
                      // Contact support logic
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 8.h,
                      ),
                      child: Text(
                        "Contact Support",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _faqItem(String question, String answer) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: KText(
          text: question,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          color: AppColors.titleColor,
        ),
        iconColor: AppColors.primaryColor,
        childrenPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        children: [
          KText(
            text: answer,
            fontWeight: FontWeight.w400,
            fontSize: 13.sp,
            color: AppColors.greyColor,
          ),
        ],
      ),
    );
  }
}

class _HelpCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;
  final Color color;
  final Color iconColor;

  const _HelpCard({
    required this.title,
    required this.subtitle,
    required this.iconData,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 24.r,
              child: Icon(iconData, color: iconColor, size: 24.sp),
            ),
            SizedBox(height: 12.h),
            KText(
              text: title,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.titleColor,
            ),
            SizedBox(height: 6.h),
            KText(
              text: subtitle,
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: AppColors.greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
