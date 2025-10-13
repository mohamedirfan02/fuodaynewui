import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_ats_glow_btn.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_total_count_card.dart';
import 'package:go_router/go_router.dart';
import 'design_positios_tab.dart';
import 'development_position_tab.dart';

class AtsJobPortalScreen extends StatefulWidget {
  const AtsJobPortalScreen({super.key});

  @override
  State<AtsJobPortalScreen> createState() => _AtsJobPortalScreenState();
}

class _AtsJobPortalScreenState extends State<AtsJobPortalScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  final String currentRoute = AppRouteConstants.atsJobPortalScreen;

  final List<Map<String, dynamic>> gridAttendanceData = [
    {
      'icon': AppAssetsConstants.atsUserIcon,
      'title': 'Total Job Created',
      'numberOfCount': "23",
    },
    {
      'title': 'Hired through Linkedin',
      'numberOfCount': "123",
      'icon': AppAssetsConstants.atsUserIcon,
    },
    {
      'title': 'Hired through Indeed',
      'numberOfCount': "245",
      'icon': AppAssetsConstants.atsUserIcon,
    },
    {
      'title': 'Hired through Naukri',
      'numberOfCount': "850",
      'icon': AppAssetsConstants.atsUserIcon,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "No Email";

    return WillPopScope(
      onWillPop: () async {
        if (currentRoute != AppRouteConstants.homeRecruiter) {
          GoRouter.of(context).goNamed(AppRouteConstants.homeRecruiter);
          return false;
        }
        return true;
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
          userEmail: email,
          userName: name,
          profileImageUrl: profilePhoto,
          currentRoute: currentRoute,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.atsHomepageBg,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Home Page Title
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            KText(
                              text: "Job Portal",
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp,
                              color: AppColors.titleColor,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      KText(
                        text: "Manage your Interview Schedule",
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: AppColors.greyColor,
                      ),
                      SizedBox(height: 20.h),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 155 / 113,
                        ),
                        itemCount: gridAttendanceData.length,
                        itemBuilder: (context, index) {
                          final item = gridAttendanceData[index];
                          return AtsTotalCountCard(
                            employeeCount: item['numberOfCount'].toString(),
                            employeeCardIcon: item['icon'],
                            employeeDescription: item['title'],
                            employeeIconColor: AppColors.primaryColor,
                            employeePercentageColor: AppColors.checkInColor,
                            growthText: item['growth'],
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        spacing: 20.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: KAtsGlowButton(
                              text: "Create Post",
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              icon: SvgPicture.asset(
                                AppAssetsConstants.addIcon,
                                height: 15,
                                width: 15,
                                fit: BoxFit.contain,
                              ),
                              onPressed: () {
                                print("Create Post button tapped");
                              },
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),

                // Tab Bar
                Container(
                  color: AppColors.atsHomepageBg,
                  padding: EdgeInsets.only(left: 16.w),
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    dividerColor: AppColors.atsHomepageBg,
                    unselectedLabelColor: AppColors.greyColor,
                    indicatorColor: AppColors.primaryColor,
                    labelColor: AppColors.titleColor,
                    tabs: const [
                      Tab(text: "Design Position"),
                      Tab(text: "Development Position"),
                    ],
                  ),
                ),

                // Tab Content (Non-scrollable)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      JobPortalDesignPositionsTab(),
                      JobPortalDevelopmentPositionTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}