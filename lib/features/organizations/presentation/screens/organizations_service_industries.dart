import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/organizations/presentation/providers/services_and_industries_provider.dart';
import 'package:provider/provider.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:fuoday/features/organizations/presentation/widgets/organizations_achivements_card.dart';

class OrganizationsServiceIndustries extends StatefulWidget {
  const OrganizationsServiceIndustries({super.key});

  @override
  State<OrganizationsServiceIndustries> createState() =>
      _OrganizationsServiceIndustriesState();
}

class _OrganizationsServiceIndustriesState
    extends State<OrganizationsServiceIndustries> {
  @override
  @override
  void initState() {
    super.initState();

    final webUserId = getIt<HiveStorageService>()
        .employeeDetails?['web_user_id']
        ?.toString();

    if (webUserId != null) {
      Future.microtask(() {
        context.read<ServicesAndIndustriesProvider>().getServicesAndIndustries(
          webUserId,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final provider = context.watch<ServicesAndIndustriesProvider>();

    if (provider.isLoading) {
      return Center(
        child: CircularProgressIndicator(color: theme.primaryColor),
      );
    }

    if (provider.hasError) {
      return Center(child: Text(provider.errorMessage));
    }

    final data = provider.model;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KText(
            text: "Our Services",
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            textAlign: TextAlign.start,
            color: theme.primaryColor,
            isUnderline: true,
            underlineColor: theme.primaryColor,
          ),
          KVerticalSpacer(height: 14.h),
          KText(
            text: data?.servicesDescription ?? '',
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: theme.textTheme.headlineLarge?.color, //AppColors.titleColor,
            textAlign: TextAlign.justify,
          ),
          KVerticalSpacer(height: 14.h),

          /// Services List
          ...?data?.services.map(
            (service) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: OrganizationsAchievementsValueCard(
                leadingIconData: Icons.check_circle,
                achievementDescription: service.name,
                leadingIconColor: theme.primaryColor,
                isSubTitle: true,
                subTitle: service.description,
              ),
            ),
          ),

          KVerticalSpacer(height: 20.h),
          KText(
            text: "Industries we serve",
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            textAlign: TextAlign.start,
            color: theme.primaryColor,
            isUnderline: true,
            underlineColor: theme.primaryColor,
          ),
          KVerticalSpacer(height: 14.h),
          KText(
            text: data?.industriesDescription ?? '',
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: theme.textTheme.headlineLarge?.color, //AppColors.titleColor,
            textAlign: TextAlign.justify,
          ),
          KVerticalSpacer(height: 14.h),

          /// Industries List
          ...?data?.industries.map(
            (industry) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: OrganizationsAchievementsValueCard(
                leadingIconData: Icons.business,
                achievementDescription: industry.name,
                leadingIconColor: theme.primaryColor,
                isSubTitle: true,
                subTitle: industry.description,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
