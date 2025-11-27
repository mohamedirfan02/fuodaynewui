import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle; // Optional subtitle
  final bool centerTitle;
  final IconData leadingIcon;
  final List<Widget>? actionsWidgets;
  final VoidCallback onLeadingIconPress;

  const KAppBar({
    super.key,
    required this.title,
    this.subtitle, // Not required
    required this.centerTitle,
    required this.leadingIcon,
    this.actionsWidgets,
    required this.onLeadingIconPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.primaryColor, // AppColors.primaryColor,
      centerTitle: centerTitle,
      elevation: 0,
      title: Column(
        crossAxisAlignment: centerTitle
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: GoogleFonts.sora(
              color: theme.secondaryHeaderColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: GoogleFonts.sora(
                color: theme.secondaryHeaderColor.withOpacity(
                  0.8,
                ), //                color: AppColors.secondaryColor.withOpacity(0.8),

                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
      leading: IconButton(
        onPressed: () {
          onLeadingIconPress();
          HapticFeedback.mediumImpact();
        },
        icon: Icon(leadingIcon, color: theme.secondaryHeaderColor),
      ),
      actions: actionsWidgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
