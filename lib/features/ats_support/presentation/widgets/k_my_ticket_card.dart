import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/commons/widgets/k_horizontal_spacer.dart';
import 'package:fuoday/commons/widgets/k_text.dart';

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
  Color get _statusColor {
    switch (status) {
      case TicketStatus.open:
        return const Color(0xFFEF4444); // Dark Red
      case TicketStatus.inProgress:
        return const Color(0xFFF59E0B); // Dark Yellow
      case TicketStatus.completed:
        return const Color(0xFF10B981); // Dark Green
    }
  }

  // Light color for background based on status
  Color get _statusBackgroundColor {
    switch (status) {
      case TicketStatus.open:
        return const Color(0xFFFEE2E2); // Light Red
      case TicketStatus.inProgress:
        return const Color(0xFFFEF3C7); // Light Yellow
      case TicketStatus.completed:
        return const Color(0xFFD1FAE5); // Light Green
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
    return InkWell(
      onTap: onTap, // ✅ Trigger callback when tapped
      borderRadius: BorderRadius.circular(16.r), // Smooth ripple effect
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
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
                    color: Colors.grey[600],
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
                borderRadius: BorderRadius.circular(30),
                color: _statusBackgroundColor,
              ),
              child: Center(
                child: KText(
                  text: _statusText,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                  color: _statusColor,
                ),
              ),
            ),

            KHorizontalSpacer(width: 5.w),

            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 18.sp,
              color: Colors.grey[700],
            ),
          ],
        ),
      ),
    );
  }
}
