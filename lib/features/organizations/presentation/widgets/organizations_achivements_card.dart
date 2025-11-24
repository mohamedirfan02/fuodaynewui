import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganizationsAchievementsValueCard extends StatelessWidget {
  final IconData leadingIconData;
  final String achievementDescription;
  final Color leadingIconColor;
  final bool isSubTitle;
  final String? subTitle;

  const OrganizationsAchievementsValueCard({
    super.key,
    required this.leadingIconData,
    required this.achievementDescription,
    required this.leadingIconColor,
    this.isSubTitle = false,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: theme.textTheme.bodyLarge?.color ?? AppColors.greyColor,
          width: 0.1.w,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(10.w),
        leading: Icon(leadingIconData, color: leadingIconColor, size: 24.w),
        title: Text(achievementDescription),
        titleTextStyle: GoogleFonts.sora(
          color: theme.textTheme.headlineLarge?.color, //AppColors.titleColor,
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
        subtitle: isSubTitle && subTitle != null ? Text(subTitle!) : null,
        subtitleTextStyle: GoogleFonts.sora(
          color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
          fontWeight: FontWeight.w400,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
