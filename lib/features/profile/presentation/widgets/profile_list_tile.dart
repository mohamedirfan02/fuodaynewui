import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback? onTap;
  final Color? leadingIconColor;
  final Color? titleColor;
  final Color? trailingIconColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? fontSize;
  final EdgeInsets? padding;
  final bool showTrailingIcon;
  final IconData? trailingIcon;

  const ProfileListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.onTap,
    this.leadingIconColor,
    this.titleColor,
    this.trailingIconColor,
    this.borderColor,
    this.borderWidth,
    this.fontSize,
    this.padding,
    this.showTrailingIcon = true,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color:
                borderColor ??
                theme.textTheme.bodyLarge?.color?.withOpacity(0.5) ??
                AppColors.greyColor.withOpacity(0.5),
            width: borderWidth ?? 0.6,
          ),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding:
            padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
        leading: Icon(
          leadingIcon,
          color:
              leadingIconColor ??
              theme.textTheme.headlineLarge?.color, //AppColors.titleColor,,
        ),
        title: Text(title),
        titleTextStyle: GoogleFonts.sora(
          fontWeight: FontWeight.w600,
          color:
              titleColor ??
              theme.textTheme.headlineLarge?.color, //AppColors.titleColor,
          fontSize: fontSize ?? 12.sp,
        ),
        trailing: showTrailingIcon
            ? Icon(
                trailingIcon ?? Icons.arrow_forward_ios,
                color:
                    trailingIconColor ??
                    theme
                        .textTheme
                        .headlineLarge
                        ?.color, //AppColors.titleColor,
              )
            : null,
      ),
    );
  }
}
