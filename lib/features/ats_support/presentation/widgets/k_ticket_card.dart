import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';

enum TicketStatus { open, inProgress, completed }

class TicketCard extends StatelessWidget {
  final String title;
  final String userName;
  final String submittedDate;
  final String priority;
  final String ticketId;
  final TicketStatus status;
  final VoidCallback? onTap;
  final Widget? icon;

  const TicketCard({
    super.key,
    required this.title,
    required this.userName,
    required this.submittedDate,
    required this.priority,
    required this.ticketId,
    this.status = TicketStatus.open,
    this.onTap,
    this.icon,
  });

  Color get _statusColor {
    switch (status) {
      case TicketStatus.open:
        return const Color(0xFFEF4444); // Red
      case TicketStatus.inProgress:
        return const Color(0xFFF59E0B); // Orange/Yellow
      case TicketStatus.completed:
        return const Color(0xFF10B981); // Green
    }
  }

  Color get _statusBackgroundColor {
    switch (status) {
      case TicketStatus.open:
        return const Color(0xFFFEE2E2); // Light Red
      case TicketStatus.inProgress:
        return const Color(0xFFFEF3C7); // Light Orange
      case TicketStatus.completed:
        return const Color(0xFFD1FAE5); // Light Green
    }
  }

  String get _statusText {
    switch (status) {
      case TicketStatus.open:
        return 'OPEN';
      case TicketStatus.inProgress:
        return 'IN PROGRESS';
      case TicketStatus.completed:
        return 'COMPLETED';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badge Row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: _statusBackgroundColor,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    _statusText,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: _statusColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Icon and Title Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                if (icon != null) ...[?icon, SizedBox(width: 16.w)],

                // Title
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF111827),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 24.h),
            Divider(color: AppColors.lightGreyColor, thickness: 1, height: 1),

            SizedBox(height: 16.h),

            // User and Submitted Info
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        userName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF111827),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Submitted',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        submittedDate,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF111827),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Priority and Ticket ID Info
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Priority',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        priority,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF111827),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ticket ID',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        ticketId,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF111827),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
