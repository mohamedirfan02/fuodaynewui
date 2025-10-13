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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildInfoRow('User', user),
          SizedBox(height: 20.h),
          _buildInfoRow('Phone Number', phoneNumber),
          SizedBox(height: 20.h),
          _buildInfoRow('Ticket Status', ticketStatus),
          SizedBox(height: 20.h),
          _buildInfoRow('Priority Level', priorityLevel),
          SizedBox(height: 20.h),
          _buildInfoRow('Subject', subject),
          SizedBox(height: 20.h),
          _buildInfoRow('Submitted', submitted),
          SizedBox(height: 20.h),
          _buildInfoRow('Ticket ID', ticketId),
          SizedBox(height: 20.h),
          _buildInfoRow('Department', department),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF9CA3AF),
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
              color: const Color(0xFF6B7280),
            ),
          ),
        ),
      ],
    );
  }
}