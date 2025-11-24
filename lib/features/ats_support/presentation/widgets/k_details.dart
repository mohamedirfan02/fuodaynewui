import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class TicketDetailInfo extends StatelessWidget {
  final String user;
  final String phoneNumber;
  final String ticketStatus;
  final String priorityLevel;
  final String subject;
  final String submitted;
  final String ticketId;
  final String department;

  const TicketDetailInfo({
    super.key,
    required this.user,
    required this.phoneNumber,
    required this.ticketStatus,
    required this.priorityLevel,
    required this.subject,
    required this.submitted,
    required this.ticketId,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    // final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: theme.secondaryHeaderColor, //AppColors.secondaryColor
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildInfoRow('User', user, context),
          SizedBox(height: 20.h),
          _buildInfoRow('Phone Number', phoneNumber, context),
          SizedBox(height: 20.h),
          _buildInfoRow('Ticket Status', ticketStatus, context),
          SizedBox(height: 20.h),
          _buildInfoRow('Priority Level', priorityLevel, context),
          SizedBox(height: 20.h),
          _buildInfoRow('Subject', subject, context),
          SizedBox(height: 20.h),
          _buildInfoRow('Submitted', submitted, context),
          SizedBox(height: 20.h),
          _buildInfoRow('Ticket ID', ticketId, context),
          SizedBox(height: 20.h),
          _buildInfoRow('Department', department, context),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            //color: const Color(0xFF9CA3AF),
            color: theme.textTheme.bodyLarge?.color?.withValues(
              alpha: 0.8,
            ), //AppColors.greyColor,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
      ],
    );
  }
}
