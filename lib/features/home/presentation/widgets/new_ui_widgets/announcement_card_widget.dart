import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: theme.secondaryHeaderColor, //AppColors.secondaryColor
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ), //BORDER COLOR
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            children: [
              Container(
                height: 20.h,
                width: 23.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5.w,
                    color:
                        theme.textTheme.bodyLarge?.color?.withValues(
                          alpha: 0.3,
                        ) ??
                        AppColors.greyColor,
                  ),
                  borderRadius: BorderRadius.circular(5.r),
                  color: theme.secondaryHeaderColor.withValues(alpha: 1),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssetsConstants.miceIcon,
                    width: 15.w,
                    height: 15.w,
                    colorFilter: ColorFilter.mode(
                      theme.textTheme.headlineLarge?.color?.withValues(
                            alpha: 0.5,
                          ) ??
                          Colors.black,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              KText(
                text: "Announcement",
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
              const Spacer(),
              Icon(Icons.more_vert, size: 20.sp),
            ],
          ),
          SizedBox(height: 16.h),

          // Announcement List
          announcementTile(
            img: AppAssetsConstants.celebRationIcon,
            title: "Diwali Celebration Event",
            subtitle:
                "We are excited to celebrate Diwali at the office! ......",
            showBadge: true,

            context: context,
          ),
          SizedBox(height: 12.h),
          announcementTile(
            img: AppAssetsConstants.systemIcon,
            title: "System Maintenance Alert",
            subtitle: "HRMS portal will be temporarily unavailable from ...",
            context: context,
          ),
          SizedBox(height: 12.h),
          announcementTile(
            img: AppAssetsConstants.micIconII,
            title: "Team Outing Announcement",
            subtitle: "A fun-filled team outing is planned to Wonderla!",
            context: context,
          ),
          SizedBox(height: 12.h),
          announcementTile(
            img: AppAssetsConstants.celebRationIcon,
            title: "Netify SaaS Real estate",
            subtitle: "In Juyed Ahmed’s List",
            context: context,
          ),
        ],
      ),
    );
  }

  Widget announcementTile({
    required String img,
    required String title,
    required String subtitle,
    bool showBadge = false,
    required BuildContext context,
  }) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ), //BORDER COLOR
        // color: Colors.white,
      ),
      child: Row(
        children: [
          // ⬇⬇ Updated SVG with circle + badge ⬇⬇
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 48.w,
                width: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        theme.textTheme.bodyLarge?.color?.withValues(
                          alpha: 0.3,
                        ) ??
                        AppColors.greyColor,
                  ),
                ),
                padding: EdgeInsets.all(10.w),
                child: _buildImage(img),
              ),

              if (showBadge)
                Positioned(
                  right: -1,
                  bottom: -1,
                  child: Container(
                    height: 13.w,
                    width: 13.w,
                    decoration: BoxDecoration(
                      color: AppColors.inProgressColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.secondaryHeaderColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // ⬆⬆ End of SVG + Badge UI ⬆⬆
          SizedBox(width: 12.w),

          // Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KText(
                  text: title,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3.h),
                KText(
                  text: subtitle,
                  fontSize: 12.sp,
                  color: Colors.grey,
                  maxLines: 1,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),

          Icon(Icons.arrow_forward_ios_rounded, size: 18.sp),
        ],
      ),
    );
  }

  Widget _buildImage(String img) {
    // Check whether image is SVG
    if (img.toLowerCase().endsWith(".svg")) {
      return SvgPicture.asset(img, fit: BoxFit.contain);
    } else {
      return Image.asset(img, fit: BoxFit.contain);
    }
  }
}
