import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_%20bar_with_drawer.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/router/app_route_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/profile/presentation/widgets/profile_list_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Scaffold Key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Open Drawer
  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // Get employee details from Hive with error handling
    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;

    // Safe extraction of employee details
    final name = employeeDetails?['name'] ?? "No Name";
    final profilePhoto = employeeDetails?['profilePhoto'] ?? "";
    final empId = employeeDetails?['empId'] ?? "No Employee ID";
    final designation = employeeDetails?['designation'] ?? "No Designation";
    final email = employeeDetails?['email'] ?? "No Email";

    return Scaffold(
      key: _scaffoldKey,
      appBar: KAppBarWithDrawer(
        userName: name,
        cachedNetworkImageUrl: profilePhoto,
        userDesignation: designation,
        showUserInfo: false,
        onDrawerPressed: _openDrawer,
        onNotificationPressed: () {},
      ),
      drawer: KDrawer(
        userName: name,
        userEmail: email,
        profileImageUrl: profilePhoto,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // profile image
              KCircularCachedImage(
                onTap: () {
                  showImageViewer(
                    context,
                    Image.network(profilePhoto, fit: BoxFit.contain).image,
                    swipeDismissible: true,
                    doubleTapZoomable: true,
                  );
                },
                size: 90.h,
                imageUrl: profilePhoto,
              ),

              SizedBox(height: 24.h),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.greyColor.withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isDark
                        ? AppColors.cardGradientColorDark
                        : AppColors.cardGradientColor,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // name
                    KText(
                      text: name,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: theme
                          .textTheme
                          .headlineLarge
                          ?.color, //AppColors.titleColor,
                    ),

                    KVerticalSpacer(height: 6.h),

                    KText(
                      text: "Employee ID: $empId",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: theme
                          .textTheme
                          .bodyLarge
                          ?.color, //AppColors.greyColor,
                    ),

                    KVerticalSpacer(height: 3.h),

                    // Phone No
                    KText(
                      text: "Phone No: 636909876",
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: theme
                          .textTheme
                          .bodyLarge
                          ?.color, //AppColors.greyColor,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Personal Details
              ProfileListTile(
                onTap: () {
                  // Personal Details Screen
                  GoRouter.of(
                    context,
                  ).pushNamed(AppRouteConstants.profilePersonalDetails);
                },
                leadingIcon: Icons.person,
                title: "Personal Details",
              ),

              // Employment Details
              ProfileListTile(
                onTap: () {
                  // Employment Details Screen
                  GoRouter.of(
                    context,
                  ).pushNamed(AppRouteConstants.profileEmploymentDetails);
                },
                leadingIcon: Icons.person,
                title: "Employment Details",
              ),

              // Educational Details
              ProfileListTile(
                onTap: () {
                  // Educational Details
                  GoRouter.of(
                    context,
                  ).pushNamed(AppRouteConstants.profileEducationalBackground);
                },
                leadingIcon: Icons.school,
                title: "Educational Background",
              ),

              // On boarding
              ProfileListTile(
                onTap: () {
                  // On Boarding
                  GoRouter.of(
                    context,
                  ).pushNamed(AppRouteConstants.profileOnBoarding);
                },
                leadingIcon: Icons.departure_board,
                title: "On boarding",
              ),

              // Professional Experience
              ProfileListTile(
                onTap: () {
                  // Professional Experience
                  GoRouter.of(
                    context,
                  ).pushNamed(AppRouteConstants.profileProfessionalExperience);
                },
                leadingIcon: Icons.scale,
                title: "Professional Experience",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
