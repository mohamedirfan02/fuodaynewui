import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_%20bar_with_drawer.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/commons/widgets/k_linear_gradient_bg.dart';
import 'package:fuoday/commons/widgets/k_tab_bar.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/helper/app_logger_helper.dart';
import 'package:fuoday/core/service/dio_service.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/service/secure_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/home/presentation/screens/hrms_screens/add_task.dart';
import 'package:fuoday/features/home/presentation/screens/hrms_screens/home_employee_activities.dart';
import 'package:fuoday/features/home/presentation/screens/hrms_screens/home_employee_feeds.dart';

class HomeEmployeeScreen extends StatefulWidget {
  const HomeEmployeeScreen({super.key});

  @override
  State<HomeEmployeeScreen> createState() => _HomeEmployeeScreenState();
}

class _HomeEmployeeScreenState extends State<HomeEmployeeScreen> {
  // Scaffold Key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    final empId = employeeDetails?['empId'] ?? "No Employee ID";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No Email";

    // Debugging Logger
    AppLoggerHelper.logInfo("Employee Details: $employeeDetails");
    AppLoggerHelper.logInfo(
      "Has Employee Details: ${hiveService.hasEmployeeDetails}",
    );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: KAppBarWithDrawer(
          userName: name,
          cachedNetworkImageUrl: profilePhoto,
          userDesignation: designation,
          showUserInfo: false,
          onDrawerPressed: () => _scaffoldKey.currentState?.openDrawer(),
          onNotificationPressed: () {},
        ),
        drawer: KDrawer(
          userEmail: email,
          userName: name,
          profileImageUrl: profilePhoto,
        ),
        body: KLinearGradientBg(
          gradientColor: Theme.of(context).brightness == Brightness.dark
              ? AppColors.employeeGradientColorDark
              : AppColors.employeeGradientColor,
          child: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Column(
              children: [
                Row(
                  spacing: 20.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KCircularCachedImage(imageUrl: profilePhoto, size: 90.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        KText(
                          text: name,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: AppColors.secondaryColor,
                        ),
                        KText(
                          text: "Employee Id: $empId",
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: AppColors.secondaryColor,
                        ),
                        KText(
                          text: email,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: AppColors.secondaryColor,
                        ),
                      ],
                    ),
                  ],
                ),

                KVerticalSpacer(height: 20.h),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                      // color: AppColors.secondaryColor,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 20.h,
                          ),
                          child: KTabBar(
                            labelPadding: EdgeInsets.symmetric(horizontal: 30.w), // More space
                            tabs: [
                              Tab(text: "Activity"),
                              Tab(text: "Feeds"),
                              Tab(text: "Add Task"),
                            ],
                          )
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              HomeEmployeeActivities(),
                              HomeEmployeeFeeds(),
                              AddTask(),
                            ],
                          ),
                        ),
                      ],
                    ),
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
