import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/constants/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/secure_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:go_router/go_router.dart';

import 'ats_hiring_tab.dart';
import 'ats_onboarding_tab.dart';

class HiringScreen extends StatefulWidget {
  const HiringScreen({super.key});

  @override
  State<HiringScreen> createState() => _HiringScreenState();
}

class _HiringScreenState extends State<HiringScreen> {
  // Scaffold Key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

  // Auth Token
  String? authToken;

  @override
  void initState() {
    loadAuthToken();
    super.initState();
  }

  Future<void> loadAuthToken() async {
    try {
      final secureStorageService = getIt<SecureStorageService>();
      authToken = await secureStorageService.getToken();

      AppLoggerHelper.logInfo("Auth Token: $authToken");

      if (authToken != null) {
        DioService().updateAuthToken(authToken!);
      }
    } catch (e) {
      AppLoggerHelper.logInfo("Auth Token error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get employee details from Hive with error handling
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Safe extraction of employee details
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "No Email";
    final String currentRoute =
        AppRouteConstants.hiringScreen; // Replace with actual current route

    // Debugging Logger
    AppLoggerHelper.logInfo("Employee Details: $employeeDetails");
    AppLoggerHelper.logInfo(
      "Has Employee Details: ${hiveService.hasEmployeeDetails}",
    );

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
      child: DefaultTabController(
        length: 2,
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
            currentRoute:
                currentRoute, // This will highlight the current screen
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color: AppColors.atsHomepageBg,
            child: Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: KText(
                        text: "Hiring",
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.titleColor,
                      ),
                    ),
                  ),
                  //SizedBox(height: 8.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: KText(
                        text: "Manage your Interview Schedule",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 0.w,
                            right: 0,
                            top: 0.h,
                            bottom: 5.h,
                          ),
                          child: TabBar(
                            isScrollable: true,
                            tabAlignment: TabAlignment.start, // left align
                            dividerColor: AppColors.atsHomepageBg,
                            unselectedLabelColor: AppColors.greyColor,
                            indicatorColor: AppColors.primaryColor,
                            labelColor: AppColors.titleColor,
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      AppAssetsConstants.selectedIcon,
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text("Hring"),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      AppAssetsConstants.selectedIcon,
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text("Onboarding"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: TabBarView(
                            children: [HiringTab(), OnboardingTab()],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
