import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KTeamDirectReportTile extends StatelessWidget {
  final String personName;
  final String personRole;
  final String personContact;
  final String avatarPersonFirstLetter;
  final Color avatarBgColor;

  const KTeamDirectReportTile({
    super.key,
    required this.personName,
    required this.personRole,
    required this.personContact,
    required this.avatarPersonFirstLetter,
    required this.avatarBgColor,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Stack(
      children: [
        // Content
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.w,
              color: theme.textTheme.bodyLarge?.color ?? AppColors.greyColor,
            ), //AppColors.greyColor,),
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
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Person name
              KText(
                text: personName,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: theme.textTheme.headlineLarge?.color, //AppColors.,
              ),

              // Role
              RichText(
                text: TextSpan(
                  text: 'Role: ',
                  style: GoogleFonts.sora(
                    color: theme.textTheme.headlineLarge?.color,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: personRole,
                      style: GoogleFonts.sora(
                        color: theme.primaryColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Contact
              RichText(
                text: TextSpan(
                  text: 'Contact: ',
                  style: GoogleFonts.sora(
                    color: theme.textTheme.headlineLarge?.color,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                  children: [
                    TextSpan(
                      text: personContact,
                      style: GoogleFonts.sora(
                        color: theme.primaryColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Circle Avatar
        Positioned(
          top: 10,
          right: 10,
          child: CircleAvatar(
            radius: 14.r,
            backgroundColor: avatarBgColor,
            child: KText(
              text: avatarPersonFirstLetter,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: theme.secondaryHeaderColor, //AppColors.secondaryColor
            ),
          ),
        ),
      ],
    );
  }
}
