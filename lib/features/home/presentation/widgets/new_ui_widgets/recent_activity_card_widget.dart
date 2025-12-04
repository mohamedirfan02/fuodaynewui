import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/constants/app_assets_constants.dart';

import 'package:fuoday/core/themes/app_colors.dart';

class RecentActivityWidget extends StatelessWidget {
  const RecentActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //s  final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: theme.secondaryHeaderColor, //AppColors.secondaryColor
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ), //BORDER COLOR
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                      child: Image.asset(
                        AppAssetsConstants.recentActivityImage,
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ),
                  KHorizontalSpacer(width: 5.w),
                  KText(
                    text: "Recent activity",
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.more_vert,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Main Items Container
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color:
                    theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
                    AppColors.greyColor,
              ),
            ),
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                activityBlock(
                  title: "Juyed Ahmed’s List",
                  tasks: [
                    ("Netify SaaS Real estate", "In Juyed Ahmed’s List"),
                    ("Netify SaaS Real estate", "In Juyed Ahmed’s List"),
                  ],
                  context: context,
                ),
                SizedBox(height: 16.h),
                activityBlock(
                  title: "Pixem’s Project",
                  tasks: [("MatexAI Meeting Assistance", "In Project 11")],
                  context: context,
                ),
                SizedBox(height: 16.h),
                activityBlock(
                  title: "Pixem’s Project",
                  tasks: [("Clinscey Task Management", "In Project 11")],
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget activityBlock({
    required String title,
    required List<(String, String)> tasks,
    required BuildContext context,
  }) {
    //App Theme Data
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.format_list_bulleted,
              size: 20,
              color: theme.textTheme.bodyLarge?.color,
            ),
            SizedBox(width: 6.w),
            Text(
              title,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Icon(Icons.more_vert, color: theme.textTheme.bodyLarge?.color),
          ],
        ),
        const SizedBox(height: 10),
        for (var (taskTitle, taskSub) in tasks) ...[
          taskTile(taskTitle, taskSub, context),
          const SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget taskTile(String title, String subtitle, BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(
          color:
              theme.textTheme.bodyLarge?.color?.withValues(alpha: 0.3) ??
              AppColors.greyColor,
        ), //BORDER COLOR),
        borderRadius: BorderRadius.circular(8),
        // color: const Color(0xfff8f8f8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 8,
            backgroundColor: theme.textTheme.bodyLarge?.color?.withValues(
              alpha: 0.2,
            ), //AppColors.greyColor,
            child: const CircleAvatar(
              radius: 5,
              backgroundColor: Colors.orange,
            ),
          ),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(
              " •  $subtitle",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
