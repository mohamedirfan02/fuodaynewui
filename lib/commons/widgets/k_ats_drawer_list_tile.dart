import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KAtsDrawerListTile extends StatelessWidget {
  final String drawerTitle;
  final VoidCallback drawerListTileOnTap;
  final IconData drawerLeadingIcon;
  final bool isSelected; // Add this parameter to track selection

  const KAtsDrawerListTile({
    super.key,
    required this.drawerTitle,
    required this.drawerListTileOnTap,
    required this.drawerLeadingIcon,
    this.isSelected = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: isSelected
            ? isDark
                  ? AppColors.softBlueDark
                  : AppColors
                        .softBlue // Highlight selected item
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
        border: isSelected
            ? Border.all(
                color: theme.secondaryHeaderColor.withOpacity(0.3),
                width: 1,
              )
            : null,
      ),
      child: ListTile(
        leading: Icon(
          drawerLeadingIcon,
          color: isSelected
              ? theme
                    .secondaryHeaderColor // Different color for selected
              : theme.textTheme.headlineLarge?.color, //AppColors.titleColor,,
        ),
        title: Text(drawerTitle),
        titleTextStyle: GoogleFonts.sora(
          fontWeight: isSelected
              ? FontWeight.w600
              : FontWeight.w500, // Bold for selected
          color: isSelected
              ? theme
                    .secondaryHeaderColor // Different color for selected
              : theme.textTheme.headlineLarge?.color,
          fontSize: 12.sp,
        ),
        trailing: isSelected
            ? Icon(
                Icons.arrow_forward_ios,
                size: 12.sp,
                color: theme.secondaryHeaderColor,
              )
            : null, // Show indicator for selected item
        onTap: () {
          HapticFeedback.mediumImpact();
          drawerListTileOnTap();
        },
      ),
    );
  }
}
