import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:google_fonts/google_fonts.dart';

class OrganizationsTeamDesignationMemberCountHeading extends StatelessWidget {
  final String teamDesignation;
  final String teamTotalMemberCount;

  const OrganizationsTeamDesignationMemberCountHeading({
    super.key,
    required this.teamDesignation,
    required this.teamTotalMemberCount,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Administrative
        KText(
          text: teamDesignation,
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
          textAlign: TextAlign.start,
          color: theme.textTheme.headlineLarge?.color, //AppColors.titleColor,
        ),

        Text.rich(
          TextSpan(
            text: 'Members: ',
            style: GoogleFonts.sora(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                text: teamTotalMemberCount,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
