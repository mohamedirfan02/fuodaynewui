import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class AtsKAppBarWithDrawer extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onDrawerPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback onNotificationPressed;
  final String userName;
  final String cachedNetworkImageUrl;
  final String userDesignation;
  final bool showUserInfo; // New boolean parameter

  const AtsKAppBarWithDrawer({
    super.key,
    required this.onDrawerPressed,
    this.backgroundColor,
    this.iconColor,
    required this.onNotificationPressed,
    required this.userName,
    required this.userDesignation,
    required this.cachedNetworkImageUrl,
    this.showUserInfo = true, // Default to true
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: !showUserInfo,
      backgroundColor: AppColors.secondaryColor,
      leading: IconButton(
        onPressed: onDrawerPressed ?? () {},
        icon: Icon(Icons.menu, color: iconColor ?? AppColors.titleColor),
      ),
      title: showUserInfo
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          KText(
            text: userName,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: AppColors.secondaryColor,
          ),
          KText(
            text: userDesignation,
            fontWeight: FontWeight.w500,
            fontSize: 10.sp,
            color: AppColors.secondaryColor,
          ),
        ],
      )
          : null,

      actions: [
        // Notification button
        Builder(
          builder: (ctx) => IconButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              ScaffoldMessenger.of(ctx).showSnackBar(
                const SnackBar(
                  content: Text("It will be added in a future update"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: Icon(Icons.notifications, color: AppColors.titleColor),
          ),
        ),
        // Show user profile photo only when showUserInfo is true
        if (showUserInfo) ...[
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: KCircularCachedImage(
              imageUrl: cachedNetworkImageUrl,
              size: 35.h, // Smaller size for AppBar
              fit: BoxFit.cover,
            ),
          ),
        ],

      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}