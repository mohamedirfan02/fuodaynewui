import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_ats_drawer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
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
import 'ats_tracker_interview.dart';
import 'ats_tracker_overview.dart';

class AtsTrackerScreen extends StatefulWidget {
  const AtsTrackerScreen({super.key});

  @override
  State<AtsTrackerScreen> createState() => _AtsTrackerScreenState();
}

class _AtsTrackerScreenState extends State<AtsTrackerScreen> {
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
    //App Theme Data
    final theme = Theme.of(context);
    // Get employee details from Hive with error handling
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Safe extraction of employee details
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final email = employeeDetails?['email'] ?? "No Email";
    final String currentRoute =
        AppRouteConstants.atsTrackerScreen; // Replace with actual current route

    // Debugging Logger
    AppLoggerHelper.logInfo("Employee Details: $employeeDetails");
    AppLoggerHelper.logInfo(
      "Has Employee Details: ${hiveService.hasEmployeeDetails}",
    );

    /// Slide from left (back navigation)
    Widget _slideFromLeft(
      Animation<double> animation,
      Animation<double> _,
      Widget child,
    ) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0), // Start from left
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    }

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
            color: theme.scaffoldBackgroundColor,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: KText(
                      text: "ATS Tracker",
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: theme
                          .textTheme
                          .headlineLarge
                          ?.color, //AppColors.titleColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: KText(
                      text: "Manage your Interview Schedule",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: AppColors.greyColor,
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 0.w,
                            right: 0,
                            top: 10.h,
                            bottom: 0.h,
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
                                      AppAssetsConstants.pointIcon,
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text("Overview"),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      AppAssetsConstants.noteIcon,
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text("Interview"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: TabBarView(
                            children: [
                              AtsTrackerOverviewTab(),
                              InterviewScreen(),
                            ],
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
