import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KAtsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool centerTitle;
  final IconData leadingIcon;
  final VoidCallback onLeadingIconPress;

  /// Optional: Notification & Profile
  final VoidCallback? onNotificationPressed;
  final String? cachedNetworkImageUrl;
  final VoidCallback? onProfilePressed;

  /// Optional: Any extra action widgets
  final List<Widget>? actionsWidgets;

  const KAtsAppBar({
    super.key,
    required this.title,
    this.subtitle,
    required this.centerTitle,
    required this.leadingIcon,
    required this.onLeadingIconPress,
    this.onNotificationPressed,
    this.cachedNetworkImageUrl,
    this.onProfilePressed,
    this.actionsWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
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
              color: AppColors.secondaryColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: GoogleFonts.sora(
                color: AppColors.secondaryColor.withOpacity(0.8),
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
        icon: Icon(leadingIcon, color: AppColors.greyColor),
      ),
      actions: [
        // 🔔 Notification Icon (only if provided)
        if (onNotificationPressed != null)
          IconButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              onNotificationPressed?.call();
            },
            icon: SvgPicture.asset(
              AppAssetsConstants.notificationIcon,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
            ),
          ),

        // 👤 Profile Image (only if provided)
        if (cachedNetworkImageUrl != null)
          GestureDetector(
            onTap: onProfilePressed,
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: KCircularCachedImage(
                imageUrl: cachedNetworkImageUrl!,
                size: 32.h,
                fit: BoxFit.cover,
              ),
            ),
          ),

        // Any extra widgets you want
        if (actionsWidgets != null) ...actionsWidgets!,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
