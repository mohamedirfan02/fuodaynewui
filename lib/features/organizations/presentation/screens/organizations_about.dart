import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/commons/widgets/k_vertical_spacer.dart';
import 'package:fuoday/core/di/injection.dart';
import 'package:fuoday/core/service/hive_storage_service.dart';
import 'package:fuoday/features/organizations/presentation/widgets/organizations_achivements_card.dart';
import 'package:fuoday/features/organizations/presentation/widgets/organizations_image_carousel.dart';
import 'package:fuoday/features/organizations/presentation/providers/organization_about_provider.dart';
import 'package:provider/provider.dart';

class OrganizationsAbout extends StatefulWidget {
  const OrganizationsAbout({super.key});

  @override
  State<OrganizationsAbout> createState() => _OrganizationsAboutState();
}

class _OrganizationsAboutState extends State<OrganizationsAbout> {
  @override
  void initState() {
    super.initState();

    final webUserId = getIt<HiveStorageService>()
        .employeeDetails?['web_user_id']
        ?.toString();

    if (webUserId != null) {
      final provider = context.read<OrganizationAboutProvider>();
      provider.fetchAboutData(webUserId);
    } else {
      // Optionally handle null webUserId
      debugPrint("webUserId is null. Cannot fetch organization data.");
    }
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;
    return Consumer<OrganizationAboutProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: theme.primaryColor),
          );
        }

        if (provider.error != null) {
          return Center(child: Text(provider.error!));
        }

        final about = provider.aboutData;
        if (about == null) return const SizedBox.shrink();

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KText(
                text: "About Us",
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                textAlign: TextAlign.start,
                color: theme.primaryColor,
                isUnderline: true,
                underlineColor: theme.primaryColor,
              ),
              KVerticalSpacer(height: 14.h),
              KText(
                text: about.aboutDescription,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: theme
                    .textTheme
                    .headlineLarge
                    ?.color, //AppColors.titleColor,
                textAlign: TextAlign.justify,
              ),

              KVerticalSpacer(height: 14.h),
              KText(
                text: "Achievements",
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                textAlign: TextAlign.start,
                color: theme.primaryColor,
                isUnderline: true,
                underlineColor: theme.primaryColor,
              ),
              KVerticalSpacer(height: 10.h),

              ...about.achievements.map(
                (achieve) => Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: OrganizationsAchievementsValueCard(
                    leadingIconData: Icons.celebration,
                    achievementDescription: achieve,
                    leadingIconColor: theme.primaryColor,
                  ),
                ),
              ),

              KVerticalSpacer(height: 14.h),
              KText(
                text: "Our Values",
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                textAlign: TextAlign.start,
                color: theme.primaryColor,
                isUnderline: true,
                underlineColor: theme.primaryColor,
              ),
              KVerticalSpacer(height: 10.h),

              ...about.values.map(
                (value) => Padding(
                  padding: EdgeInsets.only(bottom: 6.h),
                  child: OrganizationsAchievementsValueCard(
                    leadingIconData: Icons.lightbulb,
                    achievementDescription: value,
                    leadingIconColor: theme.primaryColor,
                  ),
                ),
              ),

              KVerticalSpacer(height: 14.h),
              KText(
                text: "Our Clients",
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                textAlign: TextAlign.start,
                color: theme.primaryColor,
                isUnderline: true,
                underlineColor: theme.primaryColor,
              ),
              KVerticalSpacer(height: 14.h),
              KText(
                text: about.clientDescription.isNotEmpty
                    ? about.clientDescription
                    : "We collaborate with a diverse range of clients who trust us to deliver innovative and effective solutions.",
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: theme
                    .textTheme
                    .headlineLarge
                    ?.color, //AppColors.titleColor,
                textAlign: TextAlign.justify,
              ),

              KVerticalSpacer(height: 14.h),
              OrganizationsImageCarousel(
                imageUrls: about.clients.map((c) => c.logo).toList(),
              ),
              KVerticalSpacer(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
