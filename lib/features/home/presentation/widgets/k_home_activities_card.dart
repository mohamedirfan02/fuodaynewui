import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fuoday/commons/widgets/k_circular_cache_image.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class KHomeActivitiesCard extends StatelessWidget {
  final String svgImage;
  final Color cardImgBgColor;
  final String cardTitle;
  final String members;
  final String count;
  final Color bgChipColor;
  final bool isBirthdayCard;
  final List<String> avatarUrls;
  final VoidCallback onTap;
  final double? height;
  final double? width;

  const KHomeActivitiesCard({
    super.key,
    required this.svgImage,
    required this.cardImgBgColor,
    required this.cardTitle,
    required this.members,
    required this.count,
    required this.bgChipColor,
    this.isBirthdayCard = false,
    this.avatarUrls = const [],
    required this.onTap,
    this.height,
    this.width, // default empty
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();

        onTap();
      },
      child: Container(
        height: height ?? 180.h,
        width: width ?? 180.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.secondaryColor,
          border: Border.all(color: AppColors.cardBorderColor, width: 1.w),
        ),
        child: Column(
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 0.16.sh,
              width: double.infinity,
              decoration: BoxDecoration(
                color: cardImgBgColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
              ),
              child: Center(
                child: SvgPicture.asset(
                  svgImage,
                  height: 80.h,
                  width: 80.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 11.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    text: cardTitle,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Members
                      Chip(
                        label: Text(members),
                        backgroundColor: bgChipColor,
                        labelStyle: GoogleFonts.sora(
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondaryColor,
                        ),
                      ),

                      // Avatars or Count
                      isBirthdayCard
                          ? SizedBox(
                              height: 30.h,
                              width: 70.w,
                              child: Stack(
                                children: avatarUrls.asMap().entries.map((
                                  entry,
                                ) {
                                  int index = entry.key;
                                  String url = entry.value;

                                  return Positioned(
                                    left: (index * 20).w,
                                    child: KCircularCachedImage(
                                      imageUrl: url,
                                      size: 20.w,
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          : Chip(
                              label: Text(count),
                              backgroundColor: bgChipColor,
                              labelStyle: GoogleFonts.sora(
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
