import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganizationsTeamMemberTile extends StatelessWidget {
  final Color leadingAvatarBgColor;
  final String teamMemberNameFirstLetter;
  final String teamMemberName;
  final String teamMemberDesignation;

  const OrganizationsTeamMemberTile({
    super.key,
    required this.leadingAvatarBgColor,
    required this.teamMemberNameFirstLetter,
    required this.teamMemberName,
    required this.teamMemberDesignation,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
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
        contentPadding: EdgeInsets.all(6.w),
        leading: CircleAvatar(
          backgroundColor: leadingAvatarBgColor,
          radius: 28.r,
          child: Text(
            teamMemberNameFirstLetter,
            style: GoogleFonts.sora(
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
              color: theme.secondaryHeaderColor, //AppColors.secondaryColor,,
            ),
          ),
        ),
        title: Text(teamMemberName),
        titleTextStyle: GoogleFonts.sora(
          color: theme.textTheme.headlineLarge?.color, //AppColors.titleColor,,
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
        subtitle: Text(teamMemberDesignation),
        subtitleTextStyle: GoogleFonts.sora(
          color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,,
          fontWeight: FontWeight.w400,
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
