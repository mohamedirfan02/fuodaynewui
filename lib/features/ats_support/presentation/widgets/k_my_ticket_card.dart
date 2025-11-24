import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';

enum TicketStatus { open, inProgress, completed }

class MyTicketCard extends StatelessWidget {
  final String title;
  final String date;
  final TicketStatus status;
  final VoidCallback? onTap; // ✅ Added onTap callback

  const MyTicketCard({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    this.onTap, // ✅ optional
  });

  // Dark color for text based on status
  Color _statusColor(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    switch (status) {
      case TicketStatus.open:
        return isDark
            ? const Color(0xFFFCA5A5) // Light Red text for dark mode
            : const Color(0xFFEF4444);
      case TicketStatus.inProgress:
        return isDark
            ? const Color(0xFFFCD34D) // Soft Yellow
            : const Color(0xFFF59E0B);
      case TicketStatus.completed:
        return isDark
            ? const Color(0xFF6EE7B7) // Mint Green
            : const Color(0xFF10B981);
    }
  }

  // Light color for background based on status
  Color _statusBackgroundColor(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    switch (status) {
      case TicketStatus.open:
        return isDark
            ? const Color(0xFF451A1A) // Dark Red BG
            : const Color(0xFFFEE2E2);
      case TicketStatus.inProgress:
        return isDark
            ? const Color(0xFF422006) // Dark Yellow BG
            : const Color(0xFFFEF3C7);

      case TicketStatus.completed:
        return isDark
            ? const Color(0xFF064E3B) // Dark Green BG
            : const Color(0xFFD1FAE5);
    }
  }

  // Status text
  String get _statusText {
    switch (status) {
      case TicketStatus.open:
        return "Open";
      case TicketStatus.inProgress:
        return "In Progress";
      case TicketStatus.completed:
        return "Solved";
    }
  }

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return InkWell(
      onTap: onTap, // ✅ Trigger callback when tapped
      borderRadius: BorderRadius.circular(16.r), // Smooth ripple effect
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: theme.secondaryHeaderColor, //AppColors.secondaryColor
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: isDark
                ? theme.textTheme.bodyLarge?.color ?? AppColors.greyColor
                : theme.secondaryHeaderColor,
            width: 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Title & Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KText(
                    text: title,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  KText(
                    text: date,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color:
                        theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            KHorizontalSpacer(width: 10.w),

            // Status Container
            Container(
              height: 25.h,
              width: 100.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: _statusBackgroundColor(context),
              ),
              child: Center(
                child: KText(
                  text: _statusText,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                  color: _statusColor(context),
                ),
              ),
            ),

            KHorizontalSpacer(width: 5.w),

            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 18.sp,
              color: theme.textTheme.bodyLarge?.color, //AppColors.greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
