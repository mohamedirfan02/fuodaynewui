import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class KnewAtsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool centerTitle;
  final IconData leadingIcon;
  final VoidCallback onLeadingIconPress;
  final VoidCallback onNotificationPressed;
  final String profilePhotoUrl;

  const KnewAtsAppBar({
    super.key,
    required this.title,
    this.subtitle,
    required this.centerTitle,
    required this.leadingIcon,
    required this.onLeadingIconPress,
    required this.onNotificationPressed,
    required this.profilePhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      centerTitle: centerTitle,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          onLeadingIconPress();
          HapticFeedback.mediumImpact();
        },
        icon: Icon(leadingIcon, color: AppColors.titleColor),
      ),
      title: Column(
        crossAxisAlignment:
        centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: GoogleFonts.sora(
              color: AppColors.titleColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: GoogleFonts.sora(
                color: AppColors.titleColor.withOpacity(0.7),
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),

      actions: [
        // 🔔 Notification Icon
        IconButton(
          onPressed: () {
            HapticFeedback.mediumImpact();
            onNotificationPressed();
          },
          icon: SvgPicture.asset(
            AppAssetsConstants.notificationIcon,
            height: 20,
            width: 20,
            fit: BoxFit.contain,
          ),
        ),

        // 👤 Profile Photo
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: KCircularCachedImage(
            imageUrl: profilePhotoUrl,
            size: 32.h,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
