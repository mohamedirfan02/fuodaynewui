import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class KUploadPickerTile extends StatelessWidget {
  final String? uploadPickerTitle;
  final IconData uploadPickerIcon;
  final String description;
  final double? spacing;
  final VoidCallback uploadOnTap;
  final VoidCallback? onCancelTap;
  final VoidCallback? onViewTap;
  final bool showCancel;
  final bool showOnlyView;

  const KUploadPickerTile({
    super.key,
    this.uploadPickerTitle,
    required this.uploadPickerIcon,
    required this.description,
    this.spacing,
    required this.uploadOnTap,
    this.onCancelTap,
    this.showCancel = false,
    this.showOnlyView = false,
    this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Stack(
      children: [
        Column(
          spacing: spacing ?? 6.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (uploadPickerTitle != null)
              KText(
                text: uploadPickerTitle!,
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            GestureDetector(
              onTap: uploadOnTap,
              child: DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  dashPattern: [5, 5],
                  strokeWidth: 1,
                  color:
                      theme.textTheme.bodyLarge?.color ??
                      AppColors.greyColor, //AppColors.greyColor,
                  radius: Radius.circular(8.r),
                ),
                child: Container(
                  height: 80.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDark
                          ? AppColors.cardGradientColorDark
                          : AppColors.cardGradientColor,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      spacing: 12.h,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          uploadPickerIcon,
                          color: theme.textTheme.bodyLarge?.color?.withOpacity(
                            0.8,
                          ),
                          size: 22.h,
                        ),
                        KText(
                          textAlign: TextAlign.center,
                          color: theme.textTheme.bodyLarge?.color?.withOpacity(
                            0.8,
                          ),
                          text: description,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        if (showCancel || showOnlyView)
          Positioned(
            top: 0,
            right: 0,
            child: Row(
              spacing: 16.w,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // View btn
                GestureDetector(
                  onTap: onViewTap,
                  child: Row(
                    spacing: 1.w,
                    children: [
                      Icon(
                        Icons.remove_red_eye,
                        color: theme.textTheme.bodyLarge?.color,
                        size: 12.w,
                      ),
                      KText(
                        text: "View",
                        fontWeight: FontWeight.w500,
                        color: theme.textTheme.bodyLarge?.color,
                        fontSize: 10.sp,
                      ),
                    ],
                  ),
                ),

                // Cancel btn
                GestureDetector(
                  onTap: onCancelTap,
                  child: Row(
                    spacing: 1.w,
                    children: [
                      Icon(
                        Icons.cancel,
                        color: theme.textTheme.bodyLarge?.color,
                        size: 12.w,
                      ),
                      KText(
                        text: "Cancel",
                        fontWeight: FontWeight.w500,
                        color: theme.textTheme.bodyLarge?.color,
                        fontSize: 10.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
