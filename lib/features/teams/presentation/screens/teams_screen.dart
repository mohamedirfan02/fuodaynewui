import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_linear_gradient_bg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/teams/presentation/screens/teams_list.dart';
import 'package:fuoday/features/teams/presentation/screens/teams_projects.dart';
import 'package:fuoday/features/teams/presentation/screens/teams_reportees.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
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

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: theme.primaryColor,
          title: KText(
            text: "Teams",
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: theme.secondaryHeaderColor,
          ),
          titleTextStyle: GoogleFonts.sora(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: theme
                .textTheme
                .headlineLarge
                ?.color, //AppColors.titleColor,, //AppColors.secondaryColor,
          ),
          leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: theme.secondaryHeaderColor,
            ), //AppColors.secondaryColor,),
          ),
        ),
        body: KLinearGradientBg(
          gradientColor: isDark
              ? AppColors.employeeGradientColorDark
              : AppColors.employeeGradientColor,
          child: Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  spacing: 20.w,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KCircularCachedImage(imageUrl: profilePhoto, size: 80.h),
                    Column(
                      spacing: 2.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Username
                        KText(
                          text: name,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: AppColors.secondaryColor,
                        ),

                        // Employee Id
                        KText(
                          text: "Employee Id: $empId",
                          fontWeight: FontWeight.w500,
                          fontSize: 10.sp,
                          color: AppColors.secondaryColor,
                        ),

                        // Employee Phone Number
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

                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                      color: theme
                          .secondaryHeaderColor, //AppColors.secondaryColor,,
                    ),
                    child: Column(
                      children: [
                        // TabBar
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.h,
                            left: 20.w,
                            right: 20.w,
                          ),
                          child: TabBar(
                            tabAlignment: TabAlignment.center,
                            isScrollable: true,
                            dividerColor: AppColors.transparentColor,
                            indicator: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            indicatorColor: AppColors.transparentColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            unselectedLabelColor: theme.primaryColor,
                            labelColor: theme
                                .secondaryHeaderColor, //AppColors.secondaryColor,
                            labelStyle: GoogleFonts.sora(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelStyle: GoogleFonts.sora(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            tabs: const [
                              // Team Reportees
                              Tab(text: "Reportees"),

                              // Projects
                              Tab(text: "Projects"),

                              // Department
                              Tab(text: "Team List"),
                            ],
                          ),
                        ),

                        // Tab View
                        Expanded(
                          child: TabBarView(
                            children: [
                              // Teams Reportee
                              TeamsReportees(),

                              // Projects
                              TeamsProjects(),

                              // Team List
                              TeamsList(),
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
