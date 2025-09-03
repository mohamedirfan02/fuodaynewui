import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_%20bar_with_drawer.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_drawer.dart';
import 'package:fuoday/commons/widgets/k_linear_gradient_bg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class HomeRecruiterScreen extends StatefulWidget {
  const HomeRecruiterScreen({super.key});

  @override
  State<HomeRecruiterScreen> createState() => _HomeRecruiterScreenState();
}

class _HomeRecruiterScreenState extends State<HomeRecruiterScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
        onDrawerPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onNotificationPressed: () {},
      ),
      drawer: KDrawer(
        userEmail: email,
        userName: name,
        profileImageUrl: profilePhoto,
      ),
      body: KLinearGradientBg(
        gradientColor: AppColors.employeeGradientColor,
        child: Padding(
            padding: EdgeInsets.only(top: 20.h),
        child: Column(
            children: [
              Row(
                spacing: 20.w,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KCircularCachedImage(imageUrl: profilePhoto, size: 80.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(
                        text: name,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AppColors.secondaryColor,
                      ),
                      KText(
                        text: "Employee Id: $empId",
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: AppColors.secondaryColor,
                      ),
                      KText(
                        text: email,
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: AppColors.secondaryColor,
                      ),
                    ],
                  ),
                ],
              ),
              KVerticalSpacer(height: 20.h),
            ],
        ),
        ),
      ),
    );
  }
}
