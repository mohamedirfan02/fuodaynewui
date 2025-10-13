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
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/ats_tracker/presentation/screens/ats_tracker_interview.dart';
import 'package:fuoday/features/ats_tracker/presentation/screens/ats_tracker_overview.dart';
import 'package:fuoday/features/home/presentation/widgets/ats_k_app_bar_with_drawer.dart';
import 'package:go_router/go_router.dart';

import 'SupportAllTicketScreenTab.dart';
import 'SupportMyTicketScreenTab.dart';

class AtsSupportScreen extends StatefulWidget {
  const AtsSupportScreen({super.key});

  @override
  State<AtsSupportScreen> createState() => _AtsSupportScreenState();
}

class _AtsSupportScreenState extends State<AtsSupportScreen> {
  // Scaffold Key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();

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
        AppRouteConstants.atsSupportScreen; // Replace with actual current route

    // Debugging Logger
    AppLoggerHelper.logInfo("Employee Details: $employeeDetails");
    AppLoggerHelper.logInfo(
      "Has Employee Details: ${hiveService.hasEmployeeDetails}",
    );

    return WillPopScope(
      onWillPop: () async {
        // If not on Home → go Home instead of closing app
        if (currentRoute != AppRouteConstants.homeRecruiter) {
          GoRouter.of(context).goNamed(AppRouteConstants.homeRecruiter);
          return false; // block closing app
        }
        return true; // already in Home → allow app exit
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
            currentRoute: currentRoute, // highlight current screen
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
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.w,
                            right: 0,
                            top: 20.h,
                            bottom: 20.h,
                          ),
                          child: TabBar(
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            // left align
                            dividerColor: AppColors.atsHomepageBg,
                            unselectedLabelColor: AppColors.greyColor,
                            indicatorColor: AppColors.primaryColor,
                            labelColor: AppColors.titleColor,
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 6),
                                    const KText(
                                      text: "All Ticket",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 6),
                                    const KText(
                                      text: "My Ticket",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              SupportAllTicketTab(),
                              SupportMyTicketTab(),
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
