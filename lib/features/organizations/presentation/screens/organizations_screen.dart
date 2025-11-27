import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_app_bar.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/constants/assets/app_assets_constants.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/organizations/presentation/screens/organizations_about.dart';
import 'package:fuoday/features/organizations/presentation/screens/organizations_our_teams.dart';
import 'package:fuoday/features/organizations/presentation/screens/organizations_service_industries.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganizationsScreen extends StatelessWidget {
  const OrganizationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);

    final hiveService = getIt<HiveStorageService>();
    final employeeDetails = hiveService.employeeDetails;
    final logoUrl = employeeDetails?['logo'] ?? ''; // fallback if null

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: KAppBar(
          title: "Organizations",
          centerTitle: true,
          leadingIcon: Icons.arrow_back,
          onLeadingIconPress: () {
            GoRouter.of(context).pop();
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            KVerticalSpacer(height: 20.h),

            // Logo
            Center(
              child: logoUrl.isNotEmpty
                  ? Image.network(
                      logoUrl,
                      height: 120.h,
                      width: 120.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppAssetsConstants
                              .logo, // fallback if network image fails
                          height: 120.h,
                          width: 120.w,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      AppAssetsConstants
                          .logo, // show default if logoUrl is empty
                      height: 120.h,
                      width: 120.w,
                      fit: BoxFit.cover,
                    ),
            ),

            // TabBar
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
              child: TabBar(
                dividerColor: AppColors.transparentColor,
                indicator: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                indicatorColor: AppColors.transparentColor,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: theme.primaryColor,
                labelColor:
                    theme.secondaryHeaderColor, //AppColors.secondaryColor,
                labelStyle: GoogleFonts.sora(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: GoogleFonts.sora(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal,
                ),
                tabs: const [
                  // About
                  Tab(text: "About"),

                  // Service and Industries
                  Tab(text: "Service & Ind"),

                  // Teams
                  Tab(text: "Our Teams"),
                ],
              ),
            ),

            Expanded(
              child: TabBarView(
                children: [
                  // About
                  OrganizationsAbout(),

                  // Service & Industries
                  OrganizationsServiceIndustries(),

                  // Teams
                  OrganizationsOurTeams(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
